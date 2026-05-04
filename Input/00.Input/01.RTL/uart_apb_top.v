`include "define.h"
module uart_apb_top(/*AUTOARG*/
   // Outputs
	prdata, 
 	uart_rts_n, 
	uart_dtr_n, 
	uart_out1_n, 
   	uart_out2_n, 
	uart_sout, 
	uart_int,
	`ifdef	BAUD_CLK
		uart_baundout_n,
	`endif
	`ifdef  FIFO_MODE_USER
	`ifdef	MEM_SELECT_USER
		uart_rx_sram_add_rd, 
		uart_rx_sram_add_wr, 
		uart_rx_sram_datain, 
		uart_rx_sram_rd_n, 
		uart_rx_sram_wr_n, 
		uart_rx_sram_csn, 
		uart_tx_sram_add_rd, 
		uart_tx_sram_add_wr, 
		uart_tx_sram_datain, 
		uart_tx_sram_rd_n, 
		uart_tx_sram_wr_n, 
		uart_tx_sram_csn, 
	`endif
	`endif
	`ifdef DMA_EXTRA_USER
		uart_dma_rx_req, 
		uart_dma_rx_single, 
		uart_dma_tx_req, 
		uart_dma_tx_single, 
    `endif
   // Inputs
   	pclk, 
	presetn, 
	psel, 
	pwrite, 
	penable, 
	paddr, 
	pwdata,
	`ifdef  FIFO_MODE_USER
 	`ifdef	MEM_SELECT_USER
		rx_sram_dataout, 
		tx_sram_dataout,
	`endif
	`endif
    `ifdef DMA_EXTRA_USER
		dma_rx_ack, 
		dma_tx_ack,
    `endif
  	uart_sin, 
	uart_cts_n, 
	uart_dsr_n, 
	uart_ri_n, 
	uart_dcd_n
     );
parameter  DEEP_FIFO = `DEEP_FIFO_MODE;
parameter BINARY_DEEP  = log2 (DEEP_FIFO);
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
//APB input
//
input 		pclk;
input		presetn;
input		psel;
input		pwrite;
input		penable;
input	[7:0]	paddr;
input	[`APB_DATA_WIDTH-1 :0] pwdata;
//
//DMA input
//
`ifdef DMA_EXTRA_USER
	input		dma_rx_ack;
	input		dma_tx_ack;
`endif
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
//SRAM
//
`ifdef  FIFO_MODE_USER
`ifdef	MEM_SELECT_USER
	input	[10:0]	rx_sram_dataout;
	input	[7:0]	tx_sram_dataout;

`endif
`endif

//
//APB output
//
output 	[`APB_DATA_WIDTH-1 :0]	prdata;
//
//DMA output
//
`ifdef DMA_EXTRA_USER
	output	  	uart_dma_rx_req;
	output	  	uart_dma_rx_single;
	output	  	uart_dma_tx_req;
	output	  	uart_dma_tx_single;
`endif

//
//clock gate
//
//
//modem
//
output	  	uart_rts_n;
output		uart_dtr_n;
output	  	uart_out1_n;
output		uart_out2_n;
//
//serial output
//
output		uart_sout;
output		uart_int;		// From uart_interrupt of uart_interrupt.v
`ifdef	BAUD_CLK
	output		uart_baundout_n;
`endif

//
//external SRAM
//
`ifdef  FIFO_MODE_USER
 	`ifdef	MEM_SELECT_USER
	output	[BINARY_DEEP:0] uart_rx_sram_add_rd;
	output	[BINARY_DEEP:0] uart_rx_sram_add_wr;
	output	[10:0] 		uart_rx_sram_datain;
	output			uart_rx_sram_rd_n;
	output			uart_rx_sram_wr_n;
	output			uart_rx_sram_csn;

	output	[BINARY_DEEP:0] uart_tx_sram_add_rd;
	output	[BINARY_DEEP:0] uart_tx_sram_add_wr;
	output	[7:0] 		uart_tx_sram_datain;
	output			uart_tx_sram_rd_n;
	output			uart_tx_sram_wr_n;
	output			uart_tx_sram_csn;
	`endif
`endif

// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			be;			// From uart_apb_rx of uart_apb_rx.v
wire			brg_clken;		// From uart_apb_baudrate of uart_apb_baudrate.v
wire			cts;			// From uart_syn_detect of uart_syn_detect.v
wire [7:0]		data_to_rx_fifo;	// From uart_apb_rx of uart_apb_rx.v
wire			dcd;			// From uart_syn_detect of uart_syn_detect.v
wire			dsr;			// From uart_syn_detect of uart_syn_detect.v
wire			dvsr_eq_1;		// From uart_rw_control of uart_rw_control.v
wire [2:0]		error_sta;		// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			fe;			// From uart_apb_rx of uart_apb_rx.v
wire [3:0]		fl_rx;			// From uart_rw_control of uart_rw_control.v
wire [3:0]		fl_tx;			// From uart_rw_control of uart_rw_control.v
wire			half_stop;		// From uart_rw_control of uart_rw_control.v
wire			int_rx_trigger;		// From uart_interrupt of uart_interrupt.v
wire			int_tx_trigger;		// From uart_interrupt of uart_interrupt.v
wire			pe;			// From uart_apb_rx of uart_apb_rx.v
wire			rd_lsr;			// From uart_rw_control of uart_rw_control.v
wire			rd_msr;			// From uart_rw_control of uart_rw_control.v
wire			rd_rx_fifo;		// From uart_rw_control of uart_rw_control.v
wire			rd_rx_sram;		// From uart_rw_control of uart_rw_control.v
wire			rd_tx_fifo;		// From uart_apb_tx_sram of uart_apb_tx_sram.v, ...

