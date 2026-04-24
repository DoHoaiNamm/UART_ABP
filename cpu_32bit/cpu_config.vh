// Global defines

`ifndef __cpu_config_vh__
`define __cpu_config_vh__

// ======================================================================
// - UPSKILL = 1 -> HARD MACRO
// - UPSKILL = 0 -> SYNTHESIZABLE MEMORY
// if use `define UPSKILL 0/1 then hard macro will be used
// ======================================================================

// clock period
`define clk_period 2.0
`define clk_period_80pct 1.6

// Bit widths
`define addr_width 7
`define opcode_width 4
`define data_width 32
`define fsm_pst_width 4
`define ram_depth 128

// CPU opcodes
`define opc_not     0 // ~ACC            <-- 1 cycle ops
`define opc_and     1 // ACC & MEM[addr]
`define opc_or      2 // ACC | MEM[addr]
`define opc_xor     3 // ACC ^ MEM[addr]
//
`define opc_add     4 // ACC + MEM[addr] <-- 2 cycle ops
`define opc_sub     5 // ACC - MEM[addr]
`define opc_lshift  6 // ACC << MEM[addr]
`define opc_rshift  7 // ACC >> MEM[addr]
//
`define opc_mult    8 // ACC * MEM[addr] <-- 3 cycle ops
`define opc_div     9 // ACC / MEM[addr]
//
`define opc_load   10 // ACC = MEM[addr]
`define opc_store  11 // MEM[addr] = ACC
`define opc_jump   12 // PC = addr
`define opc_jumpz  13 // if (zero)   PC = addr
`define opc_jumpo  14 // if (overfl) PC = addr
`define opc_noop   15 // no_op

// FSM states
`define init        `fsm_pst_width'd0  // wait here for start signal
`define fet_cycle1  `fsm_pst_width'd1  // load PC to MAR and load IR addr to PC
`define fet_cycle2  `fsm_pst_width'd2  // load MDR (read memory)
`define fet_cycle3  `fsm_pst_width'd3  // load IR (from MDR)
`define decode      `fsm_pst_width'd4  // load IR addr to MAR, decode opcode
`define load_mdr    `fsm_pst_width'd5  // load MDR (read memory)
`define alu_cycle3  `fsm_pst_width'd6  // 3-cycle op
`define alu_cycle2  `fsm_pst_width'd7  // 2-cycle op
`define alu_cycle1  `fsm_pst_width'd8  // load ACC 
`define load_acc    `fsm_pst_width'd9  // load ACC from MDR
`define str_cycle1  `fsm_pst_width'd10 // save ACC to memory
`define str_cycle2  `fsm_pst_width'd11 // save ACC to memory
`define exec_jump   `fsm_pst_width'd12 // load IR address to PC
`define alu_cycle5  `fsm_pst_width'd13  // 5-cycle op
`define alu_cycle4  `fsm_pst_width'd14 // 4-cycle op
`define error       `fsm_pst_width'd15 // terminal state (stay here till reset)

`endif // __cpu_config_vh__
