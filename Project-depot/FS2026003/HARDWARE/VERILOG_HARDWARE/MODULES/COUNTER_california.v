`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 16:24:07
// Design Name: 
// Module Name: COUNTER_california
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

module COUNTER_california(
     i_maximum_count , o_count , o_finish , i_clk , i_evaluate ,i_reset ,i_counter_reset 
    );
    input [15:0] i_maximum_count; 
input i_clk , i_reset , i_evaluate ,i_counter_reset;
output reg [15:0] o_count ;
output reg o_finish;
always @(posedge i_clk or posedge i_reset) begin
    if(i_reset) begin 
    o_count <= 0;
    o_finish <= 0;
    end

    else if( i_evaluate ) begin 
         if(o_count == i_maximum_count - 1) begin
                o_count <= o_count +1 ;
                 o_finish <= 1;
         end 
         else if (o_count < i_maximum_count)  begin
                o_count <= o_count +1 ;
                o_finish <= 0;
         end      
    end 
    
    else if(i_counter_reset == 1) begin  
         o_finish <= 0;
         o_count <= 0;
    end 

end 
endmodule
