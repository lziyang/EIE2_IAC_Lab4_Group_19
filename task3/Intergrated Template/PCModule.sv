module PCModule(
    input logic clk,
    input logic rst,
    input logic[31:0] branch_target,
    input logic pc_src,
    output logic[31:0] pc
);
    logic[31:0] next_pc;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'b0; // Reset PC to 0
        else
            pc <= next_pc; // Update PC
    end

    logic[31:0] inc_pc = pc + 32'd4; // PC += 4

    assign next_pc = pc_src ? branch_target : inc_pc; // go to PC_next based on pc_src
endmodule
