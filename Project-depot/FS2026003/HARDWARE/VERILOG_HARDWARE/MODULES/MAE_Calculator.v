`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 16:09:40
// Design Name: 
// Module Name: MAE_Calculator
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


module MAE_Calculator(
     i_clk , i_Ytest , i_SUM , i_evaluate_output , o_Absolute_Sum  , i_reset
    );
input i_clk , i_reset ,i_evaluate_output ;

wire signed [63:0]w_temp;
wire signed [63:0]w_temp2;
wire signed [63:0]w_difference;
localparam signed [31:0] MAX = 32'sd500001;
localparam signed [31:0] MIN = 32'sd14999;
localparam signed [31:0] T   = 32'sd5000;
input signed [31:0] i_SUM;
input [31:0] i_Ytest ;
output reg signed [63:0] o_Absolute_Sum;
integer sample_no;
assign w_temp = i_SUM * (MAX - MIN);
assign w_temp2 = (w_temp / T) + (MIN);
assign w_difference = w_temp2 - (i_Ytest);


initial begin
   sample_no = 0;
end 
always @(posedge i_clk or posedge i_reset) begin
if(i_reset) begin
o_Absolute_Sum <= 0 ;
end 

else if( i_evaluate_output == 1 )  begin
        if(w_difference < 0)
             o_Absolute_Sum <= o_Absolute_Sum + (-w_difference);
        else
             o_Absolute_Sum <= o_Absolute_Sum + w_difference;
end


end     
endmodule
