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

