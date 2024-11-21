module RegFile (
    input logic clk,
    input logic [4:0] AD1,
    input logic [4:0] AD2,
    input logic [4:0] AD3,
    input logic [31:0] WD3,
    input logic WE3,
    output logic [31:0] a0,
    output logic [31:0] RD1,
    output logic [31:0] RD2
);

    logic [31:0] registerarr [0:31];

    assign RD1 = registerarr[AD1];
    assign RD2 = registerarr[AD2];
    assign a0 = registerarr[10];

    always_ff @(posedge clk) begin
        if (WE3) begin
            registerarr[AD3] <= WD3;
            registerarr[10] <=WD3;
        end
    end

endmodule
