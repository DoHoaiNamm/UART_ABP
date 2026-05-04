`include "define.h"
module uart_apb_rw_control(/*AUTOARG*/
   // Outputs
   prdata, u_out2, u_out1, u_rts, u_dtr, u_lb, 
   u_int_modem_enable, u_int_rx_enable, 
   u_int_tx_enable, u_int_error_enable, rd_rx_fifo, rd_rx_sram, wr_tx_fifo, u_dlab, u_bc, u_eps, u_pen, 
   u_stop, u_dls,  rd_msr, rd_lsr, 
   `ifdef DMA_EXTRA_USER 
	u_dmasa,
	`ifdef FIFO_MODE_USER
		u_dmam, 
	`endif
	`endif
    `ifdef BUSY_DETECT_USER 
	u_detect_busy, 
	`endif

   u_divisor, resetn_to_tx_fifo, resetn_to_rx_fifo, 
   resetn, fl_rx, fl_tx, half_stop, uart_enable, dvsr_eq_1, 
   tx_sram_csn, 
   `ifdef FIFO_MODE_USER
	u_halt,u_rxft,u_fifoe,
	`ifdef THRE_MODE_USER
		u_int_tx_trigger_enable, 
		u_txft,
	`endif
	`ifdef MODEM_AUTOFLOW_USER
		u_afce,
	`endif
`endif
   // Inputs
   pclk, presetn, psel, pwrite, penable, paddr, pwdata, u_int_id, 
	`ifdef  FIFO_MODE_USER
			num_data_in_tx_fifo, num_data_in_rx_fifo, tx_fifo_full, rx_fifo_full, 
	`endif
   rx_buffer, u_msr,    error_sta, u_overrun, rx_data_valid, int_tx_trigger, 
   tx_shift_empty, u_rfe, tx_fifo_empty, 
   rx_fifo_empty, tx_busy, rx_busy
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
// clock and reset
//
input 			pclk;
input			presetn;
input			psel;
input			pwrite;
input			penable;
input	[7:0]	paddr;
input	[`APB_DATA_WIDTH-1 :0] pwdata;
//
// interrupt ID
//
input	[3:0]	u_int_id;
`ifdef  FIFO_MODE_USER
	input	[BINARY_ADD1:0]  	num_data_in_tx_fifo;
	input	[BINARY_ADD1:0]  	num_data_in_rx_fifo;
	input		tx_fifo_full;
	input	  	rx_fifo_full;
`endif
input	[7:0]	rx_buffer;
input	[7:0]	u_msr;
input	[2:0] 	error_sta;// line status
input			u_overrun;
input			rx_data_valid;
input			int_tx_trigger;
input			tx_shift_empty;
input			u_rfe;
//
// uart status
//
input		tx_fifo_empty;
input	  	rx_fifo_empty;
input		tx_busy;
input		rx_busy;
//
//output
//
output 	[`APB_DATA_WIDTH-1 :0]	prdata;
//
//modem
//
output		u_out2;
output		u_out1;
output		u_rts;
output		u_dtr;
output		u_lb;
//
//interrupt
//
output		u_int_modem_enable;
output		u_int_rx_enable;
output		u_int_tx_enable;
output		u_int_error_enable;
//
//fifo
//

output	  		rd_rx_fifo;
output			rd_rx_sram;
output			wr_tx_fifo;
//
//line control
//
output			u_dlab;
output			u_bc;
output	[1:0]	u_eps;
output			u_pen;
output			u_stop;
output	[1:0]	u_dls;
`ifdef DMA_EXTRA_USER 
	output			u_dmasa;
	`ifdef FIFO_MODE_USER
		output			u_dmam;  
	`endif
`endif
output			rd_msr;
output			rd_lsr;
`ifdef BUSY_DETECT_USER 
output			u_detect_busy;
`endif
output	[15:0]	u_divisor;
//
//reset
//
output		resetn_to_tx_fifo;
output		resetn_to_rx_fifo;
output		resetn;
//
// frame length
//
output 	[3:0]	fl_rx;
output 	[3:0]	fl_tx;
output 			half_stop;
output 			uart_enable;
output 			dvsr_eq_1;
output			tx_sram_csn;
`ifdef FIFO_MODE_USER
	output				u_halt;	// tx halt
	output			[1:0]	u_rxft;
	output				u_fifoe;
	`ifdef THRE_MODE_USER
	output		u_int_tx_trigger_enable;
		output			[1:0]	u_txft;
	`endif
	`ifdef MODEM_AUTOFLOW_USER
		output				u_afce;
	`endif
`endif
//
//reg
//
reg [`APB_DATA_WIDTH-1 :0]	prdata;
reg	[15:0]	u_divisor;

