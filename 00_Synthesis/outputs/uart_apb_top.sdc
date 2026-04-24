# ####################################################################

#  Created by Genus(TM) Synthesis Solution 22.12-s082_1 on Fri Apr 24 13:14:22 +07 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design uart_apb_top

create_clock -name "CLK" -period 2.0 -waveform {0.0 1.0} [get_ports CLK]
set_clock_transition 0.1 [get_clocks CLK]
set_load -pin_load 0.003 [get_ports {PRDATA[31]}]
set_load -pin_load 0.003 [get_ports {PRDATA[30]}]
set_load -pin_load 0.003 [get_ports {PRDATA[29]}]
set_load -pin_load 0.003 [get_ports {PRDATA[28]}]
set_load -pin_load 0.003 [get_ports {PRDATA[27]}]
set_load -pin_load 0.003 [get_ports {PRDATA[26]}]
set_load -pin_load 0.003 [get_ports {PRDATA[25]}]
set_load -pin_load 0.003 [get_ports {PRDATA[24]}]
set_load -pin_load 0.003 [get_ports {PRDATA[23]}]
set_load -pin_load 0.003 [get_ports {PRDATA[22]}]
set_load -pin_load 0.003 [get_ports {PRDATA[21]}]
set_load -pin_load 0.003 [get_ports {PRDATA[20]}]
set_load -pin_load 0.003 [get_ports {PRDATA[19]}]
set_load -pin_load 0.003 [get_ports {PRDATA[18]}]
set_load -pin_load 0.003 [get_ports {PRDATA[17]}]
set_load -pin_load 0.003 [get_ports {PRDATA[16]}]
set_load -pin_load 0.003 [get_ports {PRDATA[15]}]
set_load -pin_load 0.003 [get_ports {PRDATA[14]}]
set_load -pin_load 0.003 [get_ports {PRDATA[13]}]
set_load -pin_load 0.003 [get_ports {PRDATA[12]}]
set_load -pin_load 0.003 [get_ports {PRDATA[11]}]
set_load -pin_load 0.003 [get_ports {PRDATA[10]}]
set_load -pin_load 0.003 [get_ports {PRDATA[9]}]
set_load -pin_load 0.003 [get_ports {PRDATA[8]}]
set_load -pin_load 0.003 [get_ports {PRDATA[7]}]
set_load -pin_load 0.003 [get_ports {PRDATA[6]}]
set_load -pin_load 0.003 [get_ports {PRDATA[5]}]
set_load -pin_load 0.003 [get_ports {PRDATA[4]}]
set_load -pin_load 0.003 [get_ports {PRDATA[3]}]
set_load -pin_load 0.003 [get_ports {PRDATA[2]}]
set_load -pin_load 0.003 [get_ports {PRDATA[1]}]
set_load -pin_load 0.003 [get_ports {PRDATA[0]}]
set_load -pin_load 0.003 [get_ports PREADY]
set_load -pin_load 0.003 [get_ports PSLVERR]
set_load -pin_load 0.003 [get_ports uart_sout]
set_load -pin_load 0.003 [get_ports uart_rts_n]
set_load -pin_load 0.003 [get_ports uart_dtr_n]
set_load -pin_load 0.003 [get_ports uart_out1_n]
set_load -pin_load 0.003 [get_ports uart_out2_n]
set_load -pin_load 0.003 [get_ports uart_int]
set_load -pin_load 0.003 [get_ports tx_int]
set_load -pin_load 0.003 [get_ports rx_int]
set_load -pin_load 0.003 [get_ports rxovr_int]
set_load -pin_load 0.003 [get_ports txovr_int]
set_load -pin_load 0.003 [get_ports dma_tx_req]
set_load -pin_load 0.003 [get_ports dma_tx_single]
set_load -pin_load 0.003 [get_ports dma_rx_req]
set_load -pin_load 0.003 [get_ports dma_rx_single]
set_false_path -from [list \
  [get_ports RSTN]  \
  [get_ports uart_sin] ]
