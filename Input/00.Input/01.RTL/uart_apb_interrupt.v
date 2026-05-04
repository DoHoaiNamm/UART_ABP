`include "define.h"
module uart_apb_interrupt(/*AUTOARG*/
   // Outputs
   uart_int, u_int_id, int_rx_trigger, int_tx_trigger, 
   // Inputs
   resetn, pclk, 
   
	`ifdef DMA_EXTRA_USER
	  u_dmam, 
	`endif
	tx_fifo_empty, 
	`ifdef  FIFO_MODE_USER
	u_rxft, u_fifoe, 
	`ifdef	MODEM_AUTOFLOW_USER
		auto_flow, 
	`endif
	`endif 
	u_dcts,   u_ddsr, u_dri, u_ddcd, error_sta, u_overrun, 
	`ifdef  FIFO_MODE_USER
		u_to, num_data_in_rx_fifo,num_data_in_tx_fifo,
	`endif
    rx_data_valid,  
	`ifdef THRE_MODE_USER
			u_int_tx_trigger_enable, 
			u_txft, 		
	`endif
	rx_fifo_empty, 
	`ifdef BUSY_DETECT_USER 
	u_detect_busy, 
	`endif
	u_int_modem_enable, u_int_rx_enable, u_int_tx_enable, 
	u_int_error_enable
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
input 		resetn;
input		pclk;
//
//internal input
//
`ifdef DMA_EXTRA_USER
input		u_dmam;
`endif
input		tx_fifo_empty;
`ifdef  FIFO_MODE_USER
input	[1:0]	u_rxft;// rx fifo status
input		u_fifoe;
`ifdef	MODEM_AUTOFLOW_USER
	input		auto_flow;
`endif
`endif 
input		u_dcts;// modem status
input		u_ddsr;
input		u_dri;
input		u_ddcd;

input	[2:0] 	error_sta;// line status
input		u_overrun;


`ifdef  FIFO_MODE_USER
	input		u_to;// time out
	input	[BINARY_ADD1:0] num_data_in_rx_fifo;
	input	[BINARY_ADD1:0] num_data_in_tx_fifo;	

`endif
input		rx_data_valid;
`ifdef THRE_MODE_USER
	input		u_int_tx_trigger_enable;
	input	[1:0]	u_txft;// tx FIFO status
`endif
input		rx_fifo_empty;
`ifdef BUSY_DETECT_USER 
	input		u_detect_busy;// write LCR when Uart is being busy
`endif
//  int mask
input		u_int_modem_enable;
input		u_int_rx_enable;
input		u_int_tx_enable;
input		u_int_error_enable;
//
// output
//
output	  	uart_int;
output	[3:0]	u_int_id;
output		int_rx_trigger;
output		int_tx_trigger;
//
//reg --> combination circuit 
//
reg	  		uart_int;
reg	[3:0]	u_int_id;
reg			int_rx_trigger;
reg			int_rx;
reg			int_tx_trigger;
reg			int_tx;
`ifdef FIFO_MODE_USER  
	reg 	[BINARY_ADD1:0] num_rx_trigger;
`endif
`ifdef THRE_MODE_USER  
`ifdef FIFO_MODE_USER
	reg 	[BINARY_ADD1:0] num_tx_trigger;
`endif
`endif
//
//generate error interrupt
//
wire	int_error;
wire 	int_modem;
//
//assign error interrupt
//
assign int_error = (u_overrun| (|error_sta[2:0])) & u_int_error_enable;
//
//receive interrupt
//
`ifdef 	FIFO_MODE_USER
		always @(*) begin
			num_rx_trigger = {(BINARY_ADD1+1){1'b0}} ;
			casex(u_rxft[1:0]) // synopsys parallel_case 
				2'b00: num_rx_trigger = {{(BINARY_ADD1+1){1'b0}},1'b1};
				2'b01: num_rx_trigger =  {2'd0,1'b1,{(BINARY_ADD1-2){1'b0}}} ;
				2'b10: num_rx_trigger =  {1'b0,1'b1,{(BINARY_ADD1-1){1'b0}}} ;
				2'b11: num_rx_trigger =  {1'b0,{(BINARY_ADD1-1){1'b1}},1'b0} ;
			endcase	
		end
		
		
		always @(*) begin
			int_rx_trigger = 1'b0;
			if(u_fifoe) int_rx_trigger =  (num_data_in_rx_fifo >= num_rx_trigger);
			else  int_rx_trigger = rx_data_valid;
		end
		always @(*) begin
			if(~u_int_rx_enable ) int_rx = 1'b0;
			else int_rx = ( u_to | int_rx_trigger);
		end
		
`else 	always @(*) begin
		int_rx_trigger = rx_data_valid;
		if( ~ u_int_rx_enable ) int_rx = 1'b0;
		else int_rx = rx_data_valid;
	end
`endif
//
//transmit interrupt
//

`ifdef THRE_MODE_USER  
	`ifdef FIFO_MODE_USER
		always @(*) begin
			num_tx_trigger = {(BINARY_ADD1+1){1'b0}} ;
			casex(u_txft[1:0]) // synopsys parallel_case 
				2'b00: num_tx_trigger = {(BINARY_ADD1+1){1'b0}} ;
				2'b01: num_tx_trigger =  {{(BINARY_ADD1-2){1'b0}},1'b1,1'b0} ;
				2'b10: num_tx_trigger =  {2'd0,1'b1,{(BINARY_ADD1-2){1'b0}}} ;
				2'b11: num_tx_trigger =  {1'b0,1'b1,{(BINARY_ADD1-1){1'b0}}} ;
			endcase	
		end
		
		always @(*) begin
			int_tx_trigger = 1'b0;
			if((u_fifoe & u_int_tx_trigger_enable)) int_tx_trigger = (num_data_in_tx_fifo <= num_tx_trigger);
			else int_tx_trigger = tx_fifo_empty;
		end
	`else 	always @(*) begin
			int_tx_trigger = tx_fifo_empty;
		end
	`endif 
