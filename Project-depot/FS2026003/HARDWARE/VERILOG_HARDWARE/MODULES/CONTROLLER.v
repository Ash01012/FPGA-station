`timescale 1ns / 1ps



// ........CONTROLLER CODE WITHOUT BRAM APPLICATION(only simulation)..........

//module CONTROLLER (i_clk , i_start ,o_done ,i_clause_finish , i_reset ,i_Xtest_finish , o_evaluate_clause , o_evaluate_sample ,o_evaluate_output,
//o_load_Xtest , o_load_Ytest, o_load_ref,o_load_weight,o_evaluate_accumulator);

//input i_clk,i_start,i_reset ;
//input i_clause_finish, i_Xtest_finish;

//output reg o_done , o_evaluate_clause , o_evaluate_sample  , o_evaluate_output ,  o_load_Xtest , o_load_Ytest, o_load_ref ,o_load_weight,o_evaluate_accumulator;

//reg [2:0] r_state ;
//parameter S0 = 3'b000,S1= 3'b001,S2 = 3'b010,S3 = 3'b011,S4 = 3'b100,S5 = 3'b101,S6 = 3'b110,S7 = 3'b111;

//always @(posedge i_clk or posedge i_reset) begin
//     if(i_reset)
//        r_state <= S0;
//     else begin   
//     case(r_state)
//     S0 : if(i_start) r_state <= S1 ;
//     S1 : r_state <= S2;
//     S2 : r_state <= S3;
//     S3 : if(i_clause_finish != 1) 
//                 r_state <= S2;
//           else 
//                 r_state <= S4;
//     S4 : r_state <= S5;
//     S5 : r_state <= S6;
//     S6 :  if(i_Xtest_finish != 1 )
//                r_state <= S1;
//            else 
//                r_state <= S7;
//     S7 : r_state <= S7;
//    default : r_state <= S0;
//    endcase
//    end 

//end 

//always @(*) begin
//    o_done = 0;
//    o_load_Xtest =0 ; o_load_Ytest = 0 ; o_load_ref = 0;
//    o_load_weight = 0;
//    o_evaluate_clause = 0;  
//    o_evaluate_sample = 0;
//    o_evaluate_output = 0;
//    o_evaluate_accumulator = 0;        
//    case(r_state) 
//    S0 : begin o_done=0; end
//    S1 : begin  o_load_Xtest = 1; end 
//    S2 : begin  o_load_ref = 1; o_load_weight = 1; end 
//    S3 : begin  o_evaluate_clause = 1 ; o_evaluate_accumulator = 1; end 
//    S4 : begin  o_load_Ytest = 1;end
//    S5 : begin  o_evaluate_output = 1; o_evaluate_sample =1; end 
//    S7 : begin  o_done =1; end 
//    default : begin o_done  = 0 ; end 
//    endcase 
//end 
//endmodule



//               .........CONTROLLER...CODE...WITH...BRAM..........


module CONTROLLER (i_clk , i_start ,o_done ,i_clause_finish , i_reset ,i_Xtest_finish , o_evaluate_clause , o_evaluate_sample ,o_evaluate_output,
o_load_Xtest , o_load_Ytest, o_load_ref,o_load_weight,o_evaluate_accumulator);

input i_clk,i_start,i_reset ;
input i_clause_finish, i_Xtest_finish;

output reg o_done , o_evaluate_clause , o_evaluate_sample  , o_evaluate_output ,  o_load_Xtest , o_load_Ytest, o_load_ref ,o_load_weight,o_evaluate_accumulator;

reg [3:0] r_state ;
parameter S0 = 4'b0000,S1= 4'b0001,S2 = 4'b0010,S3 = 4'b0011,S4 = 4'b0100,S5 = 4'b0101,S6 = 4'b0110,S7 = 4'b0111,S8 = 4'b1000,S9 = 4'b1001,S10 = 4'b1010;

always @(posedge i_clk or posedge i_reset) begin
     if(i_reset)
        r_state <= S0;
     else begin   
     case(r_state)

     S0 : if(i_start) r_state <= S1 ; // sab reset se Xtest ka waiting 
     S1 : r_state <= S2;   //  waiting se load_xtest
     S2 : r_state <= S3;   // load xtest se waiting for ref,weights   
     S3 : r_state <= S4;   // waiting se loadref,loadweight
     S4 : r_state <= S5;   // fir wo accumulator 
     S5 : if(i_clause_finish != 1) 
                r_state <= S3;
           else 
                r_state <= S6;   // fir Ytest ka waiting 
     S6 : r_state <= S7;
     S7 : r_state <= S8;         // ye wala BRAM SE pehle se hi tha 
     S8 : r_state <= S9;         // ye wala BRAM SE pehle se hi tha
     S9 : if(i_Xtest_finish != 1 )
                r_state <= S1;   // fir Xtest ke waiting ke liye
           else 
                r_state <= S10;
     S10 : r_state <= S10;        
    default : r_state <= S0;
    endcase
    end 

end 

always @(*) begin
    o_done = 0;
    o_load_Xtest =0 ; o_load_Ytest = 0 ; o_load_ref = 0;
    o_load_weight = 0;
    o_evaluate_clause = 0;  
    o_evaluate_sample = 0;
    o_evaluate_output = 0;
    o_evaluate_accumulator = 0;        
    case(r_state) 
    S0 : begin  o_done=0; end
    S2 : begin  o_load_Xtest = 1; end 
    S4 : begin  o_load_ref = 1; o_load_weight = 1; end 
    S5 : begin  o_evaluate_clause = 1 ; o_evaluate_accumulator = 1; end 
    S7 : begin  o_load_Ytest = 1;end
    S8 : begin  o_evaluate_output = 1; o_evaluate_sample =1; end 
    S10 :begin  o_done =1; end   
    default : begin o_done  = 0 ; end     
 
      endcase 
end 
endmodule