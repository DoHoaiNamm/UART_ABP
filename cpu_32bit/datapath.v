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
