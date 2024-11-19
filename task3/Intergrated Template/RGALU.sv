module RGALU(
    input logic clk,
    input logic reg_write,
    input logic [4:0] read_addr1,
    input logic [4:0] read_addr2,
    input logic [4:0] write_addr,
    input logic [31:0] write_data,
    input logic [2:0] alu_control,
    input logic alu_src,
    input logic [31:0] imm32,
    output logic [31:0] alu_result,
    output logic zero_flag,
    output logic [31:0] reg_a0 
);
    logic [31:0] read_data1, read_data2;
    logic [31:0] op2;

    // Multiplexer for op2
    assign op2 = alu_src ? imm32 : read_data2;

    // Inst. Register File
    RegisterFile reg_file (
        .clk(clk),
        .reg_write(reg_write),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Inst. ALU
    ALU alu (
        .op1(read_data1), // Always use read_data1
        .op2(op2),        // select op2
        .control(alu_control),
        .result(alu_result),
        .zero(zero_flag)
    );

    // Output register a0 (reg[10])
    assign reg_a0 = reg_file.registers[10];
endmodule