wire			resetn;			// From uart_rw_control of uart_rw_control.v
wire			resetn_to_rx_fifo;	// From uart_rw_control of uart_rw_control.v
wire			resetn_to_tx_fifo;	// From uart_rw_control of uart_rw_control.v
wire			ri;			// From uart_syn_detect of uart_syn_detect.v
wire [7:0]		rx_buffer;		// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			rx_busy;		// From uart_apb_rx of uart_apb_rx.v
wire			rx_fifo_empty;		// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			sout;			// From uart_apb_tx_sram of uart_apb_tx_sram.v, ...
wire			syn_sin;		// From uart_syn_detect of uart_syn_detect.v
wire [7:0]		tx_buffer;		// From uart_apb_tx_fifo_sram of uart_apb_tx_fifo_sram.v, ...
wire			tx_busy;		// From uart_apb_tx_sram of uart_apb_tx_sram.v, ...
wire			tx_enable;		// From uart_apb_tx_sram of uart_apb_tx_sram.v, ...
wire			tx_fifo_empty;		// From uart_apb_tx_fifo_sram of uart_apb_tx_fifo_sram.v, ...
wire			tx_shift_empty;		// From uart_apb_tx_sram of uart_apb_tx_sram.v, ...
wire			tx_sram_csn;		// From uart_rw_control of uart_rw_control.v
wire			u_bc;			// From uart_rw_control of uart_rw_control.v
wire			u_dcts;			// From uart_modem of uart_modem.v
wire			u_ddcd;			// From uart_modem of uart_modem.v
wire			u_ddsr;			// From uart_modem of uart_modem.v
wire [15:0]		u_divisor;		// From uart_rw_control of uart_rw_control.v
wire			u_dlab;			// From uart_rw_control of uart_rw_control.v
wire [1:0]		u_dls;			// From uart_rw_control of uart_rw_control.v
wire			u_dri;			// From uart_modem of uart_modem.v
wire			u_dtr;			// From uart_rw_control of uart_rw_control.v
wire [1:0]		u_eps;			// From uart_rw_control of uart_rw_control.v
wire			u_int_error_enable;	// From uart_rw_control of uart_rw_control.v
wire [3:0]		u_int_id;		// From uart_interrupt of uart_interrupt.v
wire			u_int_modem_enable;	// From uart_rw_control of uart_rw_control.v
wire			u_int_rx_enable;	// From uart_rw_control of uart_rw_control.v
wire			u_int_tx_enable;	// From uart_rw_control of uart_rw_control.v
wire			u_lb;			// From uart_rw_control of uart_rw_control.v
wire [7:0]		u_msr;			// From uart_modem of uart_modem.v
wire			u_out1;			// From uart_rw_control of uart_rw_control.v
wire			u_out2;			// From uart_rw_control of uart_rw_control.v
wire			u_overrun;		// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			u_pen;			// From uart_rw_control of uart_rw_control.v
wire			u_rfe;			// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			u_rts;			// From uart_rw_control of uart_rw_control.v
wire			u_stop;			// From uart_rw_control of uart_rw_control.v
wire			uart_enable;		// From uart_rw_control of uart_rw_control.v
wire			wr_rx_fifo;		// From uart_apb_rx of uart_apb_rx.v
wire			rx_data_valid;		// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			wr_tx_fifo;		// From uart_rw_control of uart_rw_control.v
// End of automatics
`ifdef DMA_EXTRA_USER
	wire			u_dmam;			// From uart_rw_control of uart_rw_control.v
	wire			u_dmasa;		// From uart_rw_control of uart_rw_control.v
`endif
`ifdef FIFO_MODE_USER
	wire			u_to;			// From uart_apb_baudrate of uart_apb_baudrate.v
	wire			u_halt;			// From uart_rw_control of uart_rw_control.v
	wire [1:0]		u_rxft;			// From uart_rw_control of uart_rw_control.v
	wire			u_fifoe;		// From uart_rw_control of uart_rw_control.v
	`ifdef THRE_MODE_USER
		wire			u_int_tx_trigger_enable;// From uart_rw_control of uart_rw_control.v
		wire [1:0]		u_txft;			// From uart_rw_control of uart_rw_control.v
	`endif
	`ifdef MODEM_AUTOFLOW_USER
	wire			u_afce;			// From uart_rw_control of uart_rw_control.v
	`endif
`endif

`ifdef  FIFO_MODE_USER
`ifdef	MODEM_AUTOFLOW_USER
	wire			auto_flow_cts;		// From uart_modem of uart_modem.v
	wire			auto_flow;		// From uart_modem of uart_modem.v
`endif
`endif

`ifdef  FIFO_MODE_USER
wire [BINARY_ADD1:0]	num_data_in_rx_fifo;	// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire [BINARY_ADD1:0]	num_data_in_tx_fifo;	// From uart_apb_tx_fifo_sram of uart_apb_tx_fifo_sram.v, ...
wire			rx_fifo_full;		// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			tx_fifo_full;		// From uart_apb_tx_fifo_sram of uart_apb_tx_fifo_sram.v, ...
wire			rx_fifo_almostfull;	// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
wire			wr_rx_fifo_valid;	// From uart_rx_fifo_sram of uart_rx_fifo_sram.v, ...
 	`ifdef	MEM_SELECT_USER
	wire			rd_tx_sram;		// From uart_apb_tx_sram of uart_apb_tx_sram.v
	`endif
`endif
`ifdef BUSY_DETECT_USER 
	wire						u_detect_busy;
 `endif