`else 	always @(*) begin
		int_tx_trigger = tx_fifo_empty;
	end
`endif 
always @(*) begin
	if( ! u_int_tx_enable) int_tx = 1'b0;
	else int_tx = int_tx_trigger;
end
//
//modem interrupt
//


`ifdef MODEM_AUTOFLOW_USER 
	`ifdef FIFO_MODE_USER 
			assign int_modem = u_int_modem_enable & ( (u_dcts & (~auto_flow)) | u_ddsr | u_dri | u_ddcd);
	`else 	assign int_modem = u_int_modem_enable & ( u_dcts | u_ddsr | u_dri | u_ddcd);	
	`endif
`else assign int_modem = u_int_modem_enable & ( u_dcts | u_ddsr | u_dri | u_ddcd);
`endif
//
// interrupt ID
//
`ifdef  FIFO_MODE_USER
	`ifdef BUSY_DETECT_USER 
		//
		//uart_int
		//
		always @ (posedge pclk) begin
			if(!resetn)  uart_int <= `DELAY 1'b0;
			else uart_int <= `DELAY  int_error | int_rx | int_tx | int_modem | u_detect_busy;
		end

		always @ (*) begin
			if(!uart_int) 	u_int_id = 4'b0001;
			else casex ({int_error, int_rx, u_to, int_tx, int_modem, u_detect_busy}) // synopsys parallel_case 
				6'b1xxxxx: 	u_int_id = 4'b0110;
				6'b010xxx: 	u_int_id = 4'b0100;
				6'b011xxx: 	u_int_id = 4'b1100;
				6'b0001xx: 	u_int_id = 4'b0010;
				6'b00001x: 	u_int_id = 4'b0000;
				6'b000001: 	u_int_id = 4'b0111;
				default: 	u_int_id = 4'b0001;
			endcase
		end
	`else  
		//
		//uart_int
		//
		always @ (posedge pclk) begin
			if(!resetn)  uart_int <= `DELAY 1'b0;
			else uart_int <= `DELAY int_error | int_rx | int_tx | int_modem ;
		end
		always @ (*) begin
			if(!uart_int) 	u_int_id = 4'b0001;
			else casex ({int_error,int_rx,u_to,int_tx,int_modem}) 
				5'b1xxxx: 	u_int_id = 4'b0110;
				5'b010xx: 	u_int_id = 4'b0100;
				5'b011xx: 	u_int_id = 4'b1100;
				5'b0001x: 	u_int_id = 4'b0010;
				5'b00001: 	u_int_id = 4'b0000;
				default: 	u_int_id = 4'b0001;
			endcase
		end
	`endif
`else
`ifdef BUSY_DETECT_USER 
		//
		//uart_int
		//
		always @ (posedge pclk) begin
			if(!resetn)  uart_int <= `DELAY 1'b0;
			else uart_int <= `DELAY  int_error | int_rx | int_tx | int_modem | u_detect_busy;
		end

		always @ (*) begin
			if(!uart_int) 	u_int_id = 4'b0001;
			else casex ({int_error, int_rx, int_tx, int_modem, u_detect_busy}) // synopsys parallel_case 
				5'b1xxxx: 	u_int_id = 4'b0110;
				5'b01xxx: 	u_int_id = 4'b0100;
				5'b001xx: 	u_int_id = 4'b0010;
				5'b0001x: 	u_int_id = 4'b0000;
				5'b00001: 	u_int_id = 4'b0111;
				default: 	u_int_id = 4'b0001;
			endcase
		end
	`else  
		//
		//uart_int
		//
		always @ (posedge pclk) begin
			if(!resetn)  uart_int <= `DELAY 1'b0;
			else uart_int <= `DELAY int_error | int_rx | int_tx | int_modem ;
		end
		always @ (*) begin
			if(!uart_int) 	u_int_id = 4'b0001;
			else casex ({int_error,int_rx,int_tx,int_modem}) 
				4'b1xxx: 	u_int_id = 4'b0110;
				4'b01xx: 	u_int_id = 4'b0100;
				4'b001x: 	u_int_id = 4'b0010;
				4'b0001: 	u_int_id = 4'b0000;
				default: 	u_int_id = 4'b0001;
			endcase
		end
`endif
`endif 
endmodule 
