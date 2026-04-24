# 1. Clock Definition (500MHz)
create_clock -name clk -period 1.7 [get_ports clk_pin]
set_clock_latency 1.0 [get_clocks clk]

# 2. IO Delays (Left Input -> Right Output flow)
set_input_delay  -clock clk 1.0 [remove_from_collection [all_inputs] [get_ports clk_pin]]
set_output_delay -clock clk 1.0 [all_outputs]

# 3. Multicycle Paths - SETUP (Matching FSM)
# 2-cycle ops
set_multicycle_path 4 -through U_CORE/DP/ALU/sub_*/Z*
set_multicycle_path 2 -through U_CORE/DP/ALU/srl_*/Z*
set_multicycle_path 2 -through U_CORE/DP/ALU/sll_*/Z*
# 5-cycle ops
set_multicycle_path 5 -through U_CORE/DP/ALU/mul_*/Z*
set_multicycle_path 5 -through U_CORE/DP/ALU/div_*/QUOTIENT*

# 4. Multicycle Paths - HOLD (Setup Value - 1)
# For 2-cycle setup -> hold 1
set_multicycle_path 3 -through U_CORE/DP/ALU/sub_*/Z* -hold
set_multicycle_path 1 -through U_CORE/DP/ALU/srl_*/Z* -hold
set_multicycle_path 1 -through U_CORE/DP/ALU/sll_*/Z* -hold
# For 5-cycle setup -> hold 4
set_multicycle_path 4 -through U_CORE/DP/ALU/mul_*/Z* -hold
set_multicycle_path 4 -through U_CORE/DP/ALU/div_*/QUOTIENT* -hold

set_clock_latency 1.0 [get_clocks clk]
set_clock_uncertainty -setup 0.10 [get_clocks clk]
set_clock_uncertainty -hold  0.05 [get_clocks clk]
set_max_fanout 20 [current_design]
set_max_capacitance 0.1 [get_ports*]
set_max_transition 0.1 [get_ports*]