`ifdef	DMA_EXTRA_USER
uart_apb_dma 	uart_apb_dma (/*AUTOINST*/
					 // Outputs
					 .uart_dma_rx_req(uart_dma_rx_req),
					 .uart_dma_rx_single(uart_dma_rx_single),
					 .uart_dma_tx_req(uart_dma_tx_req),
					 .uart_dma_tx_single(uart_dma_tx_single),
					 // Inputs
					 .resetn(resetn),
					 .pclk(pclk),
					 .tx_fifo_empty(tx_fifo_empty),
					 .tx_fifo_full(tx_fifo_full),
					 .int_tx_trigger(int_tx_trigger),
					 .dma_tx_ack(dma_tx_ack),
					 .rx_data_valid(rx_data_valid),
					 .rx_fifo_empty(rx_fifo_empty),
					 .int_rx_trigger(int_rx_trigger),
					 .dma_rx_ack(dma_rx_ack),
					`ifdef  FIFO_MODE_USER
						.u_to(u_to),
					`endif
					 .u_fifoe(u_fifoe),
					 .u_dmam(u_dmam),
					 .u_dmasa(u_dmasa));
`endif
uart_apb_rx 		uart_apb_rx (/*AUTOINST*/
						    // Outputs
						    .rx_busy(rx_busy),
						    .wr_rx_fifo(wr_rx_fifo),
						    .data_to_rx_fifo(data_to_rx_fifo[7:0]),
						    .pe(pe),
						    .fe(fe),
						    .be(be),
						    // Inputs
						    .pclk(pclk),
						    .resetn(resetn),
						    .uart_enable(uart_enable),
						    .u_lb(u_lb),
						    .u_dls(u_dls[1:0]),
						    .u_eps(u_eps[1:0]),
						    .u_pen(u_pen),
						    .fl_rx(fl_rx[3:0]),
						    .sout(sout),
						    .syn_sin(syn_sin),
						    .brg_clken(brg_clken));

