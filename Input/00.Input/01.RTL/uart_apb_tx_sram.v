`include "define.h"
module uart_apb_tx_sram(/*AUTOARG*/
   // Outputs
	tx_busy, uart_sout, rd_tx_fifo, sout, rd_tx_sram, tx_shift_empty, 
	tx_enable, 
   // Inputs
	pclk, resetn, uart_enable, u_halt, u_fifoe, tx_fifo_empty, 
	tx_buffer, u_bc, u_lb, u_dls, u_eps, u_pen, fl_tx, half_stop, 
	`ifdef  FIFO_MODE_USER
   `ifdef	MODEM_AUTOFLOW_USER
		auto_flow_cts,
	`endif
	`endif 
 brg_clken
   );
parameter 	TX_IDLE 	= 3'd0;
parameter	TX_BC		= 3'd1;
parameter	TX_LOAD		= 3'd2;
parameter	TX_STARTBIT	= 3'd3;
parameter	TX_DATA		= 3'd4;
parameter	TX_HALFSTOP	= 3'd5;
parameter	TX_WAIT		= 3'd6;
//
// clock & reset
//
input		pclk;
input		resetn;
//
//internal input
//
input		uart_enable;
input		u_halt;
input		u_fifoe;
input		tx_fifo_empty;
input	[7:0]	tx_buffer;
input		u_bc;
input		u_lb;
input	[1:0]	u_dls;
input	[1:0]	u_eps;
input		u_pen;
input	[3:0]	fl_tx;	
input		half_stop;
`ifdef  FIFO_MODE_USER
`ifdef	MODEM_AUTOFLOW_USER
	input		auto_flow_cts;
`endif
`endif
input		brg_clken;
//
//internal output
//
output 		tx_busy;
output		uart_sout;
output		rd_tx_fifo;
output		sout;
output		rd_tx_sram;
output		tx_shift_empty;
output		tx_enable;
//
//reg
//
reg		rd_tx_fifo;
reg		tx_busy;
reg   		parity_bit;
reg 		parity;
reg 		parity_5;
reg 		parity_6;
reg		parity_7;
reg		parity_8;
reg	[2:0]	state;
reg	[2:0]	next_state;
reg		sout;
reg		uart_sout;
reg	[8:0]	tx_shift;
reg	[8:0]	data_tx;
reg	[3:0]	tx_count_clk;
reg	[3:0]	tx_count_bit;
reg 		rd_tx_sram;
//
//wire
//
wire		tx_end_bit;
wire		tx_mid_bit;
wire		tx_end_frame;
//
//tx enable
//
`ifdef MODEM_AUTOFLOW_USER
	`ifdef FIFO_MODE_USER
				assign tx_enable = uart_enable & (~tx_fifo_empty & auto_flow_cts) & (~(u_fifoe & u_halt));
	`else 	assign tx_enable = uart_enable & (~tx_fifo_empty & auto_flow_cts);
	`endif
`else 	`ifdef FIFO_MODE_USER
			assign tx_enable = uart_enable & (~tx_fifo_empty) & (~(u_fifoe & u_halt));
		`else 	assign tx_enable = uart_enable & (~tx_fifo_empty);
		`endif
`endif
//
// tx shift empty
//
assign tx_shift_empty = tx_fifo_empty & (~tx_busy );
//
// tx_end_bit
//
assign tx_mid_bit = brg_clken & (& tx_count_clk[2:0]);
assign tx_end_bit = tx_mid_bit& tx_count_clk[3];
assign tx_end_frame = tx_end_bit & (tx_count_bit == fl_tx);
//GENERATE STATE MACHINE
//
always @(posedge pclk) begin
if(u_lb) uart_sout  <=`DELAY  1'b1;
else uart_sout  <=`DELAY  sout;
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
if(!resetn) state  <=`DELAY  TX_IDLE;
state  <=`DELAY  next_state;
end
//
//generate state
//

always @(*) begin
	next_state = TX_IDLE;
	tx_busy = 1'b0;
	rd_tx_fifo = 1'b0;
	rd_tx_sram = 1'b0;
	sout = 1'b1;
