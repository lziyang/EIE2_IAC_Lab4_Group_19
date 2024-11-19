// CUSE.sv
module CUSE (
    input  logic [6:0]  opcode,
    input  logic [11:0] imm12,
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
        .alu_control (alu_control)
    );

    // Instantiate Sign-extension Unit
    SignExtender sign_extender (
        .imm12 (imm12),
        .imm32 (imm32)
    );
endmodule
