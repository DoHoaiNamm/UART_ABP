`include "define.h"
module uart_apb_rx_fifo_sram(/*AUTOARG*/
   // Outputs
   rx_fifo_empty, rx_data_valid, rx_fifo_full, rx_fifo_almostfull, 
   rx_buffer, error_sta, uart_rx_sram_add_rd, uart_rx_sram_add_wr, 
   uart_rx_sram_datain, uart_rx_sram_rd_n, uart_rx_sram_wr_n, 
   uart_rx_sram_csn, u_overrun, u_rfe, num_data_in_rx_fifo, 
   wr_rx_fifo_valid, 
   // Inputs
   resetn_to_rx_fifo, pclk, rd_rx_fifo, rd_rx_sram, wr_rx_fifo, 
   data_to_rx_fifo, be, fe, pe, u_fifoe, rd_lsr, rx_sram_dataout
   );
parameter BINARY_DEEP  = log2 (`DEEP_FIFO_MODE);
parameter  BINARY_ADD1= add_1 (BINARY_DEEP);//  DEEP_BIT bit number counter, used for countting data in FIFO
function integer log2;
	input integer value;
	integer i;
	if (value == 1)
		log2 = 1;
	else
		for (i = 0; i <= 30; i = i + 1)
			if (2**i < value)
				log2 = i;
endfunction

function integer add_1;
	input integer N;
	add_1 = N+1; 
endfunction
//
//parameter state machine
//
parameter 	RX_FIFO_IDLE 		= 3'd0;
parameter	RX_NON_FIFO			= 3'd1;
parameter	RX_FIFO_EMPTY_S		= 3'd2;
parameter	RX_FIFO_FIRST_BYTE 	= 3'd3;
parameter	RX_FIFO_ALMOST_EMPTY 	= 3'd4;
parameter	RX_FIFO_SLEEP		= 3'd5;
parameter	RX_FIFO_READ1		= 3'd6;
parameter	RX_FIFO_READ2		= 3'd7;

//
//parameter mode user
//

//
//reset&pclk
//
input 		resetn_to_rx_fifo;
input		pclk;
//
//internal input
//
input	  	rd_rx_fifo;
input		rd_rx_sram;
input	  	wr_rx_fifo;
input	[7:0]	data_to_rx_fifo;
input		be;
input		fe;
input		pe;
input		u_fifoe;
input		rd_lsr;
//
//external input
//
input	[10:0]	rx_sram_dataout;
//
//internal output
//
output	  	rx_fifo_empty;
output	  	rx_data_valid;
output	  	rx_fifo_full;
output	  	rx_fifo_almostfull;
output	[7:0]	rx_buffer;
output	[2:0] 	error_sta;
//
//external output
//
output	[BINARY_DEEP:0] uart_rx_sram_add_rd;
output	[BINARY_DEEP:0] uart_rx_sram_add_wr;
output	[10:0] 	uart_rx_sram_datain;
output			uart_rx_sram_rd_n;
output			uart_rx_sram_wr_n;
output			uart_rx_sram_csn;
output			u_overrun;
output			u_rfe;