`ifdef  FIFO_MODE_USER
 	`ifdef	MEM_SELECT_USER
		uart_apb_rx_fifo_sram		uart_apb_rx_fifo_sram(/*AUTOINST*/
									 // Outputs
									 .rx_fifo_empty(rx_fifo_empty),
									 .rx_data_valid(rx_data_valid),
									 .rx_fifo_full(rx_fifo_full),
									 .rx_fifo_almostfull(rx_fifo_almostfull),
									 .rx_buffer(rx_buffer[7:0]),
									 .error_sta(error_sta[2:0]),
									 .uart_rx_sram_add_rd(uart_rx_sram_add_rd[BINARY_DEEP:0]),
									 .uart_rx_sram_add_wr(uart_rx_sram_add_wr[BINARY_DEEP:0]),
									 .uart_rx_sram_datain(uart_rx_sram_datain[10:0]),
									 .uart_rx_sram_rd_n(uart_rx_sram_rd_n),
									 .uart_rx_sram_wr_n(uart_rx_sram_wr_n),
									 .uart_rx_sram_csn(uart_rx_sram_csn),
									 .u_overrun(u_overrun),
									 .u_rfe(u_rfe),
									 .num_data_in_rx_fifo(num_data_in_rx_fifo[BINARY_ADD1:0]),
									 .wr_rx_fifo_valid(wr_rx_fifo_valid),
									 // Inputs
									 .resetn_to_rx_fifo(resetn_to_rx_fifo),
									 .pclk(pclk),
									 .rd_rx_fifo(rd_rx_fifo),
									 .rd_rx_sram(rd_rx_sram),
									 .wr_rx_fifo(wr_rx_fifo),
									 .data_to_rx_fifo(data_to_rx_fifo[7:0]),
									 .be(be),
									 .fe(fe),
									 .pe(pe),
									 .u_fifoe(u_fifoe),
									 .rd_lsr(rd_lsr),
									 .rx_sram_dataout(rx_sram_dataout[10:0]));
		uart_apb_tx_fifo_sram		uart_apb_tx_fifo_sram(/*AUTOINST*/
										     // Outputs
										     .tx_fifo_empty(tx_fifo_empty),
										     .tx_fifo_full(tx_fifo_full),
										     .tx_buffer(tx_buffer[7:0]),
										     .uart_tx_sram_add_rd(uart_tx_sram_add_rd[BINARY_DEEP:0]),
										     .uart_tx_sram_add_wr(uart_tx_sram_add_wr[BINARY_DEEP:0]),
										     .uart_tx_sram_datain(uart_tx_sram_datain[7:0]),
										     .uart_tx_sram_rd_n(uart_tx_sram_rd_n),
										     .uart_tx_sram_wr_n(uart_tx_sram_wr_n),
										     .uart_tx_sram_csn(uart_tx_sram_csn),
										     .num_data_in_tx_fifo(num_data_in_tx_fifo[BINARY_ADD1:0]),
										     // Inputs
										     .resetn_to_tx_fifo(resetn_to_tx_fifo),
										     .pclk(pclk),
										     .rd_tx_fifo(rd_tx_fifo),
										     .rd_tx_sram(rd_tx_sram),
										     .wr_tx_fifo(wr_tx_fifo),
										     .pwdata(pwdata[7:0]),
										     .u_fifoe(u_fifoe),
										     .tx_sram_csn(tx_sram_csn),
										     .tx_sram_dataout(tx_sram_dataout[7:0]));
	`else
		uart_apb_rx_fifo		uart_apb_rx_fifo(/*AUTOINST*/
							    // Outputs
							    .rx_fifo_empty(rx_fifo_empty),
							    .rx_fifo_full(rx_fifo_full),
							    .rx_fifo_almostfull(rx_fifo_almostfull),
							    .rx_buffer(rx_buffer[7:0]),
							    .error_sta(error_sta[2:0]),
							    .u_overrun(u_overrun),
							    .u_rfe(u_rfe),
							    .rx_data_valid(rx_data_valid),
							    .wr_rx_fifo_valid(wr_rx_fifo_valid),
							    .num_data_in_rx_fifo(num_data_in_rx_fifo[BINARY_ADD1:0]),
							    // Inputs
							    .resetn_to_rx_fifo(resetn_to_rx_fifo),
							    .pclk(pclk),
							    .rd_rx_fifo(rd_rx_fifo),
							    .wr_rx_fifo(wr_rx_fifo),
							    .data_to_rx_fifo(data_to_rx_fifo[7:0]),
							    .be(be),
							    .fe(fe),
							    .pe(pe),
							    .u_fifoe(u_fifoe),
							    .rd_lsr(rd_lsr));
	uart_apb_tx_fifo		uart_apb_tx_fifo(/*AUTOINST*/
						    // Outputs
						    .tx_fifo_empty(tx_fifo_empty),
						    .tx_fifo_full(tx_fifo_full),
						    .tx_buffer(tx_buffer[7:0]),
						    .num_data_in_tx_fifo(num_data_in_tx_fifo[BINARY_ADD1:0]),
						    // Inputs
						    .resetn_to_tx_fifo(resetn_to_tx_fifo),
						    .pclk(pclk),
						    .rd_tx_fifo(rd_tx_fifo),
						    .wr_tx_fifo(wr_tx_fifo),
						    .pwdata(pwdata[7:0]),
						    .u_fifoe(u_fifoe));
	`endif
