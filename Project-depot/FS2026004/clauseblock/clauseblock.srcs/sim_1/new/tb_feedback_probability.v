`timescale 1ns/1ps

module tb_feedback_probability;

//////////////////////////////////////////////////
// Inputs
//////////////////////////////////////////////////

reg r_y;
reg signed [4:0] r_class0_sum;
reg signed [4:0] r_class1_sum;

//////////////////////////////////////////////////
// Outputs
//////////////////////////////////////////////////

wire [7:0] w_class0_threshold;
wire [7:0] w_class1_threshold;

//////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////

feedback_probability
#(
    .T(15)
)
u_feedback_probability
(
    .i_y(r_y),
    .i_class0_sum(r_class0_sum),
    .i_class1_sum(r_class1_sum),

    .o_class0_threshold(w_class0_threshold),
    .o_class1_threshold(w_class1_threshold)
);

//////////////////////////////////////////////////
// Test Cases
//////////////////////////////////////////////////

initial
begin

    //------------------------------------------------
    // Test 1
    //------------------------------------------------
    // y = 0
    // class0_sum = 1
    // class1_sum = 1
    //------------------------------------------------

    r_y = 1'b0;
    r_class0_sum = 1;
    r_class1_sum = 1;

    #10;

    $display("-------------------------------------");
    $display("TEST-1");
    $display("y                = %0d", r_y);
    $display("class0_sum       = %0d", r_class0_sum);
    $display("class1_sum       = %0d", r_class1_sum);
    $display("class0_threshold = %0d", w_class0_threshold);
    $display("class1_threshold = %0d", w_class1_threshold);

    //------------------------------------------------
    // Test 2
    //------------------------------------------------
    // y = 0
    // class0_sum = 5
    // class1_sum = -5
    //------------------------------------------------

    r_y = 1'b0;
    r_class0_sum = 5;
    r_class1_sum = -5;

    #10;

    $display("-------------------------------------");
    $display("TEST-2");
    $display("y                = %0d", r_y);
    $display("class0_sum       = %0d", r_class0_sum);
    $display("class1_sum       = %0d", r_class1_sum);
    $display("class0_threshold = %0d", w_class0_threshold);
    $display("class1_threshold = %0d", w_class1_threshold);

    //------------------------------------------------
    // Test 3
    //------------------------------------------------
    // y = 1
    // class0_sum = 2
    // class1_sum = 3
    //------------------------------------------------

    r_y = 1'b1;
    r_class0_sum = 2;
    r_class1_sum = 3;

    #10;

    $display("-------------------------------------");
    $display("TEST-3");
    $display("y                = %0d", r_y);
    $display("class0_sum       = %0d", r_class0_sum);
    $display("class1_sum       = %0d", r_class1_sum);
    $display("class0_threshold = %0d", w_class0_threshold);
    $display("class1_threshold = %0d", w_class1_threshold);

    //------------------------------------------------
    // Test 4
    //------------------------------------------------
    // y = 1
    // class0_sum = -2
    // class1_sum = -3
    //------------------------------------------------

    r_y = 1'b1;
    r_class0_sum = -2;
    r_class1_sum = -3;

    #10;

    $display("-------------------------------------");
    $display("TEST-4");
    $display("y                = %0d", r_y);
    $display("class0_sum       = %0d", r_class0_sum);
    $display("class1_sum       = %0d", r_class1_sum);
    $display("class0_threshold = %0d", w_class0_threshold);
    $display("class1_threshold = %0d", w_class1_threshold);

    $finish;

end

endmodule