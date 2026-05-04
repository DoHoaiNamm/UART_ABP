`include "define.h"
module uart_apb_baudrate(/*AUTOARG*/
   // Outputs
   `ifdef  FIFO_MODE_USER
	u_to,
	`endif
	brg_clken, 
	`ifdef	BAUD_CLK
		uart_baundout_n,
	`endif
   // Inputs
   pclk, resetn, uart_enable, dvsr_eq_1, u_divisor, tx_busy, 
   rx_busy, rd_rx_fifo, 
	`ifdef  FIFO_MODE_USER
		wr_rx_fifo_valid, u_fifoe,
	`endif
   half_stop, fl_tx, 
   rx_data_valid
   );
parameter IDLE = 0;
parameter LOW1 = 1;
parameter LOW2 = 2;
parameter HIGH = 3;
parameter DIV1 = 4;
//
//clock & reset
//
input 		pclk;
input 		resetn;
//
//input
//
input 		uart_enable;
input 		dvsr_eq_1;
input	[15:0]	u_divisor;
input		tx_busy;
input		rx_busy;
input		rd_rx_fifo;
`ifdef  FIFO_MODE_USER
	input		wr_rx_fifo_valid;
	input 	u_fifoe;
`endif

input		half_stop;
input 	[3:0]	fl_tx;
input 	rx_data_valid;
//
//internal output
//
`ifdef  FIFO_MODE_USER
	output		u_to;
`endif

output		brg_clken;
`ifdef	BAUD_CLK
	output		uart_baundout_n;
`endif
//
// reg
//
`ifdef  FIFO_MODE_USER
	reg	[9:0]	to_count;
	reg			u_to;
`endif
reg	[15:0]	count_clk;
//
// baundout
//
`ifdef	BAUD_CLK
	reg			uart_baundout_n;
	reg [2:0]	state;
	reg	[2:0]	next_state;
	reg			end_brg;
	reg	[3:0] 	count_baudout;
`endif
//
// wire
//
`ifdef	BAUD_CLK
	wire		compare;
	wire		dvs_1;
	wire		dvs_2;
`endif
`ifdef  FIFO_MODE_USER
	wire		to_count_enable;
	wire		clear_to_count;
`endif
wire		count_en;
// Beginning of automatic wires (for undeclared instantiated-module outputs)
// End of automatics
//
// counter clock enable
//
`ifdef  FIFO_MODE_USER
		assign	count_en = uart_enable & (tx_busy | rx_busy | to_count_enable);
`else 	assign	count_en = uart_enable & (tx_busy | rx_busy );
`endif

//
// uart_baundout_n
//
`ifdef  BAUD_CLK
	assign	brg_clken = end_brg;//dvsr_eq_1 | (count_clk == u_divisor);
	assign compare = (count_clk == u_divisor);
	assign dvs_1 = dvsr_eq_1;//dvs <= 1?
	assign dvs_2 = (~(|u_divisor[15:2] | u_divisor[0])) & u_divisor[1];// dvs==2? 

	always @(posedge pclk) begin
	if(uart_enable) state <= next_state;
	else state <=IDLE;
	end
	//
	//generate state
	//
	always @(*) begin
		next_state = IDLE;
		end_brg = 1'b0;
		if(uart_enable) begin
			casex(state)
				IDLE: begin
					casex({dvs_1,dvs_2}) 
						2'b10: next_state = DIV1;
						2'b01: next_state = LOW2;
						default: next_state = LOW1;
					endcase
					end_brg = 1'b0;
				end
				LOW1: begin
					next_state = LOW2;
					end_brg = 1'b0;
				end
				LOW2: begin
					next_state = HIGH;
					end_brg = 1'b0;
				end
				HIGH: begin
					casex({compare,dvs_2})
						2'bx1: next_state = LOW2;
						2'b10: next_state = LOW1;
						default: next_state = HIGH;
					endcase
					if(compare) end_brg = 1'b1;
					else end_brg = 1'b0;
				end
				DIV1: begin
					end_brg = 1'b1;
					next_state = DIV1;
				end
			endcase
		end
	end
	//
	// generate outputs, compatible with current state
	//
	always @(posedge pclk) begin
		casex(state)
			IDLE: begin
				uart_baundout_n <= 1'b1;
				count_clk <= 16'd2;
				count_baudout <= 4'd0;
			end
			LOW1: begin
				uart_baundout_n <= 1'b0;
				count_clk <= count_clk + 16'd1;	
			end
			LOW2: begin
				uart_baundout_n <= 1'b0;
			end
			HIGH: begin
				uart_baundout_n <= 1'b1;
				if(end_brg) begin
					count_baudout <= count_baudout + 4'd1;
					count_clk <= 16'd2;
				end
				else 	count_clk <= count_clk + 16'd1;	
			end
			DIV1: 	begin 
					count_baudout <= count_baudout + 4'd1;
			end
		endcase
	end


//
// clock counter  
//
// synopsys sync_set_reset "resetn"
`else
	
//
// baud clock
//
	assign	brg_clken = dvsr_eq_1 | (count_clk == u_divisor);
	always @ (posedge pclk) begin
		if(resetn==1'b0) count_clk  <=`DELAY  16'd1;
		else if (brg_clken |(~uart_enable)) count_clk  <=`DELAY  16'd1;
		else if (count_en) count_clk  <=`DELAY  count_clk + 1'd1;
	end
`endif
//
// time out counter 
//
`ifdef  FIFO_MODE_USER
	assign clear_to_count = wr_rx_fifo_valid | rd_rx_fifo| u_to;
	// synopsys sync_set_reset "resetn"
	always @ (posedge pclk) begin
		if(resetn==1'b0) to_count  <=`DELAY  10'd0;
		else if (to_count_enable) begin
			if (clear_to_count) to_count  <=`DELAY  10'd0;
			else if(brg_clken )  to_count  <= `DELAY  to_count + 1'd1;
		end
	end

	//
	//  timeout counter enable
	//
	assign to_count_enable = rx_data_valid & u_fifoe;

	// synopsys sync_set_reset "resetn"
	always @ (posedge pclk) begin
		if(resetn==1'b0) u_to  <=`DELAY  1'b0;
		else if (rd_rx_fifo) u_to  <=`DELAY  1'b0;
		else if(to_count[9:5]=={fl_tx,half_stop} ) u_to  <=`DELAY  1'd1;
	end
`endif
endmodule
