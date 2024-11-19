module TopCPU(
    input logic clk,
    input logic rst,
    output logic [31:0] a0
);
    // Internal signals
    logic [31:0] pc, branch_target, instruction;
    logic [31:0] imm32, write_data, alu_result;
    logic reg_write, alu_src, pc_src, zero_flag;
    logic [2:0] alu_control;

    // PC Module
    PCModule pc_module (
        .clk(clk),
        .rst(rst),
        .branch_target(branch_target),
        .pc_src(pc_src),
        .pc(pc)
    );

    // Instruction Memory
    InstructionMemory instruction_memory (
        .pc(pc),
        .instruction(instruction)
    );

    // Control Unit
    ControlUnit control_unit (
        .opcode(instruction[6:0]),
        .zero_flag(zero_flag),     // Connect zero_flag
        .reg_write(reg_write),
        .alu_src(alu_src),         // alu_src signal
        .pc_src(pc_src),
        .alu_control(alu_control)
    );

    // SignExtender
    SignExtender sign_extender (
        .instruction(instruction), // From full instruction to get imm
        .imm32(imm32)              // Extended immediate output
    );

    // RGALU
    RGALU reg_alu (
        .clk(clk),
        .reg_write(reg_write),
        .read_addr1(instruction[19:15]),  // rs1
        .read_addr2(instruction[24:20]),  // rs2
        .write_addr(instruction[11:7]),   // rd
        .write_data(write_data),          // Data to write back
        .alu_control(alu_control),
        .alu_src(alu_src),                // Pass alu_src to RGALU
        .imm32(imm32),                    // Pass imm32 to RGALU
        .alu_result(alu_result),
        .zero_flag(zero_flag),
        .reg_a0(a0)                       // Output register a0 (x10)
    );

    // Write data for register file
    assign write_data = alu_result;

    // Branch target calculation
    assign branch_target = pc + (imm32);

endmodule
