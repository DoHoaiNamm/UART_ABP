// 10-function ALU
//    not         (~ACC)
//    and         (ACC  & MDR)
//    or          (ACC  | MDR)
//    xor         (ACC  ^ MDR)
//    add         (ACC  + MDR)
//    sub         (ACC  - MDR)
//    shift-left  (ACC << MDR)
//    shift-right (ACC >> MDR)
//    mult        (ACC  * MDR)
//    div         (ACC  / MDR)
// 1 cycle ops: not, and, or, xor
// 2 cycle ops: add, sub, lshift, rshift
// 3 cycle ops: mult, div
//
// The master FSM accounts for the number of cycles needd for ALU ops
//

`include "../cpu_32bit/cpu_config.vh"

`ifdef PALLADIUM
module cpu_32bit__alu(clk, ain, bin, opcode, dout, zero, ovrfl);
    input         clk;
`else
module cpu_32bit__alu(ain, bin, opcode, dout, zero, ovrfl);
`endif
    parameter DATA_WIDTH = `data_width;

    input  [DATA_WIDTH-1:0]    ain, bin;
    input  [`opcode_width-1:0] opcode;
    output [DATA_WIDTH-1:0]    dout;
    output                     zero, ovrfl;

    reg [DATA_WIDTH-1:0] dout;
    reg                  zero, ovrfl;

`ifdef PALLADIUM
    always @ (posedge clk)
`else
    always @ (ain or bin or opcode)
`endif
    begin

`ifdef SIMULATION
        #`clk_period_80pct;
`else
`ifdef PALLADIUM
        @(negedge clk); // wait till negedge of clock
`endif
`endif

        ovrfl = 1'b0;
        case (opcode)
            `opc_not : begin
                dout = ~ain;
             end
            `opc_and : begin
                dout = ain & bin;
             end
            `opc_or  : begin
                dout = ain | bin;
             end
            `opc_xor : begin
                dout = ain ^ bin;
             end
            `opc_add : begin
`ifdef SIMULATION
                #`clk_period;
`else
`ifdef PALLADIUM
                @(posedge clk);
`endif
`endif
                {ovrfl, dout} = ain + bin;
             end
            `opc_sub : begin
`ifdef SIMULATION
                #`clk_period;
`else
`ifdef PALLADIUM
                @(posedge clk);
`endif
`endif
                {ovrfl, dout} = ain - bin;
             end
            `opc_lshift : begin
`ifdef SIMULATION
                #`clk_period;
`else
`ifdef PALLADIUM
                @(posedge clk);
`endif
`endif
                dout = ain << bin;
             end
            `opc_rshift : begin
`ifdef SIMULATION
                #`clk_period;
`else
`ifdef PALLADIUM
                @(posedge clk);//#`clk_period;
`endif
`endif
                dout = ain >> bin;
             end
            `opc_mult: begin
`ifdef SIMULATION
                #`clk_period;
                #`clk_period;
`else
`ifdef PALLADIUM
                @(posedge clk);
                @(posedge clk);
`endif
`endif
                {ovrfl, dout} = ain * bin;
             end
            `opc_div : begin
`ifdef SIMULATION
                #`clk_period;
                #`clk_period;
`else
`ifdef PALLADIUM
                 @(posedge clk);
                 @(posedge clk);
`endif
`endif
                {ovrfl, dout} = ain / bin;
             end
