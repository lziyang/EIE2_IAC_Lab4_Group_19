module ALUBlock (
    input logic [31:0] ALUop1,
    input logic [31:0] ALUop2,
    input logic [2:0] ALUctrl,
    output logic [31:0] SUM,
    output logic EQ
);

    always_comb begin
        case (ALUctrl)
            3'b000: SUM = ALUop1 + ALUop2;         
            3'b001: SUM = ALUop1 - ALUop2;             
            3'b010: SUM = ALUop1 & ALUop2;         
            3'b011: SUM = ALUop1 | ALUop2;            
            3'b101: SUM = (ALUop1 < ALUop2) ? 32'b1 : 32'b0; 
            default: SUM = 32'b0;                     
        endcase
    end

    assign EQ = (SUM == 0);

endmodule
