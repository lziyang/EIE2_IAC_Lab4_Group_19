module #(
    parameter DATA_WIDTH = 32
)(
    input logic [DATA_WIDTH-1:0] op1,
    input logic [DATA_WIDTH-1:0] op2,
    input logic ctrl,
    output logic [DATA_WIDTH] sum,
    output logic eq    
)(
    if (ctrl)
        sum <= op1 + op2;
    else
        if (op1 - op2 == DATA_WIDTH[1'b0])
            eq <= 1'b1;
        else
            eq <= 1'b0;
)
endmodule
