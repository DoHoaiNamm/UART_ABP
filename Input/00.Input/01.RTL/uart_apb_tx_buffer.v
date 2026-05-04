`include "define.h"
module uart_apb_tx_buffer(/*AUTOARG*/
   // Outputs
   tx_fifo_empty, tx_buffer, 
   // Inputs
   resetn_to_tx_fifo, pclk, rd_tx_fifo, wr_tx_fifo, pwdata
   );
//reset&pclk
//
input 	resetn_to_tx_fifo;
input	pclk;
//
//input
//
input	  	rd_tx_fifo;
input	  	wr_tx_fifo;
input	[7:0]	pwdata;
//
//output
//
output	  	tx_fifo_empty;
output	[7:0]	tx_buffer;
// reg and wire
//

// Beginning of automatic regs (for this module's undeclared outputs)
reg		tx_fifo_empty;
reg	[7:0]	tx_buffer;
//

// Beginning of automatic wires (for undeclared instantiated-module outputs)
// End of automatics

//
// output data 
//
// synopsys sync_set_reset "resetn_to_tx_fifo"
always @(posedge pclk)	begin
	if(!resetn_to_tx_fifo) tx_fifo_empty  <=`DELAY  1'b1;
	else begin  // non fifo
		casex ({rd_tx_fifo,wr_tx_fifo}) // synopsys parallel_case 
			2'bx1 : begin 
				tx_fifo_empty  <=`DELAY  1'b0;
				tx_buffer  <=`DELAY  pwdata[7:0];
			end
			2'b10 : tx_fifo_empty  <=`DELAY  1'b1;
		endcase 
	end
end
endmodule
