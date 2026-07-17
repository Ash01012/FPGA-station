`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 18:40:46
// Design Name: 
// Module Name: TESTBENCH
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


module TESTBENCH;
reg r_start,r_clk,r_reset;
wire w_done;
wire [15:0] w_MAE;
TOPMODULE TOP(
    .i_clk(r_clk),
    .i_reset(r_reset),
    .i_start(r_start),
    .o_done(w_done),
    .o_MAE(w_MAE)
);

initial begin
    r_clk = 1'b0;
end     

always #5 r_clk = ~ r_clk;


initial begin
    r_reset = 1;
    r_start = 0;

//    #20;
//    reset = 0;

//    #20;
//    start = 1;

//    #10;
//    start = 0;

#100;
r_reset = 0;

#100;
r_start = 1;

#10;
r_start = 0;
end

initial begin
    wait(w_done);
    #1000;               // optional, lets MAE settle/register
    $display("Final MAE = %0d", w_MAE);
    $finish;
end

endmodule
