`include "define.h"
module uart_apb_syn_detect(/*AUTOARG*/
   // Outputs
   cts, dsr, ri, dcd, syn_sin, 
   // Inputs
   resetn, pclk, uart_sin, uart_cts_n, uart_dsr_n, uart_ri_n, 
   uart_dcd_n
   );
//
//reset&pclk
//
input 		resetn;
input		pclk;
//
// serial input
//
input		uart_sin;
//
//modem input
//
input		uart_cts_n;
input		uart_dsr_n;
input		uart_ri_n;
input		uart_dcd_n;
//
// internal input
//
//
//internal output
//
output		cts;
output		dsr;
output		ri;
output		dcd;
output		syn_sin;
// reg and wire
//

reg		cts_temp1;
reg		dsr_temp1;
reg		ri_temp1;
reg		dcd_temp1;
reg		syn_sin_temp1;

reg		cts_temp2;
reg		dsr_temp2;
reg		ri_temp2;
reg		dcd_temp2;
reg		syn_sin;
//
// synchronous
//
assign		cts = ~ cts_temp2;
assign		dsr = ~ dsr_temp2;
assign		ri  = ~ ri_temp2;
assign		dcd = ~ dcd_temp2;
always @(posedge pclk) begin

	cts_temp1  <=`DELAY  uart_cts_n;
	dsr_temp1  <=`DELAY  uart_dsr_n;
	ri_temp1   <=`DELAY  uart_ri_n;
	dcd_temp1  <=`DELAY  uart_dcd_n;
	syn_sin_temp1  <=`DELAY  uart_sin;

	cts_temp2  <=`DELAY  cts_temp1;
	dsr_temp2  <=`DELAY  dsr_temp1;
	ri_temp2   <=`DELAY  ri_temp1;
	dcd_temp2  <=`DELAY  dcd_temp1;
	syn_sin  <=`DELAY  syn_sin_temp1;
end
endmodule