group_path -name INPUTS -from [list \
  [get_ports RSTN]  \
  [get_ports {PADDR[11]}]  \
  [get_ports {PADDR[10]}]  \
  [get_ports {PADDR[9]}]  \
  [get_ports {PADDR[8]}]  \
  [get_ports {PADDR[7]}]  \
  [get_ports {PADDR[6]}]  \
  [get_ports {PADDR[5]}]  \
  [get_ports {PADDR[4]}]  \
  [get_ports {PADDR[3]}]  \
  [get_ports {PADDR[2]}]  \
  [get_ports {PADDR[1]}]  \
  [get_ports {PADDR[0]}]  \
  [get_ports {PWDATA[31]}]  \
  [get_ports {PWDATA[30]}]  \
  [get_ports {PWDATA[29]}]  \
  [get_ports {PWDATA[28]}]  \
  [get_ports {PWDATA[27]}]  \
  [get_ports {PWDATA[26]}]  \
  [get_ports {PWDATA[25]}]  \
  [get_ports {PWDATA[24]}]  \
  [get_ports {PWDATA[23]}]  \
  [get_ports {PWDATA[22]}]  \
  [get_ports {PWDATA[21]}]  \
  [get_ports {PWDATA[20]}]  \
  [get_ports {PWDATA[19]}]  \
  [get_ports {PWDATA[18]}]  \
  [get_ports {PWDATA[17]}]  \
  [get_ports {PWDATA[16]}]  \
  [get_ports {PWDATA[15]}]  \
  [get_ports {PWDATA[14]}]  \
  [get_ports {PWDATA[13]}]  \
  [get_ports {PWDATA[12]}]  \
  [get_ports {PWDATA[11]}]  \
  [get_ports {PWDATA[10]}]  \
  [get_ports {PWDATA[9]}]  \
  [get_ports {PWDATA[8]}]  \
  [get_ports {PWDATA[7]}]  \
  [get_ports {PWDATA[6]}]  \
  [get_ports {PWDATA[5]}]  \
  [get_ports {PWDATA[4]}]  \
  [get_ports {PWDATA[3]}]  \
  [get_ports {PWDATA[2]}]  \
  [get_ports {PWDATA[1]}]  \
  [get_ports {PWDATA[0]}]  \
  [get_ports PWRITE]  \
  [get_ports PSEL]  \
  [get_ports PENABLE]  \
  [get_ports uart_sin]  \
  [get_ports uart_cts_n]  \
  [get_ports uart_dsr_n]  \
  [get_ports uart_ri_n]  \
  [get_ports uart_dcd_n]  \
  [get_ports dma_tx_ack]  \
  [get_ports dma_rx_ack] ]
group_path -name OUTPUTS -to [list \
  [get_ports {PRDATA[31]}]  \
  [get_ports {PRDATA[30]}]  \
  [get_ports {PRDATA[29]}]  \
  [get_ports {PRDATA[28]}]  \
  [get_ports {PRDATA[27]}]  \
  [get_ports {PRDATA[26]}]  \
  [get_ports {PRDATA[25]}]  \
  [get_ports {PRDATA[24]}]  \
  [get_ports {PRDATA[23]}]  \
  [get_ports {PRDATA[22]}]  \
  [get_ports {PRDATA[21]}]  \
  [get_ports {PRDATA[20]}]  \
  [get_ports {PRDATA[19]}]  \
  [get_ports {PRDATA[18]}]  \
  [get_ports {PRDATA[17]}]  \
  [get_ports {PRDATA[16]}]  \
  [get_ports {PRDATA[15]}]  \
  [get_ports {PRDATA[14]}]  \
  [get_ports {PRDATA[13]}]  \
  [get_ports {PRDATA[12]}]  \
  [get_ports {PRDATA[11]}]  \
  [get_ports {PRDATA[10]}]  \
  [get_ports {PRDATA[9]}]  \
  [get_ports {PRDATA[8]}]  \
  [get_ports {PRDATA[7]}]  \
  [get_ports {PRDATA[6]}]  \
  [get_ports {PRDATA[5]}]  \
  [get_ports {PRDATA[4]}]  \
  [get_ports {PRDATA[3]}]  \
  [get_ports {PRDATA[2]}]  \
  [get_ports {PRDATA[1]}]  \
  [get_ports {PRDATA[0]}]  \
  [get_ports PREADY]  \
  [get_ports PSLVERR]  \
  [get_ports uart_sout]  \
  [get_ports uart_rts_n]  \
  [get_ports uart_dtr_n]  \
  [get_ports uart_out1_n]  \
  [get_ports uart_out2_n]  \
  [get_ports uart_int]  \
  [get_ports tx_int]  \
  [get_ports rx_int]  \
  [get_ports rxovr_int]  \
  [get_ports txovr_int]  \
  [get_ports dma_tx_req]  \
  [get_ports dma_tx_single]  \
  [get_ports dma_rx_req]  \
  [get_ports dma_rx_single] ]
