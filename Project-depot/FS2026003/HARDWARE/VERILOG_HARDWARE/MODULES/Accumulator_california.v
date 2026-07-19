`timescale 1ns / 1ps

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
