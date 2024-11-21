module PCTOP #(
    parameter WIDTH = 32

)(
    input logic                      clk,
    input logic                      rst,
    input logic                      PCsrc,
    input logic  [WIDTH-1:0]         ImmOp,
    output logic [WIDTH-1:0] PC

);

logic [WIDTH-1:0]       branch_PC;
logic [WIDTH-1:0]       next_PC;
logic [WIDTH-1:0]       inc_PC;

//PC register holds the current PC value
always_ff @ (posedge clk or posedge rst) begin
    if (rst) PC <= 32'd0;
    else     PC <= next_PC;
end

always_comb begin
    inc_PC = PC + 32'd4;
    branch_PC = PC + ImmOp;
    next_PC = PCsrc ? branch_PC:inc_PC;
    
end

endmodule
