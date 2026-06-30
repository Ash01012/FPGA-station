`timescale 1ns/1ps

module class_sum
(
    input  [19:0] i_clause_output,

    output reg signed [4:0] o_class0_sum,
    output reg signed [4:0] o_class1_sum
);

integer i;

always @(*)
begin

    o_class0_sum = 0;
    o_class1_sum = 0;

    //----------------------------
    // Class 0 Positive
    //----------------------------

    for(i = 0; i < 5; i = i + 1)
        o_class0_sum = o_class0_sum + i_clause_output[i];

    //----------------------------
    // Class 0 Negative
    //----------------------------

    for(i = 5; i < 10; i = i + 1)
        o_class0_sum = o_class0_sum - i_clause_output[i];

    //----------------------------
    // Class 1 Positive
    //----------------------------

    for(i = 10; i < 15; i = i + 1)
        o_class1_sum = o_class1_sum + i_clause_output[i];

    //----------------------------
    // Class 1 Negative
    //----------------------------

    for(i = 15; i < 20; i = i + 1)
        o_class1_sum = o_class1_sum - i_clause_output[i];

end

endmodule