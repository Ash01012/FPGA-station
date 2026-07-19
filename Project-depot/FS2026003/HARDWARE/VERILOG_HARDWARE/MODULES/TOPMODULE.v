`timescale 1ns / 1ps



//         .............TOPMODULE....WITHOUT...BRAM(only simulation) ...........


//module TOPMODULE(
//    input i_clk,
//    input i_reset,
//    input i_start,
//    output o_done,
//    output reg [31:0] o_MAE
//    );
//wire w_A,w_evaluate_accumulator,w_load_Xtest,w_evaluate_output,w_clause_finish,w_Xtest_finish,w_evaluate_clause,w_load_Ytest,w_load_weight,w_evaluate_sample,w_start,w_done,w_load_ref;
//wire signed [31:0]w_SUM;     
//wire [15:0]w_count_sample;
//wire [15:0]w_count_clause;
//wire signed [63:0] w_Absolute_Sum;

//    reg [159:0] r_ref_mem  [0:999];
//    reg [159:0] r_test_mem [0:99];
//    reg [31:0] r_Ytest_mem [0:99];
//    reg signed [31:0] r_weights_mem [0:999];
//initial begin
//        $readmemb("clauses_160_2.mem", r_ref_mem);
//        $readmemb("Xtest_160_2.mem", r_test_mem);
//        $readmemb("Ytest_160_2.mem", r_Ytest_mem);
//        $readmemb("weights_160_2.mem", r_weights_mem);
//end
//    reg [159:0] r_ref;
//    reg [159:0] r_test;
//    reg [31:0] r_Ytest;
//    reg signed [31:0] r_weight;



//always @(posedge i_clk) begin
//  if(i_reset)
//        o_MAE <= 1'b1;
//    else if(o_done)
//        o_MAE <= w_Absolute_Sum / 100;
//end 

//always @(posedge i_clk) begin
//    if (w_load_ref)
//        r_ref <= r_ref_mem[w_count_clause];

//    if (w_load_Xtest)
//        r_test <= r_test_mem[w_count_sample];

//    if (w_load_Ytest)
//        r_Ytest <= r_Ytest_mem[w_count_sample];
    
//    if (w_load_weight)
//        r_weight <= r_weights_mem[w_count_clause];    
//end

//Clause_Matching_function clause_function(
//     .i_clause(r_ref),
//     .i_test(r_test),
//     .o_vout(w_A)
//    );    
    
//Accumulator_california accumulator(    
//    .i_clk(i_clk),
//    .i_reset(i_reset) ,
//    .o_SUM(w_SUM) ,
//    .i_A(w_A) ,
//    .i_evaluate(w_evaluate_accumulator) ,
//    .i_load_Xtest(w_load_Xtest),
//    .i_weight(r_weight),
//    .i_count_sample(w_count_sample),
//    .i_count_clause(w_count_clause)
//    );
    
//MAE_Calculator mae_calculator(    
//    .i_clk(i_clk),
//    .i_Ytest(r_Ytest),
//    .i_SUM(w_SUM) , 
//    .i_evaluate_output(w_evaluate_output) , 
//    .o_Absolute_Sum(w_Absolute_Sum)  , 
//    .i_reset(i_reset)
//    );
    

   
//COUNTER_california CLAUSE_COUNTER(    
//   .i_maximum_count(16'd999) , 
//   .o_count(w_count_clause) , 
//   .o_finish(w_clause_finish) ,
//   .i_clk(i_clk) , 
//   .i_evaluate(w_evaluate_clause),
//   .i_reset(i_reset) ,
//   .i_counter_reset(w_load_Ytest) 
//   );   


//COUNTER_california SAMPLE_COUNTER(    
//   .i_maximum_count(16'd99) , 
//   .o_count(w_count_sample) , 
//   .o_finish(w_Xtest_finish) ,
//   .i_clk(i_clk) , 
//   .i_evaluate(w_evaluate_sample),
//   .i_reset(i_reset) ,
//   .i_counter_reset(1'b0) 
//   ); 
   


//CONTROLLER controller(   
//.i_clk(i_clk),
//.i_start(i_start),
//.o_done(o_done),
//.i_clause_finish(w_clause_finish),
//.i_reset(i_reset),
//.i_Xtest_finish(w_Xtest_finish),
//.o_evaluate_clause(w_evaluate_clause),
//.o_evaluate_sample(w_evaluate_sample),
//.o_evaluate_output(w_evaluate_output),
//.o_load_Xtest(w_load_Xtest),
//.o_load_Ytest(w_load_Ytest),
//.o_load_ref(w_load_ref),
//.o_load_weight(w_load_weight),
//.o_evaluate_accumulator(w_evaluate_accumulator)
//);
//endmodule




//                  .......TOPMODULE....WITH...BRAM..........

module TOPMODULE(
    input i_clk,
    input i_reset,
    input i_start,
    output o_done,
    output reg [31:0] o_MAE
    );
wire w_A,w_evaluate_accumulator,w_load_Xtest,w_evaluate_output,w_clause_finish,w_Xtest_finish,w_evaluate_clause,w_load_Ytest,w_load_weight,w_evaluate_sample,w_start,w_done,w_load_ref;
wire signed [31:0]w_SUM;     
wire [9:0]w_count_sample;  // because the BRAM address input is addra : STD_LOGIC_VECTOR(9 DOWNTO 0)
wire [9:0]w_count_clause;  // because the BRAM address input is addra : STD_LOGIC_VECTOR(9 DOWNTO 0)
wire signed [63:0] w_Absolute_Sum;


wire [159:0] w_clause_data;
wire [159:0] w_xtest_data;
wire [31:0]  w_ytest_data;
wire signed [31:0] w_weight_data;

CLAUSES_BRAM u_clause_bram (
    .clka(i_clk),
    .ena(1'b1),
    .wea(1'b0),
    .addra(w_count_clause),
    .dina(160'b0),
    .douta(w_clause_data)
);

Weights_160_BRAM u_weights_160_bram (
    .clka(i_clk),
    .ena(1'b1),
    .wea(1'b0),
    .addra(w_count_clause),
    .dina(32'b0),
    .douta(w_weight_data)
);


Xtest_160_BRAM u_Xtest_160_bram (
    .clka(i_clk),
    .ena(1'b1),
    .wea(1'b0),
    .addra({3'b0 , w_count_sample}),
    .dina(160'b0),
    .douta(w_xtest_data)
);

Ytest_160_BRAM u_Ytest_160_bram (
    .clka(i_clk),
    .ena(1'b1),
    .wea(1'b0),
    .addra(w_count_sample),
    .dina(32'b0),
    .douta(w_ytest_data)
);


    reg [159:0] r_ref;
    reg [159:0] r_test;
    reg [31:0] r_Ytest;
    reg signed [31:0] r_weight;


always @(posedge i_clk) begin
  if(i_reset)
        o_MAE <= 1'b1;
    else if(o_done)
        o_MAE <= w_Absolute_Sum / 100;
end 

always @(posedge i_clk) begin
    if (w_load_ref)
        r_ref <= w_clause_data;

    if (w_load_Xtest)
        r_test <= w_xtest_data;

    if (w_load_Ytest)
        r_Ytest <= w_ytest_data;

    if (w_load_weight)
        r_weight <= w_weight_data;
end

Clause_Matching_function clause_function(
     .i_clause(r_ref),
     .i_test(r_test),
     .o_vout(w_A)
    );    
    

Accumulator_california accumulator(    
    .i_clk(i_clk),
    .i_reset(i_reset) ,
    .o_SUM(w_SUM) ,
    .i_A(w_A) ,
    .i_evaluate(w_evaluate_accumulator) ,
    .i_load_Xtest(w_load_Xtest),
    .i_weight(r_weight)
    );

    
MAE_Calculator mae_calculator(    
    .i_clk(i_clk),
    .i_Ytest(r_Ytest),
    .i_SUM(w_SUM) , 
    .i_evaluate_output(w_evaluate_output) , 
    .o_Absolute_Sum(w_Absolute_Sum)  , 
    .i_reset(i_reset)
    );
    

   
COUNTER_california CLAUSE_COUNTER(    
   .i_maximum_count(16'd999) , 
   .o_count(w_count_clause) , 
   .o_finish(w_clause_finish) ,
   .i_clk(i_clk) , 
   .i_evaluate(w_evaluate_clause),
   .i_reset(i_reset) ,
   .i_counter_reset(w_load_Ytest) 
   );   


COUNTER_california SAMPLE_COUNTER(    
   .i_maximum_count(16'd99) , 
   .o_count(w_count_sample) , 
   .o_finish(w_Xtest_finish) ,
   .i_clk(i_clk) , 
   .i_evaluate(w_evaluate_sample),
   .i_reset(i_reset) ,
   .i_counter_reset(1'b0) 
   ); 
   


CONTROLLER controller(   
.i_clk(i_clk),
.i_start(i_start),
.o_done(o_done),
.i_clause_finish(w_clause_finish),
.i_reset(i_reset),
.i_Xtest_finish(w_Xtest_finish),
.o_evaluate_clause(w_evaluate_clause),
.o_evaluate_sample(w_evaluate_sample),
.o_evaluate_output(w_evaluate_output),
.o_load_Xtest(w_load_Xtest),
.o_load_Ytest(w_load_Ytest),
.o_load_ref(w_load_ref),
.o_load_weight(w_load_weight),
.o_evaluate_accumulator(w_evaluate_accumulator)
);
endmodule
