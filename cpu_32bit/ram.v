
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

