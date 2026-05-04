`include "define.h"
module uart_apb_dma(/*AUTOARG*/
   // Outputs
   uart_dma_rx_req, uart_dma_rx_single, uart_dma_tx_req, 
   uart_dma_tx_single, 
   // Inputs
   resetn, pclk, tx_fifo_empty, tx_fifo_full, int_tx_trigger, 
   dma_tx_ack, rx_data_valid, rx_fifo_empty, int_rx_trigger, 
   dma_rx_ack, 
   `ifdef FIFO_MODE_USER
	u_to,
	`endif
	 u_fifoe, u_dmam, u_dmasa
   );

//
//reset&pclk
//
input 		resetn;
input		pclk;
//
// input
//

input		tx_fifo_empty;
input		tx_fifo_full;
input		int_tx_trigger;
input		dma_tx_ack;

input		rx_data_valid;
input		rx_fifo_empty;
input		int_rx_trigger;
input		dma_rx_ack;

`ifdef FIFO_MODE_USER
	input		u_to;
`endif
input		u_fifoe;
input		u_dmam;
input		u_dmasa;

//
// output
//
output	  	uart_dma_rx_req;
output		uart_dma_rx_single;
output	  	uart_dma_tx_req;
output		uart_dma_tx_single;
//
// reg and wire
//
reg	  	uart_dma_rx_req;
reg		uart_dma_rx_single;
reg	  	uart_dma_tx_req;
reg		uart_dma_tx_single;

//
//wire
//
wire 		rx_ack;
wire		tx_ack;
//
// DMA ACK
//
`ifdef DMA_POL_USER
	assign	rx_ack = (~dma_rx_ack) | u_dmasa;
	assign	tx_ack = (~dma_tx_ack) | u_dmasa;

	`ifdef FIFO_MODE_USER
		//
		//rx_req
		//
		always @ (posedge pclk) begin
			if(!resetn) uart_dma_rx_req <= `DELAY 1'b1;
			else begin
				casex({rx_ack,u_fifoe,u_dmam})  // synopsys parallel_case 
					3'b1xx: uart_dma_rx_req <= `DELAY 1'b1;
					3'b00x: uart_dma_rx_req <= `DELAY ~rx_data_valid;
					3'b010: uart_dma_rx_req <= `DELAY ~int_rx_trigger;
					3'b011: uart_dma_rx_req <= `DELAY ~(int_rx_trigger | u_to | ( uart_dma_rx_req & rx_data_valid));
				endcase
			end
		end
		//
		//tx_req
		//
		always @ (posedge pclk) begin
			if(!resetn) uart_dma_tx_req <= `DELAY 1'b1;
			else begin
				casex({tx_ack,u_fifoe,u_dmam})  // synopsys parallel_case 
					3'b1xx: uart_dma_tx_req <= `DELAY 1'b1;
					3'b00x: uart_dma_tx_req <= `DELAY ~tx_fifo_empty;
					3'b010: uart_dma_tx_req <= `DELAY ~int_tx_trigger;
					3'b011: uart_dma_tx_req <= `DELAY ~(int_tx_trigger | ( uart_dma_tx_req & (~tx_fifo_full)));
				endcase
			end
		end
	`else 
	//
	//rx_req & tx_req
	//
		always @ (*) begin
			uart_dma_rx_req = uart_dma_rx_single;
			uart_dma_tx_req = uart_dma_tx_single;
		end
	`endif
	//
	//rx single req
	//
	always @ (posedge pclk) begin
		if(!resetn) uart_dma_rx_single <= `DELAY 1'b0;
		else  uart_dma_rx_single <= `DELAY (rx_fifo_empty | rx_ack);
	end
	//
	//tx single req
	//
	`ifdef FIFO_MODE_USER
		always @ (posedge pclk) begin
			if(!resetn) uart_dma_tx_single <= `DELAY 1'b0;
			else if(u_fifoe) uart_dma_tx_single <= `DELAY ( tx_fifo_full | tx_ack);
			else uart_dma_tx_single <= `DELAY ( tx_fifo_empty & (~ tx_ack));
		end
	`else
			always @ (posedge pclk) begin
			if(!resetn) uart_dma_tx_single <= `DELAY 1'b0;
			else  uart_dma_tx_single <= `DELAY ( tx_fifo_empty & (~ tx_ack));
		end

	`endif
`else
	assign	rx_ack = dma_rx_ack | u_dmasa;
	assign	tx_ack = dma_tx_ack | u_dmasa;

	`ifdef FIFO_MODE_USER
		//
		//rx_req
		//
		always @ (posedge pclk) begin
			if(!resetn) uart_dma_rx_req <= `DELAY 1'b0;
			else begin
				casex({rx_ack,u_fifoe,u_dmam})  // synopsys parallel_case 
					3'b1xx: uart_dma_rx_req <= `DELAY 1'b0;
					3'b00x: uart_dma_rx_req <= `DELAY rx_data_valid;
					3'b010: uart_dma_rx_req <= `DELAY int_rx_trigger;
					3'b011: uart_dma_rx_req <= `DELAY (int_rx_trigger | u_to | ( uart_dma_rx_req & rx_data_valid));
				endcase
			end
		end
		//
		//tx_req
		//
		always @ (posedge pclk) begin
			if(!resetn) uart_dma_tx_req <= `DELAY 1'b0;
			else begin
				casex({tx_ack,u_fifoe,u_dmam})  // synopsys parallel_case 
					3'b1xx: uart_dma_tx_req <= `DELAY 1'b0;
					3'b00x: uart_dma_tx_req <= `DELAY tx_fifo_empty;
					3'b010: uart_dma_tx_req <= `DELAY int_tx_trigger;
					3'b011: uart_dma_tx_req <= `DELAY (int_tx_trigger | ( uart_dma_tx_req & (~tx_fifo_full)));
				endcase
			end
		end
	`else 
	//
	//rx_req & tx_req
	//
		always @ (*) begin
			uart_dma_rx_req = uart_dma_rx_single;
			uart_dma_tx_req = uart_dma_tx_single;
		end
	`endif
	//
	//rx single req
	//
	always @ (posedge pclk) begin
		if(!resetn) uart_dma_rx_single <= `DELAY 1'b0;
		else  uart_dma_rx_single <= `DELAY ~(rx_fifo_empty | rx_ack);
	end
	//
	//tx single req
	//
	`ifdef FIFO_MODE_USER
		always @ (posedge pclk) begin
			if(!resetn) uart_dma_tx_single <= `DELAY 1'b0;
			else if(u_fifoe) uart_dma_tx_single <= `DELAY ~( tx_fifo_full | tx_ack);
			else uart_dma_tx_single <= `DELAY ( tx_fifo_empty & (~ tx_ack));
		end
	`else
			always @ (posedge pclk) begin
			if(!resetn) uart_dma_tx_single <= `DELAY 1'b0;
			else  uart_dma_tx_single <= `DELAY ( tx_fifo_empty & (~ tx_ack));
		end

	`endif
`endif
endmodule
