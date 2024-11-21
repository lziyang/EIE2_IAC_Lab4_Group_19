module SignExtender (
    input  logic [31:0] instruction,
    output logic [31:0] imm32
);
    logic signed [31:0] signedImm32;

    always_comb begin
        case (instruction[6:0])
            7'b1100011: begin  // BNE

                signedImm32 = $signed({instruction[31], instruction[7], instruction[30:25], instruction[11:8]});
                signedImm32 = signedImm32 << 1;
                imm32 = signedImm32;
            end

            7'b0010011: begin  // ADDI

                signedImm32 = $signed(instruction[31:20]);  // 符号扩展
                imm32 = signedImm32;
            end

            default: begin
                // default output = 0
                imm32 = 32'b0;
            end
        endcase
    end
endmodule
