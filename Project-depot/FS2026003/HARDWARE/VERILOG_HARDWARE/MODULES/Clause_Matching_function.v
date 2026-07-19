`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 16:12:05
// Design Name: 
// Module Name: Clause_Matching_function
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Clause_Matching_function(
    input [159:0] i_clause,
    input [159:0] i_test,
    output o_vout
    );
wire [159:0] w_temp;    
// CLAUSE MATCHING
assign w_temp =(~i_clause)|(i_test);
// FINAL OUTPUT
assign o_vout = &w_temp;
endmodule