output	[BINARY_ADD1:0]	num_data_in_rx_fifo;
output			wr_rx_fifo_valid;
// reg and wire
//
// Beginning of automatic regs (for this module's undeclared outputs)
reg	[2:0]	state;
reg	[2:0]	next_state;
reg	[7:0]	rx_buffer;
reg	[2:0] 	error_sta;
reg			rx_fifo_empty;
reg			rx_fifo_full;  
reg [BINARY_DEEP:0] rd_point; 
reg [BINARY_DEEP:0] wr_point;
reg [`DEEP_FIFO_MODE:0] count_error;
reg 		rd_sram;
reg			overrun;
reg			u_overrun;
//
// wire
//
wire	[BINARY_DEEP:0]	sub_point;
wire 		almost_empty;
wire 		add_error;
wire 		sub_error;
// End of automatics
//

// Beginning of automatic wires (for undeclared instantiated-module outputs)
//
// number data in FIOFO
//
assign num_data_in_rx_fifo = {rx_fifo_full,sub_point};
//
// assign to SRAM
//
assign 	uart_rx_sram_add_rd = rd_point;
assign 	uart_rx_sram_add_wr = wr_point;
assign 	uart_rx_sram_wr_n = ~wr_rx_fifo_valid;
assign	uart_rx_sram_rd_n = ~rd_sram;
assign 	uart_rx_sram_csn = ~(u_fifoe & rx_data_valid);

assign	uart_rx_sram_datain = {be,fe, pe,data_to_rx_fifo};
//
//read valid
//
assign	rd_rx_fifo_valid = rd_rx_fifo & ~rx_fifo_empty;
//
// write valid
//
assign 	wr_rx_fifo_valid = wr_rx_fifo & ~rx_fifo_full;
///
//sub pointer
//
assign sub_point = (wr_point - rd_point + 1'b1);
//

//data valid
//
assign rx_data_valid = ~rx_fifo_empty;
//
//almost_full
//
assign rx_fifo_almostfull = rx_fifo_full | (&sub_point);
//
//almost_empty
//
assign almost_empty = (|{rx_fifo_full,sub_point[BINARY_DEEP:1]}) == 1'b0;
// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo ) begin
		rx_fifo_empty <=`DELAY  1'b1;
		rd_point  <=`DELAY  {{(BINARY_DEEP){1'b0}},1'b1};
		wr_point  <=`DELAY  {(BINARY_ADD1){1'b0}};
		rx_fifo_full <=`DELAY  1'b0;
	end
	else if (u_fifoe==1'b1)begin // fifo mode
		 casex ({rd_rx_fifo_valid,wr_rx_fifo_valid}) // synopsys parallel_case 
			2'b11 : begin
				rd_point <=`DELAY  rd_point + 1'd1;
				wr_point <=`DELAY  wr_point + 1'd1;
			end
			2'b10 : begin
				rd_point <=`DELAY  rd_point + 1'd1;
				rx_fifo_full <=`DELAY  1'b0;
				rx_fifo_empty <=`DELAY  almost_empty;
			end
			2'b01 : begin
				wr_point <=`DELAY  wr_point + 1'd1;
				rx_fifo_empty <=`DELAY  1'b0;
				if(&sub_point[BINARY_DEEP:0])	rx_fifo_full <=`DELAY  1'b1;
				else rx_fifo_full <=`DELAY  1'b0;
				
			end
	
		endcase 
	end
	else begin  // non fifo
		rd_point  <=`DELAY  {{(BINARY_DEEP){1'b0}},1'b1};
		wr_point  <=`DELAY  {(BINARY_ADD1){1'b0}};
		rx_fifo_full <=`DELAY  1'b0;
		casex ({rd_rx_fifo_valid,wr_rx_fifo_valid}) // synopsys parallel_case 
			2'bx1 : rx_fifo_empty <=`DELAY  1'b0;
			2'b10 : rx_fifo_empty <=`DELAY  1'b1;
		endcase 
	end
end
//
//check overrun overrun
//
always @(*) begin
	if(!resetn_to_rx_fifo ) overrun = 1'b0;
	else begin
		if(u_fifoe) overrun = rx_fifo_full & wr_rx_fifo;
		else overrun = wr_rx_fifo & rx_data_valid & (~rd_rx_fifo_valid);
	end
end
// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo ) u_overrun <=`DELAY  1'b0;
	else begin
		if(overrun) u_overrun <=`DELAY  1'b1;
		else if (rd_lsr)u_overrun <=`DELAY  1'b0; 
	end
end

//
//state machine
//

always @(posedge pclk) begin
state <=`DELAY  next_state;
end
//
//generate state
//

always @(*) begin
if(!resetn_to_rx_fifo) begin
	next_state = RX_FIFO_IDLE;
	rd_sram =1'b0;
end
else  	casex(state) // synopsys parallel_case 
		RX_FIFO_IDLE: begin
			if(u_fifoe) next_state = RX_FIFO_EMPTY_S;
			else next_state = RX_NON_FIFO;
			rd_sram = 1'b0;	
		end
		RX_NON_FIFO: begin
			next_state = RX_NON_FIFO;
			rd_sram = 1'b0;
		end
		RX_FIFO_EMPTY_S: 	begin 
			if(wr_rx_fifo_valid) next_state = RX_FIFO_FIRST_BYTE;
			else next_state = RX_FIFO_EMPTY_S;
			rd_sram = 1'b0;
		end
		RX_FIFO_FIRST_BYTE: 	begin 
			if(rd_rx_fifo_valid) next_state = RX_FIFO_EMPTY_S;
			else next_state = RX_FIFO_ALMOST_EMPTY;
			rd_sram = 1'b0;
		end
		RX_FIFO_ALMOST_EMPTY: begin 
			casex({wr_rx_fifo_valid,rd_rx_fifo_valid}) 
			2'b00: next_state = RX_FIFO_ALMOST_EMPTY;
			2'b01: next_state = RX_FIFO_EMPTY_S;
			2'b10: next_state = RX_FIFO_SLEEP;
			2'b11: next_state = RX_FIFO_FIRST_BYTE;
			endcase	
			rd_sram = 1'b0;
		end
		RX_FIFO_SLEEP: 	begin 
			if(rd_rx_sram) begin 
					next_state = RX_FIFO_READ1;
					rd_sram = 1'b1;
			end
			else begin
				next_state = RX_FIFO_SLEEP;
				rd_sram = 1'b0;
			end
		end
		RX_FIFO_READ1: begin
			 next_state = RX_FIFO_READ2;
			 rd_sram = 1'b1;
		end
		RX_FIFO_READ2:begin
			casex({almost_empty,rd_rx_sram,wr_rx_fifo_valid}) 
			3'b1x0: next_state = RX_FIFO_ALMOST_EMPTY;
			3'b111: next_state = RX_FIFO_READ1;
			3'b01x: next_state = RX_FIFO_READ1;
			default: next_state = RX_FIFO_SLEEP;
			endcase	
			rd_sram = 1'b1;
		end
	
	endcase
end
//
// generate outputs, compatible with current state
//
always @(posedge pclk) begin
casex(next_state) // synopsys parallel_case 
		RX_FIFO_IDLE: begin
			error_sta <=`DELAY  3'd0;
		end
		RX_NON_FIFO: begin
			if(wr_rx_fifo_valid) begin
				rx_buffer <=`DELAY  data_to_rx_fifo;
				error_sta <=`DELAY  {be,fe,pe};
			end
			else if(rd_rx_fifo_valid) error_sta <=`DELAY  3'd0;
		end
		RX_FIFO_EMPTY_S: 	begin 
			error_sta <=`DELAY  3'd0;
		end
		RX_FIFO_FIRST_BYTE: 	begin 
			rx_buffer <=`DELAY  data_to_rx_fifo;
			error_sta <=`DELAY  {be,fe,pe};
		end
		RX_FIFO_ALMOST_EMPTY: begin 
			 if (rd_lsr)error_sta <=`DELAY  3'd0;	
		end
		RX_FIFO_SLEEP: begin 
			 if (rd_lsr)error_sta <=`DELAY  3'd0;	
		end
		RX_FIFO_READ2:begin
			rx_buffer <=`DELAY  rx_sram_dataout[7:0];
			error_sta <=`DELAY  rx_sram_dataout[10:8];
		end
	
	endcase
end
//
//count_error
//

assign	add_error = wr_rx_fifo_valid & (|{be,fe,pe});
assign	sub_error = (rd_rx_fifo_valid | rd_lsr ) & (|error_sta);
assign	u_rfe = | count_error;
// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if (!resetn_to_rx_fifo) 	count_error <=`DELAY  {(`DEEP_FIFO_MODE+1){1'b0}};
	else begin
	casex ({u_fifoe,add_error,sub_error}) // synopsys parallel_case 
		3'b0xx: count_error <=`DELAY  {(`DEEP_FIFO_MODE+1){1'b0}};
		3'b110: count_error <=`DELAY  count_error + {{(`DEEP_FIFO_MODE){1'b0}},1'b1};
		3'b101: count_error <=`DELAY  count_error - {{(`DEEP_FIFO_MODE){1'b0}},1'b1};		
	endcase	
	end
end
endmodule