group_path -name REG2REG -from [list \
  [get_cells u_uart_core/u_rx_fifo/elements_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx2x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx1x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx1x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx0x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx0x]  \
  [get_cells u_uart_core/DLL_q_regx0x]  \
  [get_cells u_uart_core/LCR_q_regx6x]  \
  [get_cells u_uart_core/IER_q_regx0x]  \
  [get_cells u_uart_core/MCR_q_regx4x]  \
  [get_cells u_uart_core/LCR_q_regx1x]  \
  [get_cells u_uart_core/LCR_q_regx2x]  \
  [get_cells u_uart_core/LCR_q_regx3x]  \
  [get_cells u_uart_core/MCR_q_regx0x]  \
  [get_cells u_uart_core/MCR_q_regx1x]  \
  [get_cells u_uart_core/MCR_q_regx2x]  \
  [get_cells u_uart_core/LCR_q_regx0x]  \
  [get_cells u_uart_core/MCR_q_regx3x]  \
  [get_cells u_uart_core/DLL_q_regx4x]  \
  [get_cells u_uart_core/IER_q_regx3x]  \
  [get_cells u_uart_core/DLL_q_regx7x]  \
  [get_cells u_uart_core/DLM_q_regx4x]  \
  [get_cells u_uart_core/DLM_q_regx2x]  \
  [get_cells u_uart_core/DLM_q_regx3x]  \
  [get_cells u_uart_core/DLM_q_regx5x]  \
  [get_cells u_uart_core/DLM_q_regx6x]  \
  [get_cells u_uart_core/DLM_q_regx7x]  \
  [get_cells u_uart_core/IER_q_regx1x]  \
  [get_cells u_uart_core/IER_q_regx2x]  \
  [get_cells u_uart_core/DLL_q_regx5x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx15x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx13x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx11x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx9x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx8x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx7x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx5x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx3x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx1x]  \
  [get_cells u_uart_core/lsr_pe_reg]  \
  [get_cells u_uart_core/rx_timeout_flag_reg]  \
  [get_cells u_uart_core/lsr_oe_reg]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx6x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx4x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx5x]  \
  [get_cells u_uart_core/u_uart_rx/bit_done_reg]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx7x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/reg_rx_sync_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx3x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx3x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx2x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx3x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx1x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx0x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx0x]  \
  [get_cells u_intf_block/dcts_r_reg]  \
  [get_cells u_intf_block/ddcd_r_reg]  \
  [get_cells u_intf_block/ddsr_r_reg]  \
  [get_cells u_intf_block/teri_r_reg]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx3x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx5x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx6x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx7x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx9x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx10x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx11x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx12x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx13x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx14x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx15x]  \
  [get_cells u_uart_core/u_uart_rx/err_o_reg]  \
  [get_cells u_uart_core/u_uart_rx/reg_bit_count_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_bit_count_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/reg_bit_count_regx2x]  \
  [get_cells u_dma/tx_req_r_reg]  \
  [get_cells u_dma/rx_single_r_reg]  \
  [get_cells u_dma/tx_single_r_reg]  \
  [get_cells u_dma/rx_req_r_reg]  \
  [get_cells u_uart_core/IER_q_regx4x]  \
  [get_cells u_uart_core/IER_q_regx5x]  \
  [get_cells u_uart_core/IER_q_regx6x]  \
  [get_cells u_uart_core/IER_q_regx7x]  \
  [get_cells u_uart_core/LCR_q_regx4x]  \
  [get_cells u_uart_core/LCR_q_regx5x]  \
  [get_cells u_uart_core/SCR_q_regx0x]  \
  [get_cells u_uart_core/SCR_q_regx1x]  \
  [get_cells u_uart_core/SCR_q_regx2x]  \
  [get_cells u_uart_core/SCR_q_regx3x]  \
  [get_cells u_uart_core/SCR_q_regx4x]  \
  [get_cells u_uart_core/SCR_q_regx5x]  \
  [get_cells u_uart_core/SCR_q_regx6x]  \
  [get_cells u_uart_core/SCR_q_regx7x]  \
  [get_cells u_intf_block/cts_prev_reg]  \
  [get_cells u_intf_block/dcd_prev_reg]  \
  [get_cells u_intf_block/dsr_prev_reg]  \
  [get_cells u_intf_block/ri_ff2_reg]  \
  [get_cells u_intf_block/dcd_ff2_reg]  \
  [get_cells u_intf_block/dsr_ff2_reg]  \
  [get_cells u_intf_block/cts_ff2_reg]  \
  [get_cells u_intf_block/cts_ff1_reg]  \
  [get_cells u_intf_block/ri_ff1_reg]  \
  [get_cells u_intf_block/dcd_ff1_reg]  \
  [get_cells u_intf_block/dsr_ff1_reg]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx7x]  \
  [get_cells u_uart_core/LCR_q_regx7x]  \
  [get_cells u_uart_core/u_uart_tx/CS_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/CS_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/CS_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx3x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx4x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx5x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx6x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx7x]  \
  [get_cells u_uart_core/u_uart_tx/reg_bit_count_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/reg_bit_count_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/reg_bit_count_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/reg_rx_sync_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_rx_sync_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/bit_done_reg]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx7x]  \
  [get_cells u_intf_block/ri_prev_reg]  \
  [get_cells u_uart_core/u_uart_tx/parity_bit_reg]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx11x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx9x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx8x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx13x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx10x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx15x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx14x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx12x]  \
  [get_cells u_uart_core/FCR_q_regx7x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx10x]  \
  [get_cells u_uart_core/DLL_q_regx1x]  \
  [get_cells u_uart_core/DLM_q_regx1x]  \
  [get_cells u_uart_core/DLL_q_regx2x]  \
  [get_cells u_uart_core/DLL_q_regx6x]  \
  [get_cells u_uart_core/DLL_q_regx3x]  \
  [get_cells u_uart_core/FCR_q_regx6x]  \
  [get_cells u_uart_core/DLM_q_regx0x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx6x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx2x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx4x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx14x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx12x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx1x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx2x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx1x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx0x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx2x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx4x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx1x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx2x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx0x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx3x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx4x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx5x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx6x]  \
  [get_cells u_uart_core/u_uart_rx/CS_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/CS_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/CS_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/parity_bit_reg]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx4x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx8x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx4x] ] -to [list \
  [get_cells u_uart_core/RC_CG_HIER_INST0/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST1/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST2/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST3/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST4/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST5/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST6/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_rx/RC_CG_HIER_INST26/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_tx/RC_CG_HIER_INST29/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_tx/RC_CG_HIER_INST30/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_tx/RC_CG_HIER_INST31/RC_CGIC_INST]  \
  [get_cells u_uart_core/RC_CG_HIER_INST32/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_rx/RC_CG_HIER_INST33/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_tx/RC_CG_HIER_INST34/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/RC_CGIC_INST]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx2x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx1x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx1x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx0x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx0x]  \
  [get_cells u_uart_core/DLL_q_regx0x]  \
  [get_cells u_uart_core/LCR_q_regx6x]  \
  [get_cells u_uart_core/IER_q_regx0x]  \
  [get_cells u_uart_core/MCR_q_regx4x]  \
  [get_cells u_uart_core/LCR_q_regx1x]  \
  [get_cells u_uart_core/LCR_q_regx2x]  \
  [get_cells u_uart_core/LCR_q_regx3x]  \
  [get_cells u_uart_core/MCR_q_regx0x]  \
  [get_cells u_uart_core/MCR_q_regx1x]  \
  [get_cells u_uart_core/MCR_q_regx2x]  \
  [get_cells u_uart_core/LCR_q_regx0x]  \
  [get_cells u_uart_core/MCR_q_regx3x]  \
  [get_cells u_uart_core/DLL_q_regx4x]  \
  [get_cells u_uart_core/IER_q_regx3x]  \
  [get_cells u_uart_core/DLL_q_regx7x]  \
  [get_cells u_uart_core/DLM_q_regx4x]  \
  [get_cells u_uart_core/DLM_q_regx2x]  \
  [get_cells u_uart_core/DLM_q_regx3x]  \
  [get_cells u_uart_core/DLM_q_regx5x]  \
  [get_cells u_uart_core/DLM_q_regx6x]  \
  [get_cells u_uart_core/DLM_q_regx7x]  \
  [get_cells u_uart_core/IER_q_regx1x]  \
  [get_cells u_uart_core/IER_q_regx2x]  \
  [get_cells u_uart_core/DLL_q_regx5x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx15x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx13x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx11x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx9x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx8x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx7x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx5x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx3x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx1x]  \
  [get_cells u_uart_core/lsr_pe_reg]  \
  [get_cells u_uart_core/rx_timeout_flag_reg]  \
  [get_cells u_uart_core/lsr_oe_reg]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx6x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx4x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx5x]  \
  [get_cells u_uart_core/u_uart_rx/bit_done_reg]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx7x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/reg_rx_sync_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_data_regx3x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx3x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx2x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx3x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx1x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx0x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx0x]  \
  [get_cells u_intf_block/dcts_r_reg]  \
  [get_cells u_intf_block/ddcd_r_reg]  \
  [get_cells u_intf_block/ddsr_r_reg]  \
  [get_cells u_intf_block/teri_r_reg]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx3x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx5x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx6x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx7x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx9x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx10x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx11x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx12x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx13x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx14x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx15x]  \
  [get_cells u_uart_core/u_uart_rx/err_o_reg]  \
  [get_cells u_uart_core/u_uart_rx/reg_bit_count_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_bit_count_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/reg_bit_count_regx2x]  \
  [get_cells u_dma/tx_req_r_reg]  \
  [get_cells u_dma/rx_single_r_reg]  \
  [get_cells u_dma/tx_single_r_reg]  \
  [get_cells u_dma/rx_req_r_reg]  \
  [get_cells u_uart_core/IER_q_regx4x]  \
  [get_cells u_uart_core/IER_q_regx5x]  \
  [get_cells u_uart_core/IER_q_regx6x]  \
  [get_cells u_uart_core/IER_q_regx7x]  \
  [get_cells u_uart_core/LCR_q_regx4x]  \
  [get_cells u_uart_core/LCR_q_regx5x]  \
  [get_cells u_uart_core/SCR_q_regx0x]  \
  [get_cells u_uart_core/SCR_q_regx1x]  \
  [get_cells u_uart_core/SCR_q_regx2x]  \
  [get_cells u_uart_core/SCR_q_regx3x]  \
  [get_cells u_uart_core/SCR_q_regx4x]  \
  [get_cells u_uart_core/SCR_q_regx5x]  \
  [get_cells u_uart_core/SCR_q_regx6x]  \
  [get_cells u_uart_core/SCR_q_regx7x]  \
  [get_cells u_intf_block/cts_prev_reg]  \
  [get_cells u_intf_block/dcd_prev_reg]  \
  [get_cells u_intf_block/dsr_prev_reg]  \
  [get_cells u_intf_block/ri_ff2_reg]  \
  [get_cells u_intf_block/dcd_ff2_reg]  \
  [get_cells u_intf_block/dsr_ff2_reg]  \
  [get_cells u_intf_block/cts_ff2_reg]  \
  [get_cells u_intf_block/cts_ff1_reg]  \
  [get_cells u_intf_block/ri_ff1_reg]  \
  [get_cells u_intf_block/dcd_ff1_reg]  \
  [get_cells u_intf_block/dsr_ff1_reg]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx0xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx1xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx2xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx3xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx4xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx5xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx6xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx7xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx8xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx9xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx10xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx11xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx12xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx13xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx14xx7x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx0x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx1x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx2x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx3x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx4x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx5x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx6x]  \
  [get_cells u_uart_core/u_rx_fifo/buffer_regx15xx7x]  \
  [get_cells u_uart_core/LCR_q_regx7x]  \
  [get_cells u_uart_core/u_uart_tx/CS_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/CS_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/CS_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx3x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx4x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx5x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx6x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx7x]  \
  [get_cells u_uart_core/u_uart_tx/reg_bit_count_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/reg_bit_count_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/reg_bit_count_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/reg_rx_sync_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/reg_rx_sync_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/bit_done_reg]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx0x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx0xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx1xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx2xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx3xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx4xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx5xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx6xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx7xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx8xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx9xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx10xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx11xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx12xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx13xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx14xx7x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx0x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx1x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx2x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx3x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx4x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx5x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx6x]  \
  [get_cells u_uart_core/u_tx_fifo/buffer_regx15xx7x]  \
  [get_cells u_intf_block/ri_prev_reg]  \
  [get_cells u_uart_core/u_uart_tx/parity_bit_reg]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx11x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx9x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx8x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx13x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx10x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx15x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx14x]  \
  [get_cells u_uart_core/u_uart_tx/baud_cnt_regx12x]  \
  [get_cells u_uart_core/FCR_q_regx7x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx10x]  \
  [get_cells u_uart_core/DLL_q_regx1x]  \
  [get_cells u_uart_core/DLM_q_regx1x]  \
  [get_cells u_uart_core/DLL_q_regx2x]  \
  [get_cells u_uart_core/DLL_q_regx6x]  \
  [get_cells u_uart_core/DLL_q_regx3x]  \
  [get_cells u_uart_core/FCR_q_regx6x]  \
  [get_cells u_uart_core/DLM_q_regx0x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx6x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx2x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx4x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx14x]  \
  [get_cells u_uart_core/rx_timeout_cnt_regx12x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx1x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx2x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx1x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_out_regx0x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx2x]  \
  [get_cells u_uart_core/u_tx_fifo/pointer_in_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/elements_regx4x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx3x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx1x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx2x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_out_regx0x]  \
  [get_cells u_uart_core/u_rx_fifo/pointer_in_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx1x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx2x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx3x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx4x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx5x]  \
  [get_cells u_uart_core/u_uart_tx/reg_data_regx6x]  \
  [get_cells u_uart_core/u_uart_rx/CS_regx0x]  \
  [get_cells u_uart_core/u_uart_rx/CS_regx2x]  \
  [get_cells u_uart_core/u_uart_rx/CS_regx1x]  \
  [get_cells u_uart_core/u_uart_rx/parity_bit_reg]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx4x]  \
  [get_cells u_uart_core/u_uart_rx/baud_cnt_regx8x]  \
  [get_cells u_uart_core/u_tx_fifo/elements_regx4x] ]
