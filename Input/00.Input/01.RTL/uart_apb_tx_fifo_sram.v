`include "define.h"
module uart_apb_tx_fifo_sram(/*AUTOARG*/
   // Outputs
   tx_fifo_empty, tx_fifo_full, tx_buffer, uart_tx_sram_add_rd, 
   uart_tx_sram_add_wr, uart_tx_sram_datain, uart_tx_sram_rd_n, 
   uart_tx_sram_wr_n, uart_tx_sram_csn, num_data_in_tx_fifo, 
   // Inputs
   resetn_to_tx_fifo, pclk, rd_tx_fifo, rd_tx_sram, wr_tx_fifo, 
   pwdata, u_fifoe, tx_sram_csn, tx_sram_dataout
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
//reset&pclk
//
input 	resetn_to_tx_fifo;
input	pclk;
//
//internal input
//
input	  	rd_tx_fifo;
input		rd_tx_sram;
input	  	wr_tx_fifo;
input	[7:0]	pwdata;
input		u_fifoe;
input		tx_sram_csn;
//
//external input
//
input	[7:0]	tx_sram_dataout;
//
//internal output
//
output	  	tx_fifo_empty;
output	  	tx_fifo_full;
output	[7:0]	tx_buffer;
//
//external output
//
output	[BINARY_DEEP:0] uart_tx_sram_add_rd;
output	[BINARY_DEEP:0] uart_tx_sram_add_wr;
output	[7:0] 	uart_tx_sram_datain;
output			uart_tx_sram_rd_n;
output			uart_tx_sram_wr_n;
output			uart_tx_sram_csn;
output	[BINARY_ADD1:0]	num_data_in_tx_fifo;


//
// Beginning of automatic regs (for this module's undeclared outputs)
// Beginning of automatic regs (for this module's undeclared outputs)
reg		tx_fifo_empty;
reg 		tx_fifo_full; 
reg 	[BINARY_DEEP:0] rd_point; 
reg 	[BINARY_DEEP:0] wr_point;
//
//wire
//
wire	[BINARY_DEEP:0]	sub_point;
wire	wr_fifo_valid;
// End of automatics
//
//
//assign SRAM
// reg and wire
//
assign 	uart_tx_sram_add_rd = rd_point;
assign 	uart_tx_sram_add_wr = wr_point;
assign 	uart_tx_sram_wr_n = ~wr_fifo_valid;
assign	uart_tx_sram_rd_n = ~rd_tx_sram;
assign 	uart_tx_sram_csn = ~(tx_sram_csn | (~tx_fifo_empty));

assign	uart_tx_sram_datain = pwdata[7:0];
// Beginning of automatic wires (for undeclared instantiated-module outputs)
//
// number data in FIOFO
//
assign num_data_in_tx_fifo = {tx_fifo_full,sub_point};
//
// output data 
//
assign tx_buffer = tx_sram_dataout;
assign num_data_in_tx_fifo = {tx_fifo_full,sub_point};

//
//read valid
//
assign	rd_tx_fifo_valid = rd_tx_fifo & ~tx_fifo_empty;
//
// write valid
//
assign 	wr_fifo_valid = wr_tx_fifo & ~tx_fifo_full;
///
//sub pointer
//
assign sub_point = wr_point - rd_point;
//
//read or write pointer
//
// synopsys sync_set_reset "resetn_to_tx_fifo"
always @(posedge pclk)	begin
	if(!resetn_to_tx_fifo ) begin
		tx_fifo_empty  <=`DELAY  1'b1;
		rd_point  <=`DELAY  {(BINARY_DEEP+1){1'b0}};
		wr_point  <=`DELAY  {(BINARY_DEEP+1){1'b0}};
		tx_fifo_full  <=`DELAY  0;
	end
	else if(u_fifoe) begin
		 casex ({rd_tx_fifo_valid,wr_fifo_valid}) // synopsys parallel_case 
			2'b11 : begin
				rd_point  <=`DELAY  rd_point + 1'b1;
				wr_point  <=`DELAY  wr_point + 1'b1;
			end
			2'b10 : begin
				rd_point  <=`DELAY  rd_point + 1'b1;
				tx_fifo_full  <=`DELAY  1'b0;
				if((|num_data_in_tx_fifo[BINARY_ADD1:1]) == 1'b0 )	tx_fifo_empty  <=`DELAY  1'b1;
				else tx_fifo_empty  <=`DELAY  1'b0;
			end
			2'b01 : begin
				wr_point  <=`DELAY  wr_point + 1'b1;
				tx_fifo_empty  <=`DELAY  1'b0;
				if(&sub_point[BINARY_DEEP:0])	tx_fifo_full  <=`DELAY  1'b1;
				else tx_fifo_full  <=`DELAY  1'b0;
				
			end
		endcase 
	end
	else begin  // non fifo
		rd_point  <=`DELAY  0;
		wr_point  <=`DELAY  0;
		tx_fifo_full  <=`DELAY  1'b0;
		casex ({rd_tx_fifo_valid,wr_fifo_valid}) // synopsys parallel_case 
			2'bx1 : tx_fifo_empty  <=`DELAY  1'b0;
			2'b10 : tx_fifo_empty  <=`DELAY  1'b1;
		endcase 
	end
end
//
//write data into FIFO
//
endmodule