`else 	uart_apb_rx_buffer 	uart_apb_rx_buffer (/*AUTOINST*/
						       // Outputs
						       .rx_fifo_empty(rx_fifo_empty),
						       .rx_buffer(rx_buffer[7:0]),
						       .error_sta(error_sta[2:0]),
						       .u_overrun(u_overrun),
						       .rx_data_valid(rx_data_valid),
						       .u_rfe(u_rfe),
						       // Inputs
						       .resetn_to_rx_fifo(resetn_to_rx_fifo),
						       .pclk(pclk),
						       .rd_rx_fifo(rd_rx_fifo),
						       .wr_rx_fifo(wr_rx_fifo),
						       .data_to_rx_fifo(data_to_rx_fifo[7:0]),
						       .be(be),
						       .fe(fe),
						       .pe(pe),
						       .rd_lsr(rd_lsr));
	uart_apb_tx_buffer 	uart_apb_tx_buffer (/*AUTOINST*/
						       // Outputs
						       .tx_fifo_empty(tx_fifo_empty),
						       .tx_buffer(tx_buffer[7:0]),
						       // Inputs
						       .resetn_to_tx_fifo(resetn_to_tx_fifo),
						       .pclk(pclk),
						       .rd_tx_fifo(rd_tx_fifo),
						       .wr_tx_fifo(wr_tx_fifo),
						       .pwdata(pwdata[7:0]));
`endif
uart_apb_interrupt		uart_apb_interrupt(/*AUTOINST*/
					      // Outputs
					      .uart_int(uart_int),
					      .u_int_id(u_int_id[3:0]),
					      .int_rx_trigger(int_rx_trigger),
					      .int_tx_trigger(int_tx_trigger),
					      // Inputs
					      .resetn(resetn),
					      .pclk(pclk),
						  `ifdef DMA_EXTRA_USER
					      .u_dmam(u_dmam),
						`endif
					      .tx_fifo_empty(tx_fifo_empty),
						`ifdef  FIFO_MODE_USER
							.u_rxft(u_rxft[1:0]),
					      .u_fifoe(u_fifoe),
						`ifdef	MODEM_AUTOFLOW_USER
							.auto_flow(auto_flow),
						`endif						
						`endif
					      .u_dcts(u_dcts),
					      .u_ddsr(u_ddsr),
					      .u_dri(u_dri),
					      .u_ddcd(u_ddcd),
					      .error_sta(error_sta[2:0]),
					      .u_overrun(u_overrun),
						`ifdef  FIFO_MODE_USER
							.u_to(u_to),
							.num_data_in_rx_fifo(num_data_in_rx_fifo[BINARY_ADD1:0]),
							.num_data_in_tx_fifo(num_data_in_tx_fifo[BINARY_ADD1:0]),
						`endif
					      .rx_data_valid(rx_data_valid),
						`ifdef THRE_MODE_USER
					        .u_int_tx_trigger_enable(u_int_tx_trigger_enable),
							.u_txft(u_txft[1:0]),
						`endif
					      .rx_fifo_empty(rx_fifo_empty),
						  `ifdef BUSY_DETECT_USER 
							.u_detect_busy(u_detect_busy),
						  `endif
					      .u_int_modem_enable(u_int_modem_enable),
					      .u_int_rx_enable(u_int_rx_enable),
					      .u_int_tx_enable(u_int_tx_enable),
					      .u_int_error_enable(u_int_error_enable));
uart_apb_modem		uart_apb_modem(/*AUTOINST*/
					  // Outputs
					  .uart_rts_n(uart_rts_n),
					  .uart_dtr_n(uart_dtr_n),
					  .uart_out1_n(uart_out1_n),
					  .uart_out2_n(uart_out2_n),
					  .u_msr(u_msr[7:0]),
					`ifdef  FIFO_MODE_USER
					`ifdef	MODEM_AUTOFLOW_USER
						.auto_flow_cts(auto_flow_cts),
						.auto_flow(auto_flow),
					`endif
					`endif
					   .u_dcts(u_dcts),
					  .u_ddsr(u_ddsr),
					  .u_dri(u_dri),
					  .u_ddcd(u_ddcd),
					  // Inputs
					  .resetn(resetn),
					  .pclk(pclk),
					  .cts(cts),
					  .dsr(dsr),
					  .ri(ri),
					  .dcd(dcd),
					  .u_out2(u_out2),
					  .u_out1(u_out1),
					  .u_rts(u_rts),
					  .u_dtr(u_dtr),
					  .u_lb(u_lb),
					  .rx_fifo_empty(rx_fifo_empty),
					  .int_rx_trigger(int_rx_trigger),
					  .rx_busy(rx_busy),
					`ifdef  FIFO_MODE_USER
					`ifdef	MODEM_AUTOFLOW_USER
						.u_rxft(u_rxft[1:0]),
						.rx_fifo_full(rx_fifo_full),
					  	.rx_fifo_almostfull(rx_fifo_almostfull),
					  .u_afce(u_afce),
					  .u_fifoe(u_fifoe),
					`endif
					`endif
					  .rd_msr(rd_msr));
