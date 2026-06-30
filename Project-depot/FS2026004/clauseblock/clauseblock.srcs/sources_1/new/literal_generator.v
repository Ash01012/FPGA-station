`timescale 1ns/1ps

module literal_generator
(
    input  [11:0] i_X,

    output [23:0] o_literals
);

    //------------------------------------------------
    // Positive Literals
    //------------------------------------------------

    assign o_literals[11:0] = i_X;

    //------------------------------------------------
    // Negative Literals
    //------------------------------------------------

    assign o_literals[23:12] = ~i_X;

endmodule