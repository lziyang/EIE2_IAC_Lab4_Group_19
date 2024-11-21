module ALUMux (
    input logic [31:0] regOp2,
    input logic [31:0] ImmOp,
    input logic ALUsrc,
    output logic [31:0] Aluop2
);

always_comb begin
        if (ALUsrc) 
            Aluop2=ImmOp;
        else 
            Aluop2=regOp2;
    end

endmodule
