`timescale 1ns/1ps

module tb_clause_module;

//////////////////////////////////////////////////
// Inputs
//////////////////////////////////////////////////

reg  [23:0] r_literals;
reg  [23:0] r_include_mask;

//////////////////////////////////////////////////
// Outputs
//////////////////////////////////////////////////

wire w_clause_output;

//////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////

clause_module u_clause_module
(
    .i_literals(r_literals),
    .i_include_mask(r_include_mask),
    .o_clause_output(w_clause_output)
);

//////////////////////////////////////////////////
// Test
//////////////////////////////////////////////////

initial
begin

    //-------------------------------------------------
    // Test 1 : All included literals are 1
    //-------------------------------------------------

    r_literals     = 24'b000000000000000000001111;
    r_include_mask = 24'b000000000000000000000111;

    #10;

    $display("Test1");
    $display("Clause Output = %b", w_clause_output);

    //-------------------------------------------------
    // Test 2 : One included literal is 0
    //-------------------------------------------------

    r_literals     = 24'b000000000000000000000101;
    r_include_mask = 24'b000000000000000000000111;

    #10;

    $display("Test2");
    $display("Clause Output = %b", w_clause_output);

    //-------------------------------------------------
    // Test 3 : Empty Clause
    //-------------------------------------------------

    r_literals     = 24'hFFFFFF;
    r_include_mask = 24'd0;

    #10;

    $display("Test3");
    $display("Clause Output = %b", w_clause_output);

    $finish;

end

endmodule