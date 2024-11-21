module ALUTOP (
    input logic clk,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic RegWrite,
    input logic ALUsrc,
    input logic [2:0] ALUctrl,
    input logic [31:0] ImmOp,
    output logic EQ,
    output logic [31:0] a0
);

    logic [31:0] ALUop1;
    logic [31:0] ALUop2;
    logic [31:0] regOp2;
    logic [31:0] ALUout;

RegFile RegFile (
    .clk(clk),
    .AD1(rs1),
    .AD2(rs2),
    .AD3(rd),
    .WD3(ALUout),
    .WE3(RegWrite),
    .a0(a0),
    .RD1(ALUop1),
    .RD2(regOp2)
);

ALUMux ALUMux (
    .regOp2(regOp2),
    .ImmOp(ImmOp),
    .ALUsrc(ALUsrc),
    .Aluop2(ALUop2)
);

ALUBlock ALUBlock (
    .ALUop1(ALUop1),
    .ALUop2(ALUop2),
    .ALUctrl(ALUctrl),
    .SUM(ALUout),
    .EQ(EQ)
);

endmodule