`ifdef OVERKILL
            `opc_jump , `opc_jumpz , `opc_jumpo : begin
                dout = ain;
             end
            `opc_load : begin
                dout = bin;
             end
`endif
             default : begin
                {ovrfl, dout} = {1'b0, {DATA_WIDTH{1'b0}}};
             end
        endcase
        zero = (dout == {DATA_WIDTH{1'b0}});
    end
endmodule


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// CPU with 4-bit instruction and 8-bit data.
// Has the following components -
// + Memory: 1-cycle read, 2-cycle write
// + FSM   : 16 state FSM
// + ALU   : 4-function ALU (add, xor, shift-left, shift-right)
// + DP    : PC, IR, ACC, MAR, MDR
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

`include "../cpu_32bit/cpu_config.vh"

`ifdef PALLADIUM
    `define PALLADIUM_or_SIMULATION
`else
    `ifdef SIMULATION
        `define PALLADIUM_or_SIMULATION
    `endif
`endif

module cpu_32bit (clk, rst, start, din, dout, done, err);
    input                    clk, rst, start;
    input  [`data_width-1:0] din;
    output [`data_width-1:0] dout;
    output                   done, err;

    wire mem_we, zero, ovrfl, err;
    wire [`opcode_width-1:0] opcode;
    wire pc_mux_sel, mar_mux_sel, acc_mux_sel;
    wire pc_load_en, mar_load_en, acc_load_en, ir_load_en;
    wire [`addr_width-1:0] mem_addr;
    wire [`data_width-1:0] mem_din, mem_qout, acc;
    wire from_fsm_shutoff_mem;
    wire from_fsm_shutoff_alu;


    CDK_S128x16_wrapper ram_wrapper (
        .clk  (clk),
        .en   (~from_fsm_shutoff_mem),
        .we   (mem_we),
        .addr (mem_addr),
        .din  (mem_din),
        .qout (mem_qout)
    );

    // DP
    cpu_32bit__dp
       DP(clk, rst, done,
          pc_mux_sel, acc_mux_sel, mar_mux_sel,
          pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en,
          zero_ovrfl_en, opcode, zero, ovrfl, acc,
          mem_addr, mem_din, mem_qout, din);
    assign dout = acc;

    // FSM
    cpu_32bit__fsm
       FSM(clk, rst, start, opcode,
           zero, ovrfl,
           pc_mux_sel, acc_mux_sel, mar_mux_sel,
           pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en,
           from_fsm_shutoff_mem, from_fsm_shutoff_alu,
           zero_ovrfl_en, mem_we, done, err);

endmodule

`include "../cpu_32bit/cpu_config.vh"

// Datapath : PC, IR, ACC, MAR, MDR
module cpu_32bit__dp(clk, rst, done,
                     pc_mux_sel, acc_mux_sel, mar_mux_sel,
                     pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en,
                     zero_ovrfl_en, opcode, zero, ovrfl, acc,
                     mem_addr, mem_din, mem_qout, din);

    input         clk, rst, done;
    input         pc_mux_sel, acc_mux_sel, mar_mux_sel;
    input         pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en;
    input         zero_ovrfl_en;
    //
    output [`opcode_width-1:0] opcode;
    output                    zero, ovrfl;
    output [`addr_width-1:0]   mem_addr;
    output [`data_width-1:0]   mem_din, acc;
    input  [`data_width-1:0]   mem_qout;
    input  [`data_width-1:0]   din; 

    wire [`addr_width-1:0] pc, pc_din, mar, mar_din;
    wire [`data_width-1:0] ir, acc_din, mdr, alu_dout;
    // wire [`opcode_width-1:0] ir_opcode;
    wire alu_zero, alu_ovrfl;

    wire rst_reg = (rst | done);

    // MDR/MAR
    reg_w_enable #(`data_width) MDR_reg(clk, rst_reg, mdr_load_en, mem_qout, mdr);
    reg_w_enable #(`addr_width) MAR_reg(clk, rst_reg, mar_load_en, mar_din, mar);
    assign mar_din = (mar_mux_sel ? ir[`addr_width-1:0] : pc);
    assign mem_addr = mar;

    // IR + opcode
    reg_w_enable #(`data_width) IR_reg(clk, rst_reg, ir_load_en, mdr, ir);
    // assign ir_opcode = ir[`data_width-1:`addr_width];
    assign opcode = ir[`data_width-1 : `data_width-`opcode_width];

    // PC
    reg_w_enable #(`addr_width) PC_reg(clk, rst_reg, pc_load_en, pc_din, pc);
//  assign pc_din = (pc_mux_sel ? ir[`addr_width-1:0] : pc + 1);
    assign pc_din = (pc_mux_sel ? ir[`addr_width-1:0] : pc + `addr_width'd1);

    // ACC
    reg_w_enable #(`data_width) ACC_reg(clk, rst_reg, acc_load_en, acc_din, acc);
    wire [`data_width-1:0] acc_din_pre;
    assign acc_din_pre = (acc_mux_sel ? alu_dout : mdr);
    assign acc_din = acc_din_pre ^ din;
    assign mem_din = acc;

    // ZERO/OVERFL flops
    reg_w_enable #(1) ZERO_reg(clk, rst_reg, zero_ovrfl_en, alu_zero, zero);
    reg_w_enable #(1) OVERFL_reg(clk, rst_reg, zero_ovrfl_en, alu_ovrfl, ovrfl);

    // ALU
`ifdef PALLADIUM
    cpu_32bit__alu ALU(.clk(clk), .ain(acc), .bin(mdr), 
      .opcode(opcode), .dout(alu_dout), .zero(alu_zero), .ovrfl(alu_ovrfl));
`else
    cpu_32bit__alu ALU(acc, mdr, opcode, alu_dout, alu_zero, alu_ovrfl);
`endif

endmodule

module reg_w_enable(clk, rst, en, din, qout);
    parameter WIDTH = 8;

    input clk, rst, en;
    input  [WIDTH-1:0] din;
    output [WIDTH-1:0] qout;

    reg [WIDTH-1:0] qout;
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
            qout <= {WIDTH{1'b0}};
        else if (en) qout <= din;
    end

endmodule
`include "../cpu_32bit/cpu_config.vh"

module cpu_32bit__fsm (
        clk, rst, start, opcode,
        zero, ovrfl,
        pc_mux_sel, acc_mux_sel, mar_mux_sel,
        pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en,
        from_fsm_shutoff_mem, from_fsm_shutoff_alu,
        zero_ovrfl_en, mem_we, done, err
    );

    input  clk, rst, start;
    input  zero, ovrfl; // ALU: zero, overflow
    input  [`opcode_width-1:0] opcode;

    output pc_mux_sel, acc_mux_sel, mar_mux_sel; // mux selects
    output pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en;
    output from_fsm_shutoff_mem, from_fsm_shutoff_alu;
    output zero_ovrfl_en;
           // load enables
    output mem_we;
    output done, err;

    // fsm register & states (see cpu_config.vh)
    /*
        init              =  0, // wait here for start signal
        //
        fet_cycle1      =  1, // load PC to MAR and load IR addr to PC
        fet_cycle2      =  2, // load MDR (read memory)
        fet_cycle3      =  3, // load IR (from MDR)
        //
        decode          =  4, // load IR addr to MAR, decode opcode
        load_mdr        =  5, // load MDR (read memory)
        //
        alu_cycle3      =  6, // 3-cycle op
        alu_cycle2      =  7, // 2-cycle op
        alu_cycle1      =  8, // load ACC 
        load_acc        =  9, // load ACC from MDR
        str_cycle1      = 10, // save ACC to memory
        str_cycle2      = 11, // save ACC to memory
        exec_jump       = 12, // load IR address to PC
        //
        error           = 15; // terminal state (stay here till reset)
    */
    reg [`fsm_pst_width-1:0] pst, nst; // pst = state reg, nst = next_state

    // some functions
    function automatic is_1cycle_op;
        input [`opcode_width-1:0] opc;
        is_1cycle_op = (~opc[3] & ~opc[2]) ? 1'b1 : 1'b0;
    endfunction
    function automatic is_2cycle_op;
        input [`opcode_width-1:0] opc;
        is_2cycle_op = (~opc[3] & opc[2]) ? 1'b1 : 1'b0;
    endfunction
    function automatic is_3cycle_op;
        input [`opcode_width-1:0] opc;
        is_3cycle_op = (opc[3] & ~opc[2] & ~opc[1]) ? 1'b1 : 1'b0;
    endfunction

    // state register
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
            pst = `init;
        else
            pst = nst;
    end

    // next_state logic
    always @ (pst or start or opcode or zero or ovrfl)
    begin
        nst = pst;
        case (pst)
            `init: if (start) nst = `fet_cycle1;

            `fet_cycle1: nst = `fet_cycle2;
            `fet_cycle2: nst = `fet_cycle3;
            `fet_cycle3: nst = `decode;

            `decode:
                case (opcode)
                    `opc_not   : nst = `load_mdr; // though mdr will be ignored
                    `opc_and   : nst = `load_mdr;
                    `opc_or    : nst = `load_mdr;
                    `opc_xor   : nst = `load_mdr;
                    `opc_add   : nst = `load_mdr;
                    `opc_sub   : nst = `load_mdr;
                    `opc_lshift: nst = `load_mdr;
                    `opc_rshift: nst = `load_mdr;
                    `opc_mult  : nst = `load_mdr;
                    `opc_div   : nst = `load_mdr;
                    `opc_load  : nst = `load_mdr;
                    `opc_store : nst = `str_cycle1;
                    `opc_jump  : nst = `exec_jump;
                    `opc_jumpz : nst = zero  ? `exec_jump : `fet_cycle1;
                    `opc_jumpo : nst = ovrfl ? `exec_jump : `fet_cycle1;
                    `opc_noop  : nst = `init;
                    default    : nst = `error;
                endcase
            `load_mdr :
                if (opcode == `opc_load)
                    nst = `load_acc;
                else if (is_3cycle_op(opcode))
                    nst = `alu_cycle3;
                else if (is_2cycle_op(opcode))
                    nst = `alu_cycle2;
                else
                    nst = `alu_cycle1;
                // how about? nst = error;

            `alu_cycle3: nst = `alu_cycle2;
            `alu_cycle2: nst = `alu_cycle1;
            `alu_cycle1: nst = `fet_cycle1;

            `load_acc: nst = `fet_cycle1;

            `str_cycle1: nst = `str_cycle2;
            `str_cycle2: nst = `fet_cycle1;
            `exec_jump   : nst = `fet_cycle1;

            `error  : nst = `error;
            default : nst = `fet_cycle1;
        endcase
    end

    // moore outputs
    reg mem_we, done, err;
    reg pc_mux_sel, acc_mux_sel, mar_mux_sel;
    reg pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en, zero_ovrfl_en;
    reg from_fsm_shutoff_mem, from_fsm_shutoff_alu;

    always @ (pst)
    begin
        pc_mux_sel = 1'b0; mar_mux_sel = 1'b0; acc_mux_sel = 1'b0;
        pc_load_en = 1'b0; mar_load_en = 1'b0; acc_load_en = 1'b0;
        ir_load_en = 1'b0; mdr_load_en = 1'b0; zero_ovrfl_en = 1'b0;
        mem_we = 1'b0;     done = 1'b0;        err = 1'b0;

        from_fsm_shutoff_mem = 1'b0; from_fsm_shutoff_alu = 1'b0;

        case (pst)
            `init : done = 1'b1;

            `fet_cycle1 : begin
                pc_load_en  = 1'b1;
                mar_load_en = 1'b1;
            end
            `fet_cycle2 :
                mdr_load_en = 1'b1;
            `fet_cycle3 :
                ir_load_en = 1'b1;

            `decode: begin
                mar_mux_sel = 1'b1;
                mar_load_en = 1'b1;
            end
            `load_mdr:
                mdr_load_en = 1'b1;

            `alu_cycle3: ; // do nothing
            `alu_cycle2: ; // do nothing
            `alu_cycle1: begin
                acc_mux_sel = 1'b1;
                acc_load_en = 1'b1;
                zero_ovrfl_en = 1'b1;
             end

            `load_acc: begin
                // acc_mux_sel = 1'b1;
                acc_load_en = 1'b1;
             end

            `str_cycle1: begin
                // mar_mux_sel = 1'b1;
                // mar_load_en = 1'b1;
                mem_we = 1'b1;
            end
            `str_cycle2: ; // do nothing mem_we = 1'b1;

            `exec_jump: begin
                pc_mux_sel = 1'b1;
                pc_load_en = 1'b1;
            end

            `error: err = 1'b1;

        endcase
    end

endmodule

/////////////////////////////////////////////////////////////////////
// io_wrapper.new.v
// Connects IO Pad Cells to Internal CPU Core Signals
//
// Naming convention (easy for synthesis constraints):
//   - All physical IO instances start with: set_dont_touch_
//   - Inputs : set_dont_touch_in_<signal>
//   - Outputs: set_dont_touch_out_<signal>
//   - Corners: set_dont_touch_corner_<ll/lr/ul/ur>
//   - Power  : set_dont_touch_vdd_<side>, set_dont_touch_vss_<side>
/////////////////////////////////////////////////////////////////////

module io_wrapper (
    // External chip pins
    input  wire                  clk_pin,
    input  wire                  rst_pin,
    input  wire                  start_pin,
    input  wire [`data_width-1:0] din_pin,   // external DIN[15:0] from top

    output wire [`data_width-1:0] dout_pin,  // external DOUT[15:0] to top
    output wire                  done_pin,
    output wire                  err_pin,
    output wire                  unuse_pin,

    // Internal connections to cpu_32bit core
    output wire                  clk_int,
    output wire                  rst_int,
    output wire                  start_int,
    output wire [`data_width-1:0] din_int,   // DIN bus into core

    input  wire [`data_width-1:0] dout_int,  // DOUT bus from core
    input  wire                  done_int,   // DONE from core
    input  wire                  err_int     // ERR from core
);

    /////////////////////////////////////////////////////////////////
    // CORNER + POWER PAD PLACEHOLDERS (Physical-only)
    // - 4x corner cells (PADCORNER) for IO ring corners
    // - 2x power pads per side: 1x PADVDD1 + 1x PADVSS1  => total 8 pads
    // - VDD/VSS nets are placeholders; connect in Innovus with globalNetConnect
    /////////////////////////////////////////////////////////////////

    // Corner cells (physical-only; no pins in LEF)
    PADCORNER set_dont_touch_corner_ll (); // lower-left
    PADCORNER set_dont_touch_corner_lr (); // lower-right
    PADCORNER set_dont_touch_corner_ul (); // upper-left
    PADCORNER set_dont_touch_corner_ur (); // upper-right

    // Power pads: 2 per side (1 VDD + 1 VSS)
    // TOP side
    PADVDD1 set_dont_touch_vddIO_top    (.VDD());
    PADVSS1 set_dont_touch_vssIO_top    (.VSS());

    // RIGHT side
    PADVDD1 set_dont_touch_vddCore_right  (.VDD());
    PADVSS1 set_dont_touch_vssCore_right  (.VSS());
       
    // BOTTOM side
    PADVDD1 set_dont_touch_vddIO_bottom (.VDD());
    PADVSS1 set_dont_touch_vssIO_bottom (.VSS());
    // LEFT side
    PADVDD1 set_dont_touch_vddCore_left   (.VDD());
    PADVSS1 set_dont_touch_vssCore_left   (.VSS());

    /////////////////////////////////////////////////////////////////
    // INPUT PADS
    // PADI: .PAD(external pin) -> .OUT(internal net)
    /////////////////////////////////////////////////////////////////

    PADI set_dont_touch_in_clk    (.PAD(clk_pin),     .OUT(clk_int));
    PADI set_dont_touch_in_rst    (.PAD(rst_pin),     .OUT(rst_int));
    PADI set_dont_touch_in_start  (.PAD(start_pin),   .OUT(start_int));

    // din[15:0]
    PADI set_dont_touch_din00  (.PAD(din_pin[0]),  .OUT(din_int[0]));
    PADI set_dont_touch_din01  (.PAD(din_pin[1]),  .OUT(din_int[1]));
    PADI set_dont_touch_din02  (.PAD(din_pin[2]),  .OUT(din_int[2]));
    PADI set_dont_touch_din03  (.PAD(din_pin[3]),  .OUT(din_int[3]));
    PADI set_dont_touch_din04  (.PAD(din_pin[4]),  .OUT(din_int[4]));
    PADI set_dont_touch_din05  (.PAD(din_pin[5]),  .OUT(din_int[5]));
    PADI set_dont_touch_din06  (.PAD(din_pin[6]),  .OUT(din_int[6]));
    PADI set_dont_touch_din07  (.PAD(din_pin[7]),  .OUT(din_int[7]));
    PADI set_dont_touch_din08  (.PAD(din_pin[8]),  .OUT(din_int[8]));
    PADI set_dont_touch_din09  (.PAD(din_pin[9]),  .OUT(din_int[9]));
    PADI set_dont_touch_din10  (.PAD(din_pin[10]), .OUT(din_int[10]));
    PADI set_dont_touch_din11  (.PAD(din_pin[11]), .OUT(din_int[11]));
    PADI set_dont_touch_din12  (.PAD(din_pin[12]), .OUT(din_int[12]));
    PADI set_dont_touch_din13  (.PAD(din_pin[13]), .OUT(din_int[13]));
    PADI set_dont_touch_din14  (.PAD(din_pin[14]), .OUT(din_int[14]));
    PADI set_dont_touch_din15  (.PAD(din_pin[15]), .OUT(din_int[15]));

    /////////////////////////////////////////////////////////////////
    // OUTPUT PADS
    // PADO: .IN(internal net) -> .PAD(external pin)
    /////////////////////////////////////////////////////////////////

    // dout[15:0]
    PADO set_dont_touch_dout00 (.IN(dout_int[0]),  .PAD(dout_pin[0]));
    PADO set_dont_touch_dout01 (.IN(dout_int[1]),  .PAD(dout_pin[1]));
    PADO set_dont_touch_dout02 (.IN(dout_int[2]),  .PAD(dout_pin[2]));
    PADO set_dont_touch_dout03 (.IN(dout_int[3]),  .PAD(dout_pin[3]));
    PADO set_dont_touch_dout04 (.IN(dout_int[4]),  .PAD(dout_pin[4]));
    PADO set_dont_touch_dout05 (.IN(dout_int[5]),  .PAD(dout_pin[5]));
    PADO set_dont_touch_dout06 (.IN(dout_int[6]),  .PAD(dout_pin[6]));
    PADO set_dont_touch_dout07 (.IN(dout_int[7]),  .PAD(dout_pin[7]));
    PADO set_dont_touch_dout08 (.IN(dout_int[8]),  .PAD(dout_pin[8]));
    PADO set_dont_touch_dout09 (.IN(dout_int[9]),  .PAD(dout_pin[9]));
    PADO set_dont_touch_dout10 (.IN(dout_int[10]), .PAD(dout_pin[10]));
    PADO set_dont_touch_dout11 (.IN(dout_int[11]), .PAD(dout_pin[11]));
    PADO set_dont_touch_dout12 (.IN(dout_int[12]), .PAD(dout_pin[12]));
    PADO set_dont_touch_dout13 (.IN(dout_int[13]), .PAD(dout_pin[13]));
    PADO set_dont_touch_dout14 (.IN(dout_int[14]), .PAD(dout_pin[14]));
    PADO set_dont_touch_dout15 (.IN(dout_int[15]), .PAD(dout_pin[15]));

    // done/err
    PADO set_dont_touch_done    (.IN(done_int),     .PAD(done_pin));
    PADO set_dont_touch_out_err (.IN(err_int),      .PAD(err_pin));
    PADO set_dont_touch_spare   (.IN(done_int),     .PAD(unuse_pin));

endmodule


`include "../cpu_32bit/cpu_config.vh"

module CDK_S128x16_wrapper (
    input                        clk,
    input                        en,    // active-HIGH enable
    input                        we,    // active-HIGH write enable
    input      [`addr_width-1:0] addr,
    input      [`data_width-1:0] din,
    output     [`data_width-1:0] qout
);

`ifdef UPSKILL
    // --------------------------------------------------------------
    // Hard macro instance: MEM2_128X16
    // Use Port 1 as our single port; tie Port 2 off.
    // CE1/CE2 are active-LOW, WE1/WE2 are active-HIGH.
    // --------------------------------------------------------------
    MEM2_128X16 u_ram128x16_hard (
        // ---------- Port 1: used ----------
        .CK1 (clk),                      // clock
        .CE1 (~en),                      // active-LOW enable (en=1 -> CE1=0)
        .WE1 (we),                       // write enable
        .A1  (addr),                     // [6:0] address
        .D1  (din),                      // [15:0] write data
        .Q1  (qout),                     // [15:0] read data

        // ---------- Port 2: unused ----------
        .CK2 (1'b0),                     // no clock activity
        .CE2 (1'b1),                     // disabled (active-LOW enable)
        .WE2 (1'b0),                     // no writes
        .A2  ({`addr_width{1'b0}}),      // 7'b0000000
        .D2  ({`data_width{1'b0}}),      // 16'b0
        .Q2  ()                          // unused
    );

`else
    // --------------------------------------------------------------
    // Synthesizable 128x16 RAM (single-port)
    // Interface is identical to wrapper ports.
    // --------------------------------------------------------------
    CDK_S128x16_SYNTHESIZE_RAM u_ram128x16_soft (
        .clk  (clk),
        .en   (en),
        .we   (we),
        .addr (addr),
        .din  (din),
        .qout (qout)
    );
`endif

endmodule

module CDK_S128x16_SYNTHESIZE_RAM (
    input              clk,
    input              en,      // enable
    input              we,      // write request
    input      [`addr_width-1:0]   addr,
    input      [`data_width-1:0]   din,
    output reg [`data_width-1:0]   qout
);

    // Main memory array
    reg [`data_width-1:0] mem [0:`ram_depth-1];  // [0:127] when ram_depth=128

    // 2-cycle write pipeline
    reg        we_d1;
    reg [`addr_width-1:0] addr_d1;
    reg [`data_width-1:0] din_d1;

    always @(posedge clk) begin
        if (en) begin

            // Stage 1: capture
            we_d1   <= we;
            addr_d1 <= addr;
            din_d1  <= din;

            // Stage 2: commit
            if (we_d1)
                mem[addr_d1] <= din_d1;

            // 1-cycle READ
            qout <= mem[addr];
        end
    end

endmodule

/////////////////////////////////////////////////////////////////////
// top.v
// Full Chip-Level Wrapper with Padframe + CPU Core
/////////////////////////////////////////////////////////////////////


module cpu_32bit_top (
    input  wire clk_pin,
    input  wire rst_pin,
    input  wire start_pin,
    input  wire [`data_width-1:0] din_pin,

    output wire [`data_width-1:0] dout_pin,
    output wire done_pin,
    output wire err_pin, 
    output wire unuse_pin 
);

    /////////////////////////////////////////////////////////////////
    // INTERNAL SIGNALS BETWEEN IO WRAPPER AND CORE
    /////////////////////////////////////////////////////////////////

    wire clk_int;
    wire rst_int;
    wire start_int;

    wire [`data_width-1:0] dout_int;
    wire [`data_width-1:0] din_int;
    wire       done_int;
    wire       err_int;

    /////////////////////////////////////////////////////////////////
    // IO WRAPPER INSTANCE
    /////////////////////////////////////////////////////////////////

    io_wrapper U_IO (
        .clk_pin(clk_pin),
        .clk_int(clk_int),

        .rst_pin(rst_pin),
        .rst_int(rst_int),

        .start_pin(start_pin),
        .start_int(start_int),

        .din_pin(din_pin),
        .din_int(din_int),

        .dout_pin(dout_pin),
        .dout_int(dout_int),


        .done_pin(done_pin),
        .done_int(done_int),

        .err_pin(err_pin),
        .err_int(err_int), 
        .unuse_pin(unuse_pin)

    );

    /////////////////////////////////////////////////////////////////
    // CPU CORE INSTANCE
    /////////////////////////////////////////////////////////////////

    cpu_32bit U_CORE (
        .clk(clk_int),
        .rst(rst_int),
        .start(start_int),
        .din(din_int),

        .dout(dout_int),
        .done(done_int),
        .err(err_int)
    );

endmodule

