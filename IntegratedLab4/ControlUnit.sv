module ControlUnit (
    input  logic [6:0] opcode,
    input  logic       eq,
    output logic       reg_write,
    output logic       alu_src,
    output logic       pc_src,
    output logic [2:0] alu_control
);
    always_comb begin
        // Default values
        reg_write = 0;
        alu_src = 0;
        pc_src = 0;
        alu_control = 3'b000;

        case (opcode)
            7'b0010011: begin // ADDI
                reg_write = 1;
                alu_src = 1;
                alu_control = 3'b000; // ALU ADD
            end
            7'b1100011: begin // BNE
                pc_src = ~eq; // Jump if not equal
                alu_control = 3'b001; // ALU SUB
            end
            default: begin
                // 测试用，error handling
            end
        endcase
    end
endmodule
