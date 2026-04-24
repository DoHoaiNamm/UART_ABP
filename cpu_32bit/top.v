`include "cpu_config.vh"

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