reg [3:0]	fl_rx;
reg [3:0]	fl_tx;
reg 		half_stop;

reg		u_lb ;//	= u_fcr[2] ;
reg		u_rts; //	= u_fcr[1] ;
reg		u_dtr;//	= u_fcr[0] ;
reg		u_out2;
reg		u_out1;
//
//interrupt
//
//reg	u_int_tx_trigger_enable;// = u_ier[4];////73210
reg		u_int_modem_enable ;//	= u_ier[3];
reg		u_int_rx_enable ;///	= u_ier[2] ;
reg		u_int_tx_enable ;//	= u_ier[1];
reg		u_int_error_enable ;///	= u_ier[0];
//
//line control
//
reg			u_dlab;
reg			u_bc;
reg	[1:0]	u_eps;
reg			u_pen;
reg			u_stop;
reg	[1:0]	u_dls;
//
//reset
//
reg 	u_reset;
reg  	resetn_to_tx_fifo;
reg		resetn_to_rx_fifo;
`ifdef BUSY_DETECT_USER 
	reg			u_detect_busy;
`endif
//
// DMA is selected
//
`ifdef DMA_EXTRA_USER
	reg		u_dmasa;	// software ACK
	`ifdef FIFO_MODE_USER
	reg		u_dmam;
	`endif
`endif
//
// FIFO is selected; FIFO control register
//
`ifdef FIFO_MODE_USER
	reg		fifo_resetn;
	reg		u_reset_rx_fifo;
	reg		u_reset_tx_fifo;
	reg		u_halt;	// tx halt
	reg	[1:0]	u_rxft;
	reg		fifoe_old;
	reg		u_fifoe;
	`ifdef THRE_MODE_USER
		reg		u_int_tx_trigger_enable;
		reg	[1:0]	u_txft;
	`endif
	`ifdef MODEM_AUTOFLOW_USER
		reg		u_afce;
	`endif
`endif
//
//wire
//
wire	[7:0]	u_ier;//73210
wire	[7:0]	u_lcr;
wire	[7:0]	u_mcr;//5,4,1,0
wire 			rd_apb_valid;
wire 			wr_apb_valid;
wire	[7:0] 	u_lsr;
wire	[4:0]	u_usr;
wire			rd_wr_fifo;
wire			dvsr_than_1;
wire			dvsr_eq_1;
//
//temp
//
wire 	[15:0] 	temp_rx_num_data;
wire	[15:0]	temp_tx_num_data;
`ifdef FIFO_MODE_USER	
	assign temp_rx_num_data = {{(15-BINARY_ADD1){1'b0}},num_data_in_rx_fifo[BINARY_ADD1:0]};
	assign temp_tx_num_data = {{(15-BINARY_ADD1){1'b0}},num_data_in_tx_fifo[BINARY_ADD1:0]};
`else 
	assign temp_rx_num_data = 16'd0;
	assign temp_tx_num_data = 16'd0;

`endif
//
//
//uart_enable (u_dlab ==0 & Divisor!=0)
//
assign	uart_enable = ( ~ u_dlab ) & ( dvsr_than_1 | u_divisor[0] );
assign	dvsr_than_1 = | u_divisor[15:1];
assign	dvsr_eq_1 = u_divisor[0] & (~dvsr_than_1);
//
//
// line status
//
assign u_lsr = {u_rfe, tx_shift_empty, int_tx_trigger, error_sta[2:0], u_overrun, rx_data_valid};
//
// uart status
//
assign 	u_busy = tx_busy | rx_busy; 
`ifdef FIFO_MODE_USER
	assign	u_usr = {rx_fifo_full,~rx_fifo_empty,tx_fifo_empty,~tx_fifo_full, u_busy};
`else assign	u_usr = {1'b0,~rx_fifo_empty,tx_fifo_empty,1'b0, u_busy};
`endif