if(uart_enable)   begin
	casex(state) // synopsys parallel_case 
		TX_IDLE: begin
			tx_busy = 1'b0;
			rd_tx_fifo = 1'b0;
			rd_tx_sram = 1'b0;
			sout = 1'b1;
			if(u_bc) next_state = TX_BC;
			else if (tx_enable)  next_state = TX_WAIT; 
			else next_state = TX_IDLE;
		end
		TX_BC: begin
			tx_busy = 1'b1;
			rd_tx_fifo = 1'b0;
			rd_tx_sram = 1'b0;
			sout = 1'b0;
			if((u_bc==1'b0) & brg_clken) next_state = TX_IDLE; 
			else next_state = TX_BC;
		end
		TX_WAIT: 	begin 
			tx_busy = 1'b1;
			rd_tx_fifo = 1'b0;
			sout = 1'b1;
			if(brg_clken) begin 
				next_state = TX_LOAD;
				rd_tx_sram = 1'b1;
			end
			else begin 
				next_state =TX_WAIT;
				rd_tx_sram = 1'b1;
			end
		end
		TX_LOAD: 	begin 
			next_state = TX_STARTBIT;
			tx_busy = 1'b1;
			rd_tx_fifo = 1'b1;
			rd_tx_sram = 1'b1;
			sout = 1'b0;
		end
		TX_STARTBIT: 	begin 
			tx_busy = 1'b1;
			rd_tx_fifo = 1'b0;
			rd_tx_sram = 1'b0;
			sout = 1'b0;
			if(tx_end_bit) next_state = TX_DATA;
			else next_state = TX_STARTBIT;
		end
		TX_DATA: 	begin 
			tx_busy = 1'b1;
			rd_tx_fifo = 1'b0;
			rd_tx_sram = 1'b0;
			sout = tx_shift[0];
			casex({tx_end_frame,half_stop,u_bc,tx_enable}) 
				4'b1000: next_state = TX_IDLE;
				4'b101x: next_state = TX_BC;
				4'b1001: begin 
					next_state = TX_LOAD;
					rd_tx_sram = 1'b1;
				end
				4'b11x: next_state = TX_HALFSTOP;
				default: next_state = TX_DATA;
			endcase
		end
		TX_HALFSTOP: begin
			tx_busy = 1'b1;
			rd_tx_fifo = 1'b0;
			rd_tx_sram = 1'b0;
			sout = 1'b1;
			casex({tx_mid_bit,u_bc,tx_enable}) 
				3'b11x: next_state = TX_IDLE;
				3'b100: next_state = TX_BC;
				3'b101: begin 
					next_state = TX_LOAD;
					rd_tx_sram = 1'b1;
				end
				default: next_state = TX_HALFSTOP;
			endcase
		end
	endcase
end
end
//
// generate outputs, compatible with current state
//
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn) begin
		tx_shift[8:0]  <=`DELAY  9'h1FF;
		tx_count_clk  <=`DELAY  4'd0;
		tx_count_bit  <=`DELAY  4'd0;
	end
	else casex(state) // synopsys parallel_case 
		TX_IDLE: begin
			tx_shift[8:0]  <=`DELAY  9'h1FF;
			tx_count_clk  <=`DELAY  4'd0;
			tx_count_bit  <=`DELAY  4'd0;
		end				
		TX_WAIT: begin	
			tx_count_clk  <=`DELAY  4'd0;
			tx_count_bit  <=`DELAY  4'd0;
		end
		TX_LOAD: begin	
			tx_shift  <=`DELAY  data_tx;
			if(brg_clken) tx_count_clk  <=`DELAY  tx_count_clk +4'd1;
		end
		TX_STARTBIT: begin
			if(brg_clken) tx_count_clk  <=`DELAY  tx_count_clk +4'd1;
			if(tx_end_bit) begin
				tx_count_bit  <=`DELAY  tx_count_bit + 4'd1;
			end
		end
		TX_DATA: begin
			if(brg_clken) tx_count_clk  <=`DELAY  tx_count_clk +4'd1;
			if(tx_end_bit) begin
				tx_shift  <=`DELAY  {1'b1,tx_shift[8:1]};
				tx_count_bit  <=`DELAY  tx_count_bit + 4'd1;
			end
		end
		TX_HALFSTOP: begin
			if(brg_clken) tx_count_clk  <=`DELAY  tx_count_clk +4'd1;
		end
	endcase
end
//
// generate transmit-data
//

//
//generate parity bit
always @(*) begin
	parity_5 = ^tx_buffer[4:0];
	parity_6 = parity_5 ^ tx_buffer[5];
	parity_7 = parity_6 ^ tx_buffer[6];
	parity_8 = parity_7 ^ tx_buffer[7];
end
always @(*) begin
	case (u_dls[1:0]) // synopsys parallel_case 
	2'b00: parity_bit = parity_5;
	2'b01: parity_bit = parity_6;
	2'b10: parity_bit = parity_7;
	2'b11: parity_bit = parity_8;
endcase
end
always @(*) begin
	parity = 1'b1;
	casex ({u_pen,u_eps[1:0]}) // synopsys parallel_case 
	3'b0xx: parity = 1'b1;
	3'b11x: parity = u_eps[0];
	3'b101: parity = parity_bit;
	3'b100: parity = ~parity_bit;
endcase
end
//
//generate transmit- data_tx
//
always @(*) begin
	case (u_dls[1:0]) // synopsys parallel_case 
	2'b00: data_tx = {3'b111,parity,tx_buffer[4:0]};
	2'b01: data_tx = {2'b11,parity,tx_buffer[5:0]};
	2'b10: data_tx = {1'b1,parity,tx_buffer[6:0]};
	2'b11: data_tx = {parity,tx_buffer[7:0]};
endcase
end
endmodule

