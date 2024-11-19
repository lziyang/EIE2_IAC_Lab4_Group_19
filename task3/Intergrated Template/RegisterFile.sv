module RegisterFile (
    input  logic          clk,
    input  logic          reg_write,
    input  logic [4:0]    read_addr1, read_addr2, write_addr,
    input  logic [31:0]   write_data,
    output logic [31:0]   read_data1, read_data2
);
    logic [31:0] registers [0:31]; // 32*32 registers

    // Asynchronous read
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];

    // Synchronous write
    always_ff @(posedge clk) begin
        if (reg_write) begin
            registers[write_addr] <= write_data;
        end
    end
endmodule
