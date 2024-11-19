module reg #(
    parameter   ADDRESS_WIDTH = 32,
                DATA_WIDTH = 32
)(
    input logic                     clk,
    input logic                     wr_en,,
    input logic [ADDRESS_WIDTH-1:0] addr1,
    input logic [ADDRESS_WIDTH-1:0] addr2,
    input logic [ADDRESS_WIDTH-1:0] addr3,
    input logic [DATA_WIDTH-1:0]    wr_data,
    output logic [DATA_WIDTH-1:0]   rd1,
    output logic [DATA_WIDTH-1:0]   rd2,
    output logic [DATA_WIDTH-1:0]   a0
);

logic [DATA_WIDTH-1:0]  reg_array [2**ADDRESS_WIDTH-1:0];

rd1 <= reg_array[addr1];
rd2 <= reg_array[addr2];

always_ff @(posedge clk) begin
    if (wr_en == 1'b1)
        reg_array[addr3] <= wr_data;
end

assign a0 = wr_data;

endmodule
