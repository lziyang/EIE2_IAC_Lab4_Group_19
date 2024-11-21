module INSTRTOP (
    input logic [31:0] pc,
    input logic eq,
    output logic [31:0] instr,
    output logic        regwrite,
    output logic        alusrc,
    output logic        pcsrc,
    output logic [2:0]  aluctrl,
    output logic [31:0] immop

);

    logic [6:0] opcode;
    
    CUSE cuse(
        .eq (eq),
        .opcode (opcode),
        .instr (instr),
        .reg_write (regwrite),
        .alu_src (alusrc),
        .pc_src (pcsrc),
        .alu_control (aluctrl),
        .imm32 (immop)
    );

    InstrMemory instrmemory(
        .pc (pc),
        .instruction (instr)
    );
    
    assign opcode = instr[6:0];
    
endmodule