group_path -name cg_enable_group_CLK -through [list \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST0/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST1/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST2/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST3/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST4/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST5/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST6/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/enable]  \
  [get_pins u_uart_core/RC_CG_HIER_INST32/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_rx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST7/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST8/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST9/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST10/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST11/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST12/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST13/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST14/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST15/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST16/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST17/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST18/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST19/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST20/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST21/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST22/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST23/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST24/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/enable]  \
  [get_pins u_uart_core/u_tx_fifo/RC_CG_HIER_INST25/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_DECLONE_HIER_INST/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST26/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/enable]  \
  [get_pins u_uart_core/u_uart_rx/RC_CG_HIER_INST33/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST29/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST30/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST31/RC_CGIC_INST/E]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/enable]  \
  [get_pins u_uart_core/u_uart_tx/RC_CG_HIER_INST34/RC_CGIC_INST/E] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[11]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[10]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[9]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[8]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[7]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[6]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[5]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[4]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PADDR[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[31]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[30]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[29]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[28]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[27]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[26]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[25]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[24]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[23]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[22]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[21]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[20]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[19]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[18]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[17]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[16]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[15]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[14]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[13]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[12]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[11]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[10]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[9]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[8]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[7]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[6]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[5]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[4]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PWDATA[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports PWRITE]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports PSEL]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports PENABLE]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_cts_n]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_dsr_n]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_ri_n]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_dcd_n]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports dma_tx_ack]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports dma_rx_ack]