//
//interrupt enbale
//
`ifdef  THRE_MODE_USER 
	assign 	u_ier = {u_int_tx_trigger_enable, 3'd0 , u_int_modem_enable,u_int_error_enable , u_int_tx_enable , u_int_rx_enable};
`else 	
	assign	u_ier = {4'd0 , u_int_modem_enable,u_int_error_enable , u_int_tx_enable , u_int_rx_enable};
`endif

`ifdef FIFO_MODE_USER
	`ifdef MODEM_AUTOFLOW_USER	
		assign 	u_mcr = {2'd0, u_afce, u_lb, u_out2, u_out1, u_rts, u_dtr};
	`else 	
		assign 	u_mcr = {3'd0, u_lb, u_out2, u_out1, u_rts, u_dtr};
	`endif
`else 	
	assign 	u_mcr = {3'd0, u_lb, u_out2, u_out1, u_rts, u_dtr};
`endif

//
//modem control
//

//assign	u_reset	=  u_srr[0];// bit 2,1 reset tx,rx fifo
//

//
//line control
//
assign	u_lcr	=	{u_dlab,u_bc,u_eps,u_pen,u_stop,u_dls};
//
// read rx_sram
//
assign rd_wr_fifo = psel & (paddr == 8'h00) & (~u_dlab);
assign rd_rx_sram = (~pwrite) & rd_wr_fifo;
assign tx_sram_csn = (pwrite) & rd_wr_fifo;
assign wr_tx_fifo = tx_sram_csn & penable;
assign rd_rx_fifo = rd_rx_sram & penable;
//
// read/write APB
//
assign rd_apb_valid = psel & (~pwrite) & penable;// APB read valid
assign wr_apb_valid = psel & pwrite & penable;// APB write valid
//
//generate read signals to clear some status register
//
assign rd_lsr = rd_apb_valid & (paddr == 8'h14);//read line status
assign rd_msr = rd_apb_valid & (paddr == 8'h18);//read modem status
assign rd_usr = rd_apb_valid & (paddr == 8'h7C);//read uart status	
//
//**********APB writes data****************
//
// synopsys sync_set_reset "resetn"
always @(posedge pclk)	begin
	if(!resetn) begin
		u_divisor <=`DELAY  16'd0;
		//interrupt enable //u_ier;//73210
		u_int_modem_enable 	<=`DELAY  1'b0;
		u_int_rx_enable 	<=`DELAY  1'b0;
		u_int_tx_enable 	<=`DELAY  1'b0;
		u_int_error_enable 	<=`DELAY  1'b0;
		// line control
		u_dlab 	<=`DELAY  1'b0;
		u_bc  	<=`DELAY  1'b0;
		u_eps 	<=`DELAY  2'd0;
		u_pen 	<=`DELAY  1'b0;
		u_stop 	<=`DELAY  1'b0;
		u_dls 	<=`DELAY  2'd0;
		//modem control// u_mcr;//5,4,1,0
		u_lb 	<=`DELAY  1'b0;
		u_out2	<=`DELAY  1'b0;
		u_out1	<=`DELAY  1'b0;
		u_rts 	<=`DELAY  1'b0;
		u_dtr 	<=`DELAY  1'b0;
		// software reset
		u_reset <=`DELAY  1'b0;
		u_reset <=`DELAY  1'b0;	
		`ifdef BUSY_DETECT_USER
			u_detect_busy <=`DELAY  1'b0;
		`endif
		`ifdef DMA_EXTRA_USER
			u_dmasa	<=`DELAY  1'b0;	// software ACK
			`ifdef FIFO_MODE_USER
				u_dmam 	<=`DELAY   1'b0;
			`endif
		`endif
		`ifdef FIFO_MODE_USER
			u_reset_rx_fifo	<=`DELAY   1'b0;
			u_reset_tx_fifo	<=`DELAY   1'b0;
			u_halt	<=`DELAY  1'b0;	// tx halt
			u_rxft 	<=`DELAY   2'd0;
			u_fifoe <=`DELAY   1'b0;
			`ifdef THRE_MODE_USER
				u_int_tx_trigger_enable <=`DELAY  1'b0;
				u_txft 	<=`DELAY   2'd0;
			`endif
			`ifdef MODEM_AUTOFLOW_USER
				u_afce 	<=`DELAY  1'b0;
			`endif
		`endif
	end
	else if (wr_apb_valid) begin

		casex (paddr[7:0])  // synopsys parallel_case 
			8'h00: 	if( u_dlab ) u_divisor[7:0] <=`DELAY  pwdata[7:0];
			8'h04: 	begin
				if( u_dlab )  u_divisor[15:8] <=`DELAY  pwdata[7:0];
				else begin
					`ifdef FIFO_MODE_USER
						`ifdef THRE_MODE_USER	
							u_int_tx_trigger_enable <=`DELAY  pwdata[7];////73210
						`endif
					`endif
					u_int_modem_enable 	<=`DELAY  pwdata[3];
					u_int_error_enable 	<=`DELAY  pwdata[2];
					u_int_tx_enable 	<=`DELAY  pwdata[1];
					u_int_rx_enable 	<=`DELAY  pwdata[0];

				end
			end
			8'h08:	begin
				`ifdef FIFO_MODE_USER
						`ifdef THRE_MODE_USER	
							u_txft 	<=`DELAY   pwdata[5:4];
						`endif
					u_rxft 	<=`DELAY   pwdata[7:6];
					`ifdef DMA_EXTRA_USER
						u_dmam 	<=`DELAY   pwdata[3];
					`endif
					u_reset_tx_fifo	<=`DELAY   pwdata[2];
					u_reset_rx_fifo	<=`DELAY   pwdata[1];
					u_fifoe <=`DELAY   pwdata[0];
				`endif
			end
			8'h0C: begin
				u_bc  	<=`DELAY  pwdata[6];
				`ifdef BUSY_DETECT_USER
					if(u_busy) u_detect_busy <=`DELAY  1'b1; 
					else  begin 
						u_dlab 	<=`DELAY  pwdata[7];
						u_eps 	<=`DELAY  pwdata[5:4];
						u_pen 	<=`DELAY  pwdata[3];
						u_stop 	<=`DELAY  pwdata[2];
						u_dls 	<=`DELAY  pwdata[1:0];
					end
				`else 
					if(u_busy == 1'b0)  begin 
						u_dlab 	<=`DELAY  pwdata[7];
						u_eps 	<=`DELAY  pwdata[5:4];
						u_pen 	<=`DELAY  pwdata[3];
						u_stop 	<=`DELAY  pwdata[2];
						u_dls 	<=`DELAY  pwdata[1:0];
					end
				`endif
			end
			8'h10: begin	
				//modem control// u_mcr;//5,4,1,0
				`ifdef FIFO_MODE_USER
					`ifdef MODEM_AUTOFLOW_USER
					u_afce 	<=`DELAY  pwdata[5];
					`endif
				`endif
				u_lb 	<=`DELAY  pwdata[4];
				u_out2	<=`DELAY  pwdata[3];
				u_out1	<=`DELAY  pwdata[2];
				u_rts 	<=`DELAY  pwdata[1];
				u_dtr 	<=`DELAY  pwdata[0];
			end
			8'h88:	begin
				u_reset <=`DELAY  pwdata[0];
				`ifdef FIFO_MODE_USER
					u_reset_tx_fifo	<=`DELAY   pwdata[2];
					u_reset_rx_fifo	<=`DELAY   pwdata[1];
				`endif
			end
			//
			// SHADOW_USER begin
			//
			`ifdef SHADOW_USER 
			8'h8C:	u_rts <=`DELAY  pwdata[0];
			8'h90:	u_bc <=`DELAY  pwdata[0];
			`ifdef FIFO_MODE_USER
			`ifdef DMA_EXTRA_USER 
			8'h94:	u_dmam <=`DELAY  pwdata[0];
			`endif
			8'h98:	u_fifoe <=`DELAY  pwdata[0];
			8'h9C:	u_rxft <=`DELAY  pwdata[1:0];
			`ifdef THRE_MODE_USER
			 8'hA0:	u_txft <=`DELAY  pwdata[1:0];
			`endif
			`endif
			`endif
			`ifdef FIFO_MODE_USER 
			8'hA4:	u_halt <=`DELAY  pwdata[0];
			`endif
			`ifdef DMA_EXTRA_USER 
			8'hA8:	u_dmasa <=`DELAY  pwdata[0];
			`endif
		endcase
	end
	else begin
		//
		// auto cleared
		//
		u_reset <=`DELAY  1'b0;
		`ifdef FIFO_MODE_USER
			u_reset_tx_fifo	<=`DELAY   1'b0;
			u_reset_rx_fifo	<=`DELAY   1'b0;
		`endif
		`ifdef DMA_EXTRA_USER
			u_dmasa <=`DELAY   1'b0;
		`endif
		`ifdef BUSY_DETECT_USER
			if(rd_usr) u_detect_busy <=`DELAY  1'b0; 
		`endif
		
	end	
end
//
// ********apb reads data*****************
//
generate
always @(*)	begin
	prdata = {(`APB_DATA_WIDTH){1'b0}};
	if(rd_apb_valid) begin
		casex ({paddr[7:2],2'd0}) // synopsys parallel_case 
			8'h00: 	if(u_dlab) prdata[7:0] = u_divisor[7:0];
				else prdata[7:0] = rx_buffer;
			8'h04: 	if(u_dlab) prdata[7:0] = u_divisor[15:8];
				else prdata[7:0] = u_ier;
			8'h08:	begin 
				`ifdef FIFO_MODE_USER 
					prdata[7] = u_fifoe;
					prdata[6] = u_fifoe;
					prdata[5:0] = {2'd0,u_int_id};
				`else prdata[7:0] = {4'd0,u_int_id};
				`endif
			end
			8'h0C:	prdata[7:0] = u_lcr;
			8'h10:	begin 
					prdata[4:0] = u_mcr[4:0];
					`ifdef FIFO_MODE_USER
					`ifdef MODEM_AUTOFLOW_USER
						prdata[5] = u_afce;
					`endif
					`endif
			end
			8'h14:	begin
					prdata[6:0] = u_lsr[6:0];
					`ifdef FIFO_MODE_USER
						prdata[7] = u_rfe;
					`endif
			end
			8'h18:	prdata[7:0] = u_msr;
			8'h7C:	prdata[4:0] = u_usr[4:0];
			8'h80:  begin 
					//prdata[BINARY_ADD1:0] = num_data_in_tx_fifo[BINARY_ADD1:0];
					if(`APB_DATA_WIDTH > 8) prdata[15:0] = temp_tx_num_data[15:0];
					else begin if(paddr[0]==1'b0) prdata[7:0] = temp_tx_num_data[7:0];
						else prdata[7:0] = temp_tx_num_data[15:8];
					end//prdata[D_W:0] = temp_tx_num_data[32:8];
					
			end
			8'h84:	begin 
					//prdata[BINARY_ADD1:0] = num_data_in_rx_fifo[BINARY_ADD1:0];
					if(`APB_DATA_WIDTH > 8) prdata[15:0] = temp_rx_num_data[15:0];
					else begin if(paddr[0]==1'b0) prdata[7:0] = temp_rx_num_data[7:0];
						else prdata[7:0] = temp_rx_num_data[15:8];
					end
			end
			//
			// SHADOW_USER begin
			//
			`ifdef SHADOW_USER 	
			8'h8C:	 prdata[0] = u_rts;
			8'h90:	prdata[0] = u_bc;
			`ifdef FIFO_MODE_USER
			`ifdef DMA_EXTRA_USER 
			8'h94:	prdata[0] = u_dmam;
			`endif
			8'h98:	prdata[0] = u_fifoe;
			8'h9C:	prdata[1:0] = u_rxft[1:0];
			`ifdef THRE_MODE_USER
			 8'hA0:	prdata[1:0] = u_txft[1:0];
			`endif
			`endif
			`endif
			`ifdef FIFO_MODE_USER
			8'hA4:	prdata[0] = u_halt;		
			`endif 
			default: prdata = {`APB_DATA_WIDTH{1'b0}};
		endcase
	end
end
endgenerate
//
//***************access control-register*******************
//
//line control
//
always @(*)	begin
	casex({u_dls,u_pen})
		3'b000: fl_rx = 4'd6;
		3'b010,3'b001: fl_rx = 4'd7;
		3'b100,3'b011: fl_rx = 4'd8;
		3'b110,3'b101: fl_rx = 4'd9;
		default: fl_rx = 4'd10;	
	endcase
end

always @(*)	begin
	if(u_stop & (|u_dls)) fl_tx = fl_rx + 4'd1;
	else fl_tx = fl_rx;
end
//
//  +0.5 Stop when STOP bit ==1 and data length ==5bit (DLS==00) 
//
always @(*)	begin
	if(u_stop & (~(|u_dls[1:0]))) half_stop = 1'b1;
	else half_stop = 1'b0;
end
//******************reset*****************
//reset top
//

assign resetn = presetn & (~u_reset);
//
// detect change of FIFO mode
//
`ifdef FIFO_MODE_USER
	always	@ (posedge pclk) begin
		fifoe_old <=`DELAY  u_fifoe;
	end
`endif
//
// reset tx_fifo 
//

always @(*)	begin
`ifdef FIFO_MODE_USER begin
		fifo_resetn = resetn & (~(fifoe_old ^ u_fifoe));
		resetn_to_tx_fifo = fifo_resetn & ( ~u_reset_tx_fifo);
		resetn_to_rx_fifo = fifo_resetn & ( ~u_reset_rx_fifo);
end
`else begin
		resetn_to_tx_fifo = resetn;
		resetn_to_rx_fifo = resetn;
	end
`endif
end
endmodule
