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
    input  wire [`data_width-1:0] din_pin,   // external DIN bus from top

    output wire [`data_width-1:0] dout_pin,  // external DOUT bus to top
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

    wire clk_int_tmp;

    PADI  set_dont_touch_in_clk          (.PAD(clk_pin),   .OUT(clk_int_tmp));
    BUFX8 set_dont_touch_root_clk_buf    (.A(clk_int_tmp), .Y(clk_int));
    PADI  set_dont_touch_in_rst          (.PAD(rst_pin),   .OUT(rst_int));
    PADI  set_dont_touch_in_start        (.PAD(start_pin), .OUT(start_int));

    // din[31:0]
    PADI set_dont_touch_din00  (.PAD(din_pin[0]), .OUT(din_int[0]));
    PADI set_dont_touch_din01  (.PAD(din_pin[1]), .OUT(din_int[1]));
    PADI set_dont_touch_din02  (.PAD(din_pin[2]), .OUT(din_int[2]));
    PADI set_dont_touch_din03  (.PAD(din_pin[3]), .OUT(din_int[3]));
    PADI set_dont_touch_din04  (.PAD(din_pin[4]), .OUT(din_int[4]));
    PADI set_dont_touch_din05  (.PAD(din_pin[5]), .OUT(din_int[5]));
    PADI set_dont_touch_din06  (.PAD(din_pin[6]), .OUT(din_int[6]));
    PADI set_dont_touch_din07  (.PAD(din_pin[7]), .OUT(din_int[7]));
    PADI set_dont_touch_din08  (.PAD(din_pin[8]), .OUT(din_int[8]));
    PADI set_dont_touch_din09  (.PAD(din_pin[9]), .OUT(din_int[9]));
    PADI set_dont_touch_din10  (.PAD(din_pin[10]), .OUT(din_int[10]));
    PADI set_dont_touch_din11  (.PAD(din_pin[11]), .OUT(din_int[11]));
    PADI set_dont_touch_din12  (.PAD(din_pin[12]), .OUT(din_int[12]));
    PADI set_dont_touch_din13  (.PAD(din_pin[13]), .OUT(din_int[13]));
    PADI set_dont_touch_din14  (.PAD(din_pin[14]), .OUT(din_int[14]));
    PADI set_dont_touch_din15  (.PAD(din_pin[15]), .OUT(din_int[15]));
    PADI set_dont_touch_din16  (.PAD(din_pin[16]), .OUT(din_int[16]));
    PADI set_dont_touch_din17  (.PAD(din_pin[17]), .OUT(din_int[17]));
    PADI set_dont_touch_din18  (.PAD(din_pin[18]), .OUT(din_int[18]));
    PADI set_dont_touch_din19  (.PAD(din_pin[19]), .OUT(din_int[19]));
    PADI set_dont_touch_din20  (.PAD(din_pin[20]), .OUT(din_int[20]));
    PADI set_dont_touch_din21  (.PAD(din_pin[21]), .OUT(din_int[21]));
    PADI set_dont_touch_din22  (.PAD(din_pin[22]), .OUT(din_int[22]));
    PADI set_dont_touch_din23  (.PAD(din_pin[23]), .OUT(din_int[23]));
    PADI set_dont_touch_din24  (.PAD(din_pin[24]), .OUT(din_int[24]));
    PADI set_dont_touch_din25  (.PAD(din_pin[25]), .OUT(din_int[25]));
    PADI set_dont_touch_din26  (.PAD(din_pin[26]), .OUT(din_int[26]));
    PADI set_dont_touch_din27  (.PAD(din_pin[27]), .OUT(din_int[27]));
    PADI set_dont_touch_din28  (.PAD(din_pin[28]), .OUT(din_int[28]));
    PADI set_dont_touch_din29  (.PAD(din_pin[29]), .OUT(din_int[29]));
    PADI set_dont_touch_din30  (.PAD(din_pin[30]), .OUT(din_int[30]));
    PADI set_dont_touch_din31  (.PAD(din_pin[31]), .OUT(din_int[31]));

    /////////////////////////////////////////////////////////////////
    // OUTPUT PADS
    // PADO: .IN(internal net) -> .PAD(external pin)
    /////////////////////////////////////////////////////////////////

    // dout[31:0]
    PADO set_dont_touch_dout00 (.IN(dout_int[0]), .PAD(dout_pin[0]));
    PADO set_dont_touch_dout01 (.IN(dout_int[1]), .PAD(dout_pin[1]));
    PADO set_dont_touch_dout02 (.IN(dout_int[2]), .PAD(dout_pin[2]));
    PADO set_dont_touch_dout03 (.IN(dout_int[3]), .PAD(dout_pin[3]));
    PADO set_dont_touch_dout04 (.IN(dout_int[4]), .PAD(dout_pin[4]));
    PADO set_dont_touch_dout05 (.IN(dout_int[5]), .PAD(dout_pin[5]));
    PADO set_dont_touch_dout06 (.IN(dout_int[6]), .PAD(dout_pin[6]));
    PADO set_dont_touch_dout07 (.IN(dout_int[7]), .PAD(dout_pin[7]));
    PADO set_dont_touch_dout08 (.IN(dout_int[8]), .PAD(dout_pin[8]));
    PADO set_dont_touch_dout09 (.IN(dout_int[9]), .PAD(dout_pin[9]));
    PADO set_dont_touch_dout10 (.IN(dout_int[10]), .PAD(dout_pin[10]));
    PADO set_dont_touch_dout11 (.IN(dout_int[11]), .PAD(dout_pin[11]));
    PADO set_dont_touch_dout12 (.IN(dout_int[12]), .PAD(dout_pin[12]));
    PADO set_dont_touch_dout13 (.IN(dout_int[13]), .PAD(dout_pin[13]));
    PADO set_dont_touch_dout14 (.IN(dout_int[14]), .PAD(dout_pin[14]));
    PADO set_dont_touch_dout15 (.IN(dout_int[15]), .PAD(dout_pin[15]));
    PADO set_dont_touch_dout16 (.IN(dout_int[16]), .PAD(dout_pin[16]));
    PADO set_dont_touch_dout17 (.IN(dout_int[17]), .PAD(dout_pin[17]));
    PADO set_dont_touch_dout18 (.IN(dout_int[18]), .PAD(dout_pin[18]));
    PADO set_dont_touch_dout19 (.IN(dout_int[19]), .PAD(dout_pin[19]));
    PADO set_dont_touch_dout20 (.IN(dout_int[20]), .PAD(dout_pin[20]));
    PADO set_dont_touch_dout21 (.IN(dout_int[21]), .PAD(dout_pin[21]));
    PADO set_dont_touch_dout22 (.IN(dout_int[22]), .PAD(dout_pin[22]));
    PADO set_dont_touch_dout23 (.IN(dout_int[23]), .PAD(dout_pin[23]));
    PADO set_dont_touch_dout24 (.IN(dout_int[24]), .PAD(dout_pin[24]));
    PADO set_dont_touch_dout25 (.IN(dout_int[25]), .PAD(dout_pin[25]));
    PADO set_dont_touch_dout26 (.IN(dout_int[26]), .PAD(dout_pin[26]));
    PADO set_dont_touch_dout27 (.IN(dout_int[27]), .PAD(dout_pin[27]));
    PADO set_dont_touch_dout28 (.IN(dout_int[28]), .PAD(dout_pin[28]));
    PADO set_dont_touch_dout29 (.IN(dout_int[29]), .PAD(dout_pin[29]));
    PADO set_dont_touch_dout30 (.IN(dout_int[30]), .PAD(dout_pin[30]));
    PADO set_dont_touch_dout31 (.IN(dout_int[31]), .PAD(dout_pin[31]));

    // done/err
    PADO set_dont_touch_done    (.IN(done_int),     .PAD(done_pin));
    PADO set_dont_touch_out_err (.IN(err_int),      .PAD(err_pin));
    PADO set_dont_touch_spare   (.IN(done_int),     .PAD(unuse_pin));

endmodule

