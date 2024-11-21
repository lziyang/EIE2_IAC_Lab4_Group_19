module FULLCPUTOP (
    input  logic       clk,     // Clock input
    input  logic       rst,     // Reset input
    output logic [31:0] a0      // Output from ALU
);

    // Interconnections
    logic [31:0] pc;            // Program counter
    logic [31:0] instr;   // instr from instr memory
    logic [6:0]  opcode;        // Opcode extracted from instr
    logic [4:0]  rs1, rs2, rd;  // Register indices
    logic        regwrite;     // Register write signal
    logic        alusrc;       // ALU source select signal
    logic        pcsrc;        // Program counter source signal
    logic [2:0]  aluctrl;   // ALU control signal
    logic [31:0] immop;         // Sign-extended immediate value
    logic        eq;            // ALU equality output

    // Split instr fields
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign rs1    = instr[19:15];
    assign rs2 = instr [24:20];

    // Instantiate PC module
    PCTOP #(.WIDTH(32)) pc_top (
        .clk(clk),
        .rst(rst),
        .PCsrc(pcsrc),
        .ImmOp(immop),
        .PC(pc)
    );

    // Instantiate instr Decode and Control Unit
    INSTRTOP instr_top (
        .pc(pc),
        .eq(eq),
        .regwrite(regwrite),
        .alusrc(alusrc),
        .pcsrc(pcsrc),
        .aluctrl(aluctrl),
        .immop(immop),
        .instr(instr)
    );

    // Instantiate ALU module
    ALUTOP alu_top (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .RegWrite(regwrite),
        .ALUsrc(alusrc),
        .ALUctrl(aluctrl),
        .ImmOp(immop),
        .EQ(eq),
        .a0(a0)
    );

endmodule
