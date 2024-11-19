module ALU (
    input  logic [31:0] op1,
    input  logic [31:0] op2,
    input  logic [2:0]  control,
    output logic [31:0] result,
    output logic        zero
);
    always_comb begin
        case (control)
            3'b000: result = op1 + op2;    // ADD
            3'b001: result = op1 - op2;    // SUB

            default: result = 32'b0;
        endcase
        zero = (result == 32'b0); // flag for set_0
    end
endmodule
