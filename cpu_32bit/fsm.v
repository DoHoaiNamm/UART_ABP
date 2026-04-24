`include "../cpu_32bit/cpu_config.vh"

module cpu_32bit__fsm (
        clk, rst, start, opcode,
        zero, ovrfl,
        pc_mux_sel, acc_mux_sel, mar_mux_sel,
        pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en,
        from_fsm_shutoff_mem, from_fsm_shutoff_alu,
        zero_ovrfl_en, mem_we, done, err
    );

    input  clk, rst, start;
    input  zero, ovrfl; // ALU: zero, overflow
    input  [`opcode_width-1:0] opcode;

    output pc_mux_sel, acc_mux_sel, mar_mux_sel; // mux selects
    output pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en;
    output from_fsm_shutoff_mem, from_fsm_shutoff_alu;
    output zero_ovrfl_en;
           // load enables
    output mem_we;
    output done, err;

    // fsm register & states (see cpu_config.vh)
    /*
        init              =  0, // wait here for start signal
        //
        fet_cycle1      =  1, // load PC to MAR and load IR addr to PC
        fet_cycle2      =  2, // load MDR (read memory)
        fet_cycle3      =  3, // load IR (from MDR)
        //
        decode          =  4, // load IR addr to MAR, decode opcode
        load_mdr        =  5, // load MDR (read memory)
        //
        alu_cycle3      =  6, // 3-cycle op
        alu_cycle2      =  7, // 2-cycle op
        alu_cycle1      =  8, // load ACC 
        load_acc        =  9, // load ACC from MDR
        str_cycle1      = 10, // save ACC to memory
        str_cycle2      = 11, // save ACC to memory
        exec_jump       = 12, // load IR address to PC
        //
        error           = 15; // terminal state (stay here till reset)
    */
    reg [`fsm_pst_width-1:0] pst, nst; // pst = state reg, nst = next_state

    // some functions
    function automatic is_1cycle_op;
        input [`opcode_width-1:0] opc;
        is_1cycle_op = (~opc[3] & ~opc[2]) ? 1'b1 : 1'b0;
    endfunction
    function automatic is_2cycle_op;
        input [`opcode_width-1:0] opc;
        is_2cycle_op = (~opc[3] & opc[2]) ? 1'b1 : 1'b0;
    endfunction
    function automatic is_3cycle_op;
        input [`opcode_width-1:0] opc;
        is_3cycle_op = (opc[3] & ~opc[2] & ~opc[1]) ? 1'b1 : 1'b0;
    endfunction

    // state register
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
            pst = `init;
        else
            pst = nst;
    end

    // next_state logic
    always @ (pst or start or opcode or zero or ovrfl)
    begin
        nst = pst;
        case (pst)
            `init: if (start) nst = `fet_cycle1;

            `fet_cycle1: nst = `fet_cycle2;
            `fet_cycle2: nst = `fet_cycle3;
            `fet_cycle3: nst = `decode;

            `decode:
                case (opcode)
                    `opc_not   : nst = `load_mdr; // though mdr will be ignored
                    `opc_and   : nst = `load_mdr;
                    `opc_or    : nst = `load_mdr;
                    `opc_xor   : nst = `load_mdr;
                    `opc_add   : nst = `load_mdr;
                    `opc_sub   : nst = `load_mdr;
                    `opc_lshift: nst = `load_mdr;
                    `opc_rshift: nst = `load_mdr;
                    `opc_mult  : nst = `load_mdr;
                    `opc_div   : nst = `load_mdr;
                    `opc_load  : nst = `load_mdr;
                    `opc_store : nst = `str_cycle1;
                    `opc_jump  : nst = `exec_jump;
                    `opc_jumpz : nst = zero  ? `exec_jump : `fet_cycle1;
                    `opc_jumpo : nst = ovrfl ? `exec_jump : `fet_cycle1;
                    `opc_noop  : nst = `init;
                    default    : nst = `error;
                endcase
            `load_mdr :
                if (opcode == `opc_load)
                    nst = `load_acc;
                else if (is_3cycle_op(opcode))
                    nst = `alu_cycle5;
                else if (is_2cycle_op(opcode))
                    nst = `alu_cycle2;
                else
                    nst = `alu_cycle1;
                // how about? nst = error;

            `alu_cycle5: nst = `alu_cycle4;
            `alu_cycle4: nst = `alu_cycle3;
            `alu_cycle3: nst = `alu_cycle2;
            `alu_cycle2: nst = `alu_cycle1;
            `alu_cycle1: nst = `fet_cycle1;

            `load_acc: nst = `fet_cycle1;

            `str_cycle1: nst = `str_cycle2;
            `str_cycle2: nst = `fet_cycle1;
            `exec_jump   : nst = `fet_cycle1;

            `error  : nst = `error;
            default : nst = `fet_cycle1;
        endcase
    end

    // moore outputs
    reg mem_we, done, err;
    reg pc_mux_sel, acc_mux_sel, mar_mux_sel;
    reg pc_load_en, acc_load_en, mar_load_en, mdr_load_en, ir_load_en, zero_ovrfl_en;
    reg from_fsm_shutoff_mem, from_fsm_shutoff_alu;

    always @ (pst)
    begin
        pc_mux_sel = 1'b0; mar_mux_sel = 1'b0; acc_mux_sel = 1'b0;
        pc_load_en = 1'b0; mar_load_en = 1'b0; acc_load_en = 1'b0;
        ir_load_en = 1'b0; mdr_load_en = 1'b0; zero_ovrfl_en = 1'b0;
        mem_we = 1'b0;     done = 1'b0;        err = 1'b0;

        from_fsm_shutoff_mem = 1'b0; from_fsm_shutoff_alu = 1'b0;

        case (pst)
            `init : done = 1'b1;

            `fet_cycle1 : begin
                pc_load_en  = 1'b1;
                mar_load_en = 1'b1;
            end
            `fet_cycle2 :
                mdr_load_en = 1'b1;
            `fet_cycle3 :
                ir_load_en = 1'b1;

            `decode: begin
                mar_mux_sel = 1'b1;
                mar_load_en = 1'b1;
            end
            `load_mdr:
                mdr_load_en = 1'b1;

            `alu_cycle5: ; // do nothing
            `alu_cycle4: ; // do nothing
            `alu_cycle3: ; // do nothing
            `alu_cycle2: ; // do nothing
            `alu_cycle1: begin
                acc_mux_sel = 1'b1;
                acc_load_en = 1'b1;
                zero_ovrfl_en = 1'b1;
             end

            `load_acc: begin
                // acc_mux_sel = 1'b1;
                acc_load_en = 1'b1;
             end

            `str_cycle1: begin
                // mar_mux_sel = 1'b1;
                // mar_load_en = 1'b1;
                mem_we = 1'b1;
            end
            `str_cycle2: ; // do nothing mem_we = 1'b1;

            `exec_jump: begin
                pc_mux_sel = 1'b1;
                pc_load_en = 1'b1;
            end

            `error: err = 1'b1;

        endcase
    end

endmodule

