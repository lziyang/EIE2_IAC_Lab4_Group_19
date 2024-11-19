module SignExtender (
    input  logic [11:0] imm12,
    output logic [31:0] imm32
);
    assign imm32 = {{20{imm12[11]}}, imm12}; // use highest bit of imm12 to fill up to 32 bits
endmodule
