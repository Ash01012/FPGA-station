`timescale 1ns / 1ps

//module Accumulator_california ( clk , reset , SUM , A , evaluate , load_Xtest ,weight) ;
//input clk, reset , A , evaluate , load_Xtest; 
//input signed [31:0] weight;
//output reg signed [31:0] SUM ;
//always @ (posedge clk or posedge reset) begin
//if (reset) begin 
//SUM <= 0;
//end 

//else if( evaluate == 1) begin 
//SUM <= SUM + (A ? weight : 0);
//end 

//else if( load_Xtest == 1)begin 
//SUM <= 0;
//end 

//end 
//endmodule 


//           ....ACCUMULATOR..WITHOUT..BRAM.......

//module Accumulator_california ( i_clk , i_reset , o_SUM , i_A , i_evaluate , i_load_Xtest ,i_weight) ;
//input i_clk, i_reset , i_A , i_evaluate , i_load_Xtest; 
//input signed [31:0] i_weight;
//output reg signed [31:0] o_SUM ;


//always @ (posedge i_clk or posedge i_reset) begin
//if (i_reset) begin 
//o_SUM <= 0;
//end 

//else if( i_evaluate == 1) begin 
//o_SUM <= o_SUM + (i_A ? i_weight : 0);
//end 

//else if( i_load_Xtest == 1)begin 
//o_SUM <= 0;
//end 


//end 
//endmodule 




//                    ...WITH...BRAM...ACCUMULATOR....


module Accumulator_california ( i_clk , i_reset , o_SUM , i_A , i_evaluate , i_load_Xtest ,i_weight) ;
input i_clk, i_reset , i_A , i_evaluate , i_load_Xtest;
input signed [31:0] i_weight;
output reg signed [31:0] o_SUM ;


always @ (posedge i_clk or posedge i_reset) begin
if (i_reset) begin 
o_SUM <= 0;
end 

else if( i_evaluate == 1) begin 
o_SUM <= o_SUM + (i_A ? i_weight : 0);
end 

else if( i_load_Xtest == 1)begin 
o_SUM <= 0;
end 


end 
endmodule
