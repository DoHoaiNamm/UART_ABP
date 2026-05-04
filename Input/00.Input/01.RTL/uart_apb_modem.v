`include "define.h"
module uart_apb_modem(/*AUTOARG*/
	// Outputs
	uart_rts_n, uart_dtr_n, uart_out1_n, uart_out2_n, u_msr, 
	`ifdef  FIFO_MODE_USER
	`ifdef	MODEM_AUTOFLOW_USER
	 	auto_flow_cts, auto_flow,
	`endif
	`endif
  	 u_dcts, u_ddsr, u_dri, u_ddcd, 
   // Inputs
	resetn, pclk, cts, dsr, ri, dcd, u_out2, u_out1, u_rts, u_dtr, 
	u_lb, rx_fifo_empty, int_rx_trigger, rx_busy, 
	`ifdef  FIFO_MODE_USER
	`ifdef	MODEM_AUTOFLOW_USER
		u_rxft, rx_fifo_full, rx_fifo_almostfull, u_afce, u_fifoe,
	`endif
	`endif
 rd_msr
   );

//
//reset&pclk
//
input 		resetn;
input		pclk;
//
//internal input
//
input		cts;
input		dsr;
input		ri;
input		dcd;
input		u_out2;
input		u_out1;
input		u_rts;
input		u_dtr;
input		u_lb;
input		rx_fifo_empty;
input		int_rx_trigger;
input		rx_busy;
`ifdef  MODEM_AUTOFLOW_USER
	input	[1:0]	u_rxft;
	input		rx_fifo_full;
	input		rx_fifo_almostfull;
	input		u_afce;
	input		u_fifoe;
`endif

input		rd_msr;
//
//external input
//
//internal output
//
output	  	uart_rts_n;
output		uart_dtr_n;
output	  	uart_out1_n;
output		uart_out2_n;
output 	[7:0]	u_msr;
`ifdef	MODEM_AUTOFLOW_USER
	output 		auto_flow_cts;
	output 		auto_flow;
`endif
output 		u_dcts;
output 		u_ddsr;
output 		u_dri;
output 		u_ddcd;
//
// reg and wire
//
reg	uart_rts_n;
reg	uart_dtr_n;
reg	uart_out1_n;
reg	uart_out2_n;

reg	u_cts;
reg	u_dsr;
reg	u_ri;
reg	u_dcd;

reg	u_dcts;
reg	u_ddsr;
reg	u_dri;
reg	u_ddcd;
`ifdef	MODEM_AUTOFLOW_USER
	reg		auto_flow_cts;
`endif

//
//wire
//
wire		edge0;
wire		edge1;
wire		edge2;
wire		edge3;
wire 	[3:0]	temp_modem;
//
// FF
//
//assign auto_flow = u_fifoe & u_afce;
assign u_msr = {u_dcd, u_ri, u_dsr, u_cts, u_ddcd, u_dri, u_ddsr, u_dcts};
always @(posedge pclk) begin
	if(!resetn ) {u_dcd, u_ri, u_dsr, u_cts} <=`DELAY  4'd0;
	else  {u_dcd, u_ri, u_dsr, u_cts} <=`DELAY  temp_modem[3:0];
end

assign temp_modem = u_lb ? {u_out2,u_out1,u_dtr, u_rts} : { dcd , ri , dsr , cts};
assign edge0 = (u_cts ^ temp_modem[0]);
assign edge1 = (u_dsr ^ temp_modem[1]);
assign edge2 = (u_ri ^ temp_modem[2]);
assign edge3 = (u_dcd & (~temp_modem[3]));
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) u_dcts <=`DELAY  1'b0;
	else begin 
		casex ({edge0,rd_msr}) // synopsys parallel_case 
			2'b1x : u_dcts <=`DELAY  1'b1; 
			2'b01 : u_dcts <=`DELAY  1'b0;
		endcase 
	end
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) u_ddsr <=`DELAY  1'b0;
	else begin 
		casex ({edge1,rd_msr}) // synopsys parallel_case 
			2'b1x : u_ddsr <=`DELAY  1'b1; 
			2'b01 : u_ddsr <=`DELAY  1'b0;
		endcase 
	end
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) u_dri <=`DELAY  1'b0;
	else begin 
		casex ({edge2,rd_msr}) // synopsys parallel_case 
			2'b1x : u_dri <=`DELAY  1'b1; 
			2'b01 : u_dri <=`DELAY  1'b0;
		endcase 
	end
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) u_ddcd <=`DELAY  1'b0;
	else begin 
		casex ({edge3,rd_msr}) // synopsys parallel_case 
			2'b1x : u_ddcd <=`DELAY  1'b1; 
			2'b01 : u_ddcd <=`DELAY  1'b0;
		endcase 
	end
end
//
// autoflow
//

`ifdef MODEM_AUTOFLOW_USER 
`ifdef  FIFO_MODE_USER
	wire	auto_full_rts;
	assign auto_full_rts = ( rx_fifo_almostfull & rx_busy ) | rx_fifo_full;
`endif
`endif
// synopsys sync_set_reset "resetn"
`ifdef MODEM_AUTOFLOW_USER 
	`ifdef FIFO_MODE_USER 
	always @(posedge pclk) begin
	if(!resetn ) uart_rts_n <=`DELAY  1'b1;
	else begin 
		casex ({u_lb, u_fifoe & u_afce, & u_rxft,rx_fifo_empty,int_rx_trigger}) // synopsys parallel_case 
			5'b1xxxx : uart_rts_n <=`DELAY  1'b1;
			5'b00xxx : uart_rts_n <=`DELAY  ~u_rts;
			5'b01001 : uart_rts_n <=`DELAY  1'b1;
			5'b011xx : uart_rts_n <=`DELAY  auto_full_rts;
			5'b01010 : uart_rts_n <=`DELAY  1'b0;
		endcase
	end
	end
	`else 
	// synopsys sync_set_reset "resetn"
	always @(posedge pclk) begin
		if(!resetn ) uart_rts_n <=`DELAY  1'b1;
		else begin 
			if(u_lb ) uart_rts_n <=`DELAY  1'b1;
			else uart_rts_n <=`DELAY ~u_rts;
		end
	end

	`endif
`else 
// synopsys sync_set_reset "resetn"
	always @(posedge pclk) begin
		if(!resetn ) uart_rts_n <=`DELAY  1'b1;
		else begin 
			if(u_lb ) uart_rts_n <=`DELAY  1'b1;
			else uart_rts_n <=`DELAY ~u_rts;
		end
	end

`endif
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) uart_dtr_n <=`DELAY  1'b1;
	else begin 
			if(u_lb ) uart_dtr_n <=`DELAY  1'b1;
			else uart_dtr_n <=`DELAY ~u_dtr;
	end
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) uart_out1_n <=`DELAY  1'b1;
	else begin 
			if(u_lb ) uart_out1_n <=`DELAY  1'b1;
			else uart_out1_n <=`DELAY ~u_out1;
	end
end
// synopsys sync_set_reset "resetn"
always @(posedge pclk) begin
	if(!resetn ) uart_out2_n <=`DELAY  1'b1;
	else begin 
			if(u_lb ) uart_out2_n <=`DELAY  1'b1;
			else uart_out2_n <=`DELAY ~u_out2;
	end
end
//
//autoflow cts
//
`ifdef MODEM_AUTOFLOW_USER 
	assign auto_flow = u_fifoe & u_afce;
	always @(*) begin
		auto_flow_cts = 1'b1;
		if(auto_flow) auto_flow_cts = u_cts;
		else auto_flow_cts = 1'b1;
	end
`endif
endmodule
