`timescale 1ns/1ps

module tb_feedback_controller;

//////////////////////////////////////////////////
// Inputs
//////////////////////////////////////////////////

reg r_y;

reg [7:0] r_class0_threshold;
reg [7:0] r_class1_threshold;

reg [159:0] r_clause_random_bus;

//////////////////////////////////////////////////
// Outputs
//////////////////////////////////////////////////

wire [39:0] w_feedback_to_clause;

//////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////

feedback_controller u_feedback_controller
(
    .i_y(r_y),

    .i_class0_threshold(r_class0_threshold),
    .i_class1_threshold(r_class1_threshold),

    .i_clause_random_bus(r_clause_random_bus),

    .o_feedback_to_clause(w_feedback_to_clause)
);

//////////////////////////////////////////////////
// Test
//////////////////////////////////////////////////

initial
begin

    //--------------------------------------------------
    // TEST-1
    //--------------------------------------------------

    r_y = 1'b0;

    r_class0_threshold = 8'd120;
    r_class1_threshold = 8'd90;

    // Clause0-19 Random Numbers

    r_clause_random_bus[7:0]      = 8'd50;
    r_clause_random_bus[15:8]     = 8'd150;
    r_clause_random_bus[23:16]    = 8'd70;
    r_clause_random_bus[31:24]    = 8'd20;
    r_clause_random_bus[39:32]    = 8'd130;
    r_clause_random_bus[47:40]    = 8'd40;
    r_clause_random_bus[55:48]    = 8'd180;
    r_clause_random_bus[63:56]    = 8'd60;
    r_clause_random_bus[71:64]    = 8'd30;
    r_clause_random_bus[79:72]    = 8'd170;

    r_clause_random_bus[87:80]    = 8'd50;
    r_clause_random_bus[95:88]    = 8'd95;
    r_clause_random_bus[103:96]   = 8'd20;
    r_clause_random_bus[111:104]  = 8'd80;
    r_clause_random_bus[119:112]  = 8'd100;

    r_clause_random_bus[127:120]  = 8'd30;
    r_clause_random_bus[135:128]  = 8'd110;
    r_clause_random_bus[143:136]  = 8'd60;
    r_clause_random_bus[151:144]  = 8'd10;
    r_clause_random_bus[159:152]  = 8'd120;

    #10;

    $display("-------------------------------------------");
    $display("TEST-1");
    $display("Feedback = %b", w_feedback_to_clause);

    //--------------------------------------------------
    // TEST-2
    //--------------------------------------------------

    r_y = 1'b1;

    r_class0_threshold = 8'd100;
    r_class1_threshold = 8'd150;

    #10;

    $display("-------------------------------------------");
    $display("TEST-2");
    $display("Feedback = %b", w_feedback_to_clause);

    $finish;

end

endmodule
