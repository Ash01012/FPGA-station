`timescale 1ns/1ps

module feedback_probability
#(
    parameter T = 15
)
(
    input              i_y,
    input  signed [4:0] i_class0_sum,
    input  signed [4:0] i_class1_sum,

    output reg [7:0] o_class0_threshold,
    output reg [7:0] o_class1_threshold
);

always @(*)
begin

    if(i_y == 1'b0)
    begin
        o_class0_threshold = ((T - i_class0_sum) << 8) / (2 * T);
        o_class1_threshold = ((T + i_class1_sum) << 8) / (2 * T);
    end
    else
    begin
        o_class0_threshold = ((T + i_class0_sum) << 8) / (2 * T);
        o_class1_threshold = ((T - i_class1_sum) << 8) / (2 * T);
    end

end

endmodule