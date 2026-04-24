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


