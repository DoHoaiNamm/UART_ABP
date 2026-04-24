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

