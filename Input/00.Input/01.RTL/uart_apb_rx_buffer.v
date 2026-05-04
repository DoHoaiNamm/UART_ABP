module uart_apb_rx_buffer(/*AUTOARG*/
   // Outputs
   rx_fifo_empty, rx_buffer, error_sta, u_overrun, rx_data_valid, 
   u_rfe, 
   // Inputs
   resetn_to_rx_fifo, pclk, rd_rx_fifo, wr_rx_fifo, data_to_rx_fifo, 
   be, fe, pe, rd_lsr
   );
 `include "define.h"
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
input		rd_lsr;
//
//output
//
output	  	rx_fifo_empty;
output	[7:0]	rx_buffer;
output	[2:0] 	error_sta;
output	  	u_overrun;
output		rx_data_valid;
output		u_rfe;
//
// reg and wire
//
// Beginning of automatic regs (for this module's undeclared outputs)
reg		rx_fifo_empty;
reg	[2:0] 	error_sta;
reg	  	overrun;
reg	  	u_overrun;
reg	[7:0] 	rx_buffer;
// End of automatics
//
assign rx_data_valid = ~ rx_fifo_empty;

//
// synopsys sync_set_reset "resetn_to_rx_fifo"

always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo ) rx_fifo_empty <=`DELAY  1'b1;
	else begin
		casex ({rd_rx_fifo,wr_rx_fifo}) // synopsys parallel_case 
			2'bx1 : rx_fifo_empty <=`DELAY  1'b0;
			2'b10 : rx_fifo_empty <=`DELAY  1'b1;
		endcase 
	end
end
//
//write data into FIFO
//

always @(posedge pclk)	begin
	 if (wr_rx_fifo) 	rx_buffer<=`DELAY  {data_to_rx_fifo[7:0]};
end
//
//overrun u_overrun
//
always @(*) begin
	if(!resetn_to_rx_fifo ) overrun = 1'b0;
	else overrun = wr_rx_fifo & rx_data_valid & (~rd_rx_fifo);
end
// synopsys sync_set_reset "resetn_to_rx_fifo"
always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo ) u_overrun <=`DELAY  1'd0;
	else  if(overrun) u_overrun <=`DELAY  1'b1;
	else if (rd_lsr) u_overrun <=`DELAY  1'b0; // clear status when reading status	
end
//
//error_sta
//

always @(posedge pclk)	begin
	if(!resetn_to_rx_fifo )error_sta <=`DELAY  3'd0;
	else	casex ({wr_rx_fifo,rd_lsr}) // synopsys parallel_case 
			2'b1x: error_sta <=`DELAY  {be,fe,pe};
			2'b01: error_sta <=`DELAY  3'd0;	// clear status when reading status	
		endcase	
end
//
//count_error
//

assign	u_rfe = 0;

endmodule