uart_apb_syn_detect	uart_apb_syn_detect(/*AUTOINST*/
					       // Outputs
					       .cts(cts),
					       .dsr(dsr),
					       .ri(ri),
					       .dcd(dcd),
					       .syn_sin(syn_sin),
					       // Inputs
					       .resetn(resetn),
					       .pclk(pclk),
					       .uart_sin(uart_sin),
					       .uart_cts_n(uart_cts_n),
					       .uart_dsr_n(uart_dsr_n),
					       .uart_ri_n(uart_ri_n),
					       .uart_dcd_n(uart_dcd_n));
uart_apb_baudrate	uart_apb_baudrate(/*AUTOINST*/
							 // Outputs
							 `ifdef  FIFO_MODE_USER
								.u_to(u_to),
							`endif
							 .brg_clken(brg_clken),
							`ifdef  BAUD_CLK
								.uart_baundout_n(uart_baundout_n),
							`endif
							 // Inputs
							 .pclk(pclk),
							 .resetn(resetn),
							 .uart_enable(uart_enable),
							 .dvsr_eq_1(dvsr_eq_1),
							 .u_divisor(u_divisor[15:0]),
							 .tx_busy(tx_busy),
							 .rx_busy(rx_busy),
							 .rd_rx_fifo(rd_rx_fifo),
							`ifdef  FIFO_MODE_USER
								.wr_rx_fifo_valid(wr_rx_fifo_valid),
							    .u_fifoe(u_fifoe),
							`endif
							 .half_stop(half_stop),
							 .fl_tx(fl_tx[3:0]),
							 .rx_data_valid(rx_data_valid));
`ifdef	MEM_SELECT_USER 
	uart_apb_tx_sram 	uart_apb_tx_sram(/*AUTOINST*/
								// Outputs
								.tx_busy(tx_busy),
								.uart_sout(uart_sout),
								.rd_tx_fifo(rd_tx_fifo),
								.sout(sout),
								.rd_tx_sram(rd_tx_sram),
								.tx_shift_empty(tx_shift_empty),
								.tx_enable(tx_enable),
								// Inputs
								.pclk(pclk),
								.resetn(resetn),
								.uart_enable(uart_enable),
								.u_halt(u_halt),
								.u_fifoe(u_fifoe),
								.tx_fifo_empty(tx_fifo_empty),
								.tx_buffer(tx_buffer[7:0]),
								.u_bc(u_bc),
								.u_lb(u_lb),
								.u_dls(u_dls[1:0]),
								.u_eps(u_eps[1:0]),
								.u_pen(u_pen),
								.fl_tx(fl_tx[3:0]),
								.half_stop(half_stop),
								`ifdef  FIFO_MODE_USER
								`ifdef	MODEM_AUTOFLOW_USER
									.auto_flow_cts(auto_flow_cts),
								`endif
								`endif
								.brg_clken(brg_clken));
`else uart_apb_tx		uart_apb_tx(/*AUTOINST*/
							   // Outputs
							   .tx_busy(tx_busy),
							   .uart_sout(uart_sout),
							   .rd_tx_fifo(rd_tx_fifo),
							   .sout(sout),
							   .tx_shift_empty(tx_shift_empty),
							   .tx_enable(tx_enable),
							   // Inputs
							   .pclk(pclk),
							   .resetn(resetn),
							   .uart_enable(uart_enable),
							   .tx_fifo_empty(tx_fifo_empty),
							   .tx_buffer(tx_buffer[7:0]),
							   .u_bc(u_bc),
							   .u_lb(u_lb),
							   .u_dls(u_dls[1:0]),
							   .u_eps(u_eps[1:0]),
							   .u_pen(u_pen),
							   .fl_tx(fl_tx[3:0]),
							   .half_stop(half_stop),
							   `ifdef  FIFO_MODE_USER
							   .u_halt(u_halt),
							   .u_fifoe(u_fifoe),
							   `ifdef	MODEM_AUTOFLOW_USER
									.auto_flow_cts(auto_flow_cts),
								`endif
								`endif
							   .brg_clken(brg_clken));
