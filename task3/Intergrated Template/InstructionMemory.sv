module InstructionMemory(
    input logic [31:0] pc,
    output logic [31:0] instruction
);
    logic [31:0] program_memory [0:255];

    // Initialize memory
    initial begin
        $readmemh("program.hex", program_memory); // Load instructions from program.hex
    end

    assign instruction = program_memory[pc[9:2]]; // Use PC[9:2] as index
endmodule
