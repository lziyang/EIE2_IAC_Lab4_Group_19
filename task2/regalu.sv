module regalu #(
    parameter A_WIDTH = 32,
    parameter D_WIDTH = 32
)(
    input logic clk,
    input logic wr_en,
    input logic [D_WIDTH-1:0]    wr_data,
    output logic [D_WIDTH-1:0]   rd1,
    output logic [D_WIDTH-1:0]   rd2,
    output logic [D_WIDTH-1:0]   a0,
    input logic [D_WIDTH-1:0] op1,
    input logic [D_WIDTH-1:0] op2,
    input logic ctrl,
    output logic [D_WIDTH] sum,
    output logic eq
    input   logic [D_WIDTH-1:0]  in0,
    input   logic [D_WIDTH-1:0]  in1,
    input logic [D_WIDTH-1:0]   imm,
    input   logic sel,
    output  logic [D_WIDTH-1:0]  out
);

    logic [A_WIDTH-1:0] address1;
    logic [A_WIDTH-1:0] address2;
    logic [A_WIDTH-1:0] address3;

reg #(A_WIDTH, D_WIDTH) regfile(
    .clk (clk),
    .wr_en (wr_en),
    .addr1 (address1),
    .addr2 (address3),
    .wr_data (sum),
    .a0 (a0),
    .rd1 (rd1),
    .rd2 (rd2)
);

mux #(D_WIDTH) alumux(
    .in0 (rd2),
    .in1 (imm),
    .sel (sel),
    .out (out)
);

alu #(D_WIDTH) alu(
    .op1 (rd1),
    .op2 (out),
    .ctrl (ctrl),
    .sum (sum),
    .eq (sq)
);
endmodule
