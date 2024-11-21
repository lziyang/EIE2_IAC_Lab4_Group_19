module CUSE (
    input logic eq,
    input  logic [6:0]  opcode,
    input  logic [31:0] instr,
    output logic        reg_write,
    output logic        alu_src,
    output logic        pc_src,
    output logic [2:0]  alu_control,
    output logic [31:0] imm32
);
    // Instantiate Control Unit
    ControlUnit control_unit (
        .opcode      (opcode),
        .reg_write   (reg_write),
        .alu_src     (alu_src),
        .pc_src      (pc_src),
        .alu_control (alu_control),
        .eq (eq)
    );

    // Instantiate Sign-extension Unit
    SignExtender sign_extender (
        .instruction (instr),
        .imm32 (imm32)
    );

endmodule
