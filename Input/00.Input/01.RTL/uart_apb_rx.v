module uart_apb_rx(/*AUTOARG*/
   // Outputs
   rx_busy, wr_rx_fifo, data_to_rx_fifo, pe, fe, 
   be, 
   // Inputs
   pclk, resetn, uart_enable, u_lb, u_dls, u_eps, u_pen, fl_rx, sout, 
   syn_sin, brg_clken
   );
 `include "define.h"
parameter 	RX_IDLE 	= 3'd0;
parameter 	RX_DETECT 	= 3'd1;
parameter	RX_STARTBIT 	= 3'd2;
parameter	RX_DATA		= 3'd3;
parameter	RX_FINISH	= 3'd4;
parameter	RX_WRITE	= 3'd5;

//
// clock & reset
//
input		pclk;
input		resetn;
//
//internal input
//
input		uart_enable;
input		u_lb;
input	[1:0]	u_dls;
input	[1:0]	u_eps;
input		u_pen;
input	[3:0]	fl_rx;	
input		sout;
input		syn_sin;
input		brg_clken;
//
//internal output
//
output 		rx_busy;
output		wr_rx_fifo;
output	[7:0]	data_to_rx_fifo;
output		pe;
output		fe;
output		be;
reg		wr_rx_fifo;
reg		rx_busy;
reg   		parity_bit;
//reg 		parity;
reg	[9:0]	rx_shift;
reg	[2:0]	state;
reg	[2:0]	next_state;
reg		sin;
reg [7:0] data_to_rx_fifo;
reg [3:0] rx_count_clk;
reg [3:0] rx_count_bit;
//
//wire
//
wire 	[7:0] 	data_shift;
wire 		rx_mid_bit;
wire 		rx_end_frame;
//
//rx mid bit
//
assign rx_mid_bit = brg_clken &( & rx_count_clk[2:0]) & ( ~ rx_count_clk[3]);
assign rx_end_frame	= rx_mid_bit & (rx_count_bit == fl_rx);
//GENERATE STATE MACHINE
//
always @(*) begin
if(u_lb) sin = sout;
else sin = syn_sin;
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
if(!resetn) state  <=`DELAY  RX_IDLE;
else state  <=`DELAY  next_state;
end
//
//generate state
//
always @(*) begin
	next_state = RX_IDLE;
	rx_busy = 1'b0;
	wr_rx_fifo =1'b0;
	if(uart_enable) begin
	casex(state) // synopsys parallel_case 
		RX_IDLE: begin
			rx_busy = 1'b0;
			wr_rx_fifo =1'b0;
			if(uart_enable & sin) next_state = RX_DETECT;
			else next_state = RX_IDLE;
		end
		RX_DETECT: begin
			rx_busy = 1'b0;
			wr_rx_fifo =1'b0;
			casex({uart_enable , sin}) // synopsys parallel_case 
				2'b0x:  next_state = RX_IDLE;
				2'b10:  begin next_state = RX_STARTBIT;
					rx_busy = 1'b1;
				end
				default:  next_state = RX_DETECT;
			endcase
		end
		RX_STARTBIT: begin
			rx_busy = 1'b1;
			wr_rx_fifo =1'b0;
			casex({rx_mid_bit , sin}) 
				2'b10:  next_state = RX_DATA;
				2'b11:  next_state = RX_IDLE;
				default:  next_state = RX_STARTBIT;
			endcase
		end
		RX_DATA: begin 
			rx_busy = 1'b1;
			wr_rx_fifo =1'b0;
			if(rx_end_frame) next_state = RX_FINISH;
			else next_state = RX_DATA;
		end
		
		
		RX_FINISH: begin 
			rx_busy = 1'b1;
			wr_rx_fifo =1'b0;
			next_state = RX_WRITE;
		end
		RX_WRITE: begin 
			rx_busy = 1'b1;
			wr_rx_fifo =1'b1;
			next_state = RX_IDLE;
		end
		default : begin 
			rx_busy = 1'b0;
			wr_rx_fifo =1'b0;
			next_state = RX_IDLE;
		end
	endcase
end
end
//
// generate outputs, compatible with current state
//
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn)begin
			rx_shift[9:0] <=`DELAY  10'd0; 
			rx_count_clk  <=`DELAY  4'd0;
			rx_count_bit  <=`DELAY   4'd0;
		end
	else casex(next_state) // synopsys parallel_case 
		RX_IDLE: begin
			rx_shift[9:0] <=`DELAY  10'd0; 
			rx_count_clk  <=`DELAY  4'd0;
			rx_count_bit  <=`DELAY   4'd0;
		end
		RX_STARTBIT: if (brg_clken) rx_count_clk  <=`DELAY  rx_count_clk + 1'd1;
		RX_DATA: begin
			if (rx_mid_bit) begin 
				rx_shift[9:0] <=`DELAY  {sin,rx_shift[9:1]}; // load
				rx_count_bit  <=`DELAY  rx_count_bit + 1'd1;
			end
			if (brg_clken) rx_count_clk  <=`DELAY  rx_count_clk + 1'd1;
		end
		RX_FINISH: rx_shift[9:0] <=`DELAY  {sin,rx_shift[9:1]};
	endcase
end
//
// generate transmit-data
//

//
//generate parity bit
assign gen_parity = ^rx_shift[7:0];
assign pe = (parity_bit ^ rx_shift[8]) & u_pen;
always @(*) begin
	casex (u_eps[1:0]) // synopsys parallel_case 
	2'b1x: parity_bit = u_eps[0];
	2'b01: parity_bit = gen_parity;
	2'b00: parity_bit = ~gen_parity;
	endcase
end
assign	fe = ~rx_shift[9];
assign	be = ~(|rx_shift[9:0]);
//
//generate receive data
//

//
// shitf data 
//
assign data_shift = u_pen ? rx_shift[7:0] : rx_shift[8:1];
//
//select DLS
//

always @(*) begin
	data_to_rx_fifo = data_shift[7:0];
	case (u_dls[1:0]) // synopsys parallel_case 
	2'b11: data_to_rx_fifo = data_shift[7:0];
	2'b10: data_to_rx_fifo = {1'd0,data_shift[7:1]};
	2'b01: data_to_rx_fifo = {2'd0,data_shift[7:2]};
	2'b00: data_to_rx_fifo = {3'd0,data_shift[7:3]};
	endcase
end
endmodule

