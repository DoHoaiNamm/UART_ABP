`include "define.h"
module uart_apb_rx_fifo(/*AUTOARG*/
   // Outputs
   rx_fifo_empty, rx_fifo_full, rx_fifo_almostfull, rx_buffer, 
   error_sta, u_overrun, rx_data_valid, u_rfe, num_data_in_rx_fifo, wr_rx_fifo_valid,
   // Inputs
   resetn_to_rx_fifo, pclk, rd_rx_fifo, wr_rx_fifo, data_to_rx_fifo, be, fe, 
   pe, u_fifoe, rd_lsr
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
//reset&pclk
//
input 	resetn_to_rx_fifo;
input	pclk;
//
//input
//
input	  	rd_rx_fifo;
input	  	wr_rx_fifo;
input	[7:0]	data_to_rx_fifo;
input		be;
input		fe;
input		pe;
input		u_fifoe;
input		rd_lsr;
//
//output
//
output	  	rx_fifo_empty;
output	  	rx_fifo_full;
output	  	rx_fifo_almostfull;
output	[7:0]	rx_buffer;
output	[2:0] 	error_sta;
output	  	u_overrun;
output		u_rfe;
output		rx_data_valid;
output		wr_rx_fifo_valid;
output	[BINARY_ADD1:0]	num_data_in_rx_fifo;
// reg and wire
//

// Beginning of automatic regs (for this module's undeclared outputs)
reg		rx_fifo_empty;
reg 		rx_fifo_full; 
reg	[10:0]	mem_in_reg[`DEEP_FIFO_MODE-1:0];
reg 	[BINARY_DEEP:0] rd_point; 
reg 	[BINARY_DEEP:0] wr_point;
reg	[BINARY_ADD1:0]	count_error;
reg	[2:0] 	error_sta;
reg	  	overrun;
reg	  	u_overrun;
reg		rd_rx_fifo_delay;
//
//wire
//
wire add_error;
wire sub_error;
wire		rx_almostempty;
wire	[BINARY_DEEP:0]	sub_point;
wire 	[10:0]	data_read_fifo;
wire 		immidiate_updata;
wire		clear_sta;
wire 	[BINARY_ADD1:0]	temp_count_error;
// End of automatics
//

// Beginning of automatic wires (for undeclared instantiated-module outputs)
// End of automatics

//
// output data 
//
assign data_read_fifo = mem_in_reg[rd_point];
assign rx_buffer = data_read_fifo[7:0];
	
assign num_data_in_rx_fifo = {rx_fifo_full,sub_point};
//assign	error_sta = rx_fifo_empty? 3'd0:data_read_fifo[10:8];	

//
//read valid
//
assign	rd_rx_fifo_valid = rd_rx_fifo & ~rx_fifo_empty;
//
//data valid
//
assign rx_data_valid = ~rx_fifo_empty;

//
//
// write valid
//
assign 	wr_rx_fifo_valid = wr_rx_fifo & ~rx_fifo_full;
///
//sub pointer
//
assign sub_point[BINARY_DEEP:0] = wr_point[BINARY_DEEP:0] - rd_point[BINARY_DEEP:0];
//
//read or write pointer
//
//assign rx_almostempty = ~ ( | sub_point[BINARY_DEEP:1] );
assign rx_fifo_almostfull = rx_fifo_full | (&sub_point);
assign rx_almostempty = (|{rx_fifo_full,sub_point[BINARY_DEEP:1]}) == 1'b0;

// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo ) begin 
		rx_fifo_empty  <=`DELAY  1'b1;
		rd_point  <=`DELAY  {(BINARY_ADD1){1'b0}};
		wr_point  <=`DELAY  {(BINARY_ADD1){1'b0}};
		rx_fifo_full  <=`DELAY  1'b0;
	end
	else if(u_fifoe) begin
		 casex ({rd_rx_fifo_valid,wr_rx_fifo_valid}) // synopsys parallel_case 
			2'b11 : begin
				rd_point  <=`DELAY  rd_point + 1'b1;
				wr_point  <=`DELAY  wr_point + 1'b1;
			end
			2'b10 : begin
				rd_point  <=`DELAY  rd_point + 1'b1;
				rx_fifo_full  <=`DELAY  1'b0;
				rx_fifo_empty  <=`DELAY  rx_almostempty;
			end
			2'b01 : begin
				wr_point  <=`DELAY  wr_point + 1'b1;
				rx_fifo_empty  <=`DELAY  1'b0;
				rx_fifo_full  <=`DELAY  rx_fifo_almostfull;
			end
		endcase 
	end
	else begin  // non fifo
		rd_point  <=`DELAY  {(BINARY_ADD1){1'b0}};
		wr_point  <=`DELAY  {(BINARY_ADD1){1'b0}};
		rx_fifo_full  <=`DELAY  1'b0;
		casex ({rd_rx_fifo_valid,wr_rx_fifo_valid}) // synopsys parallel_case 
			2'bx1 : rx_fifo_empty  <=`DELAY  1'b0;
			2'b10 : rx_fifo_empty  <=`DELAY  1'b1;
		endcase 
	end
end
//
//write data into FIFO
//
// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	 if (wr_rx_fifo_valid) 	mem_in_reg[wr_point] <=`DELAY  {be,fe,pe,data_to_rx_fifo[7:0]};
end
//
//overrun u_overrun
//
always @(*) begin
	if(!resetn_to_rx_fifo ) overrun = 1'b0;
	else begin
		if(u_fifoe) overrun = rx_fifo_full & wr_rx_fifo;
		else overrun = wr_rx_fifo & rx_data_valid & (~rd_rx_fifo_valid);
	end
end
always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo ) u_overrun  <=`DELAY  1'b0;
	else begin
		if(overrun) u_overrun  <=`DELAY  1'b1;
		else if (rd_lsr)u_overrun  <=`DELAY  1'b0; 
	end
end
//
//error_sta
//

assign immidiate_updata = (( u_fifoe & rd_rx_fifo_valid & rx_almostempty ) | 
				(rx_fifo_empty | (~u_fifoe))) &	wr_rx_fifo_valid;
				
assign	clear_sta = rx_fifo_empty | rd_lsr;

// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if (!resetn_to_rx_fifo) begin
		error_sta  <=`DELAY  3'd0;
		rd_rx_fifo_delay <= `DELAY  1'd0;
	end
	else begin
	rd_rx_fifo_delay <= `DELAY  rd_rx_fifo_valid;
	casex ({immidiate_updata,clear_sta,rd_rx_fifo_delay}) // synopsys parallel_case 
		3'b1xx: error_sta  <=`DELAY  {be,fe,pe};
		3'b010: error_sta  <=`DELAY  3'd0;
		3'b001: error_sta  <=`DELAY  data_read_fifo[10:8];		
	endcase	
	end
end
//
//count_error
//
assign	add_error = wr_rx_fifo_valid & (|{be,fe,pe});
assign	sub_error = (rd_rx_fifo_valid | rd_lsr ) & (|error_sta);
assign	u_rfe = | count_error;

assign	temp_count_error = add_error ? {{(BINARY_ADD1){1'b0}},1'b1} : {(BINARY_ADD1+1){1'b1}};
// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if (!resetn_to_rx_fifo) 	count_error  <=`DELAY  {(BINARY_ADD1+1){1'b0}};
	else begin
	casex ({rx_fifo_empty,u_fifoe,(add_error | sub_error)}) // synopsys parallel_case 
		3'b00x,3'b1xx: count_error  <=`DELAY  {(BINARY_ADD1+1){1'b0}};
		3'b011: count_error  <=`DELAY  count_error + temp_count_error;
	endcase	
	end
end
endmodule