set_input_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_sin]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[31]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[30]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[29]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[28]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[27]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[26]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[25]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[24]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[23]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[22]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[21]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[20]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[19]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[18]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[17]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[16]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[15]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[14]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[13]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[12]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[11]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[10]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[9]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[8]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[7]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[6]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[5]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[4]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports {PRDATA[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports PREADY]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports PSLVERR]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_sout]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_rts_n]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_dtr_n]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_out1_n]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_out2_n]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports uart_int]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports tx_int]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports rx_int]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports rxovr_int]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports txovr_int]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports dma_tx_req]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports dma_tx_single]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports dma_rx_req]
set_output_delay -clock [get_clocks CLK] -add_delay 0.4 [get_ports dma_rx_single]
set_max_fanout 20.000 [current_design]
set_max_transition 0.3 [current_design]
set_input_transition 0.01 [get_ports RSTN]
set_input_transition 0.01 [get_ports {PADDR[11]}]
set_input_transition 0.01 [get_ports {PADDR[10]}]
set_input_transition 0.01 [get_ports {PADDR[9]}]
set_input_transition 0.01 [get_ports {PADDR[8]}]
set_input_transition 0.01 [get_ports {PADDR[7]}]
set_input_transition 0.01 [get_ports {PADDR[6]}]
set_input_transition 0.01 [get_ports {PADDR[5]}]
set_input_transition 0.01 [get_ports {PADDR[4]}]
set_input_transition 0.01 [get_ports {PADDR[3]}]
set_input_transition 0.01 [get_ports {PADDR[2]}]
set_input_transition 0.01 [get_ports {PADDR[1]}]
set_input_transition 0.01 [get_ports {PADDR[0]}]
set_input_transition 0.01 [get_ports {PWDATA[31]}]
set_input_transition 0.01 [get_ports {PWDATA[30]}]
set_input_transition 0.01 [get_ports {PWDATA[29]}]
set_input_transition 0.01 [get_ports {PWDATA[28]}]
set_input_transition 0.01 [get_ports {PWDATA[27]}]
set_input_transition 0.01 [get_ports {PWDATA[26]}]
set_input_transition 0.01 [get_ports {PWDATA[25]}]
set_input_transition 0.01 [get_ports {PWDATA[24]}]
set_input_transition 0.01 [get_ports {PWDATA[23]}]
set_input_transition 0.01 [get_ports {PWDATA[22]}]
set_input_transition 0.01 [get_ports {PWDATA[21]}]
set_input_transition 0.01 [get_ports {PWDATA[20]}]
set_input_transition 0.01 [get_ports {PWDATA[19]}]
set_input_transition 0.01 [get_ports {PWDATA[18]}]
set_input_transition 0.01 [get_ports {PWDATA[17]}]
set_input_transition 0.01 [get_ports {PWDATA[16]}]
set_input_transition 0.01 [get_ports {PWDATA[15]}]
set_input_transition 0.01 [get_ports {PWDATA[14]}]
set_input_transition 0.01 [get_ports {PWDATA[13]}]
set_input_transition 0.01 [get_ports {PWDATA[12]}]
set_input_transition 0.01 [get_ports {PWDATA[11]}]
set_input_transition 0.01 [get_ports {PWDATA[10]}]
set_input_transition 0.01 [get_ports {PWDATA[9]}]
set_input_transition 0.01 [get_ports {PWDATA[8]}]
set_input_transition 0.01 [get_ports {PWDATA[7]}]
set_input_transition 0.01 [get_ports {PWDATA[6]}]
set_input_transition 0.01 [get_ports {PWDATA[5]}]
set_input_transition 0.01 [get_ports {PWDATA[4]}]
set_input_transition 0.01 [get_ports {PWDATA[3]}]
set_input_transition 0.01 [get_ports {PWDATA[2]}]
set_input_transition 0.01 [get_ports {PWDATA[1]}]
set_input_transition 0.01 [get_ports {PWDATA[0]}]
set_input_transition 0.01 [get_ports PWRITE]
set_input_transition 0.01 [get_ports PSEL]
set_input_transition 0.01 [get_ports PENABLE]
set_input_transition 0.01 [get_ports uart_sin]
set_input_transition 0.01 [get_ports uart_cts_n]
set_input_transition 0.01 [get_ports uart_dsr_n]
set_input_transition 0.01 [get_ports uart_ri_n]
set_input_transition 0.01 [get_ports uart_dcd_n]
set_input_transition 0.01 [get_ports dma_tx_ack]
set_input_transition 0.01 [get_ports dma_rx_ack]
set_clock_uncertainty -setup 0.2 [get_clocks CLK]
set_clock_uncertainty -hold 0.2 [get_clocks CLK]