`endif
uart_apb_rw_control 	uart_apb_rw_control (/*AUTOINST*/
						// Outputs
						.prdata(prdata[`APB_DATA_WIDTH-1:0]),
						.u_out2(u_out2),
						.u_out1(u_out1),
						.u_rts(u_rts),
						.u_dtr(u_dtr),
						.u_lb(u_lb),
						.u_int_modem_enable(u_int_modem_enable),
						.u_int_rx_enable(u_int_rx_enable),
						.u_int_tx_enable(u_int_tx_enable),
						.u_int_error_enable(u_int_error_enable),
						.rd_rx_fifo(rd_rx_fifo),
						.rd_rx_sram(rd_rx_sram),
						.wr_tx_fifo(wr_tx_fifo),
						.u_dlab(u_dlab),
						.u_bc(u_bc),
						.u_eps(u_eps[1:0]),
						.u_pen(u_pen),
						.u_stop(u_stop),
						.u_dls(u_dls[1:0]),
						.rd_msr(rd_msr),
						.rd_lsr(rd_lsr),
						`ifdef DMA_EXTRA_USER 
						.u_dmasa(u_dmasa),
						`ifdef FIFO_MODE_USER
							.u_dmam(u_dmam),
						`endif
						`endif
						`ifdef BUSY_DETECT_USER 
							.u_detect_busy(u_detect_busy),
						  `endif
						.u_divisor(u_divisor[15:0]),
						.resetn_to_tx_fifo(resetn_to_tx_fifo),
						.resetn_to_rx_fifo(resetn_to_rx_fifo),
						.resetn(resetn),
						.fl_rx(fl_rx[3:0]),
						.fl_tx(fl_tx[3:0]),
						.half_stop(half_stop),
						.uart_enable(uart_enable),
						.dvsr_eq_1(dvsr_eq_1),
						.tx_sram_csn(tx_sram_csn),
						`ifdef FIFO_MODE_USER
							.u_halt(u_halt),
							.u_rxft(u_rxft[1:0]),
							.u_fifoe(u_fifoe),
						`ifdef THRE_MODE_USER
							.u_int_tx_trigger_enable(u_int_tx_trigger_enable),
							.u_txft(u_txft[1:0]),
						`endif
						`ifdef MODEM_AUTOFLOW_USER
							.u_afce(u_afce),
						`endif
						`endif
						// Inputs
						.pclk(pclk),
						.presetn(presetn),
						.psel(psel),
						.pwrite(pwrite),
						.penable(penable),
						.paddr(paddr[7:0]),
						.pwdata(pwdata[`APB_DATA_WIDTH-1:0]),
						.u_int_id(u_int_id[3:0]),
						`ifdef  FIFO_MODE_USER
							.num_data_in_rx_fifo(num_data_in_rx_fifo[BINARY_ADD1:0]),
							.num_data_in_tx_fifo(num_data_in_tx_fifo[BINARY_ADD1:0]),
							.tx_fifo_full(tx_fifo_full),
							.rx_fifo_full(rx_fifo_full),
						`endif
						.rx_buffer(rx_buffer[7:0]),
						.u_msr(u_msr[7:0]),
						.error_sta(error_sta[2:0]),
						.u_overrun(u_overrun),
						.rx_data_valid(rx_data_valid),
						.int_tx_trigger(int_tx_trigger),
						.tx_shift_empty(tx_shift_empty),
						.u_rfe(u_rfe),
						.tx_fifo_empty(tx_fifo_empty),
						.rx_fifo_empty(rx_fifo_empty),
						.tx_busy(tx_busy),
						.rx_busy(rx_busy));
endmodule 
