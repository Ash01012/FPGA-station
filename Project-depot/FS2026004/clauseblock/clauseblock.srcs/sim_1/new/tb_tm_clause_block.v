`timescale 1ns/1ps

module tb_clause_block_top;

////////////////////////////////////////////////////////////
// Parameters
////////////////////////////////////////////////////////////

parameter NUM_FEATURES = 12;
parameter NUM_LITERALS = 24;
parameter NUM_CLAUSES  = 20;

////////////////////////////////////////////////////////////
// Inputs
////////////////////////////////////////////////////////////

reg r_clk;
reg r_reset;
reg r_y;

reg [NUM_FEATURES-1:0] r_X;
reg [NUM_CLAUSES*NUM_LITERALS-1:0] r_include_mask;

////////////////////////////////////////////////////////////
// Outputs
////////////////////////////////////////////////////////////

wire [NUM_LITERALS-1:0] w_literals;
wire [NUM_CLAUSES-1:0]  w_clause_output;

wire signed [4:0] w_class0_sum;
wire signed [4:0] w_class1_sum;

wire [7:0] w_class0_threshold;
wire [7:0] w_class1_threshold;

wire [NUM_CLAUSES*8-1:0] w_clause_random_bus;

wire [39:0] w_feedback_to_clause;

////////////////////////////////////////////////////////////
// DUT
////////////////////////////////////////////////////////////

clause_block_top u_clause_block_top
(
    .i_clk(r_clk),
    .i_reset(r_reset),

    .i_y(r_y),
    .i_X(r_X),

    .i_include_mask(r_include_mask),

    .o_literals(w_literals),
    .o_clause_output(w_clause_output),

    .o_class0_sum(w_class0_sum),
    .o_class1_sum(w_class1_sum),

    .o_class0_threshold(w_class0_threshold),
    .o_class1_threshold(w_class1_threshold),

    .o_clause_random_bus(w_clause_random_bus),

    .o_feedback_to_clause(w_feedback_to_clause)
);

////////////////////////////////////////////////////////////
// Clock Generation
////////////////////////////////////////////////////////////

always #5 r_clk = ~r_clk;

////////////////////////////////////////////////////////////
// Test
////////////////////////////////////////////////////////////

initial
begin

    r_clk   = 1'b0;
    r_reset = 1'b1;
    r_y     = 1'b0;

    //----------------------------------------------------
    // Input Feature Vector
    //----------------------------------------------------

    r_X = 12'b101100110101;

    //----------------------------------------------------
    // Clear Include Mask
    //----------------------------------------------------

    r_include_mask = 480'd0;

    //----------------------------------------------------
    // Class0 Positive Clauses (0-4)
    //----------------------------------------------------

    r_include_mask[23:0]    = 24'b000000000000000000000001;
    r_include_mask[47:24]   = 24'b000000000000000000000010;
    r_include_mask[71:48]   = 24'b000000000000000000000100;
    r_include_mask[95:72]   = 24'b000000000000000000001000;
    r_include_mask[119:96]  = 24'b000000000000000000010000;

    //----------------------------------------------------
    // Class0 Negative Clauses (5-9)
    //----------------------------------------------------

    r_include_mask[143:120] = 24'b000000000001000000000000;
    r_include_mask[167:144] = 24'b000000000010000000000000;
    r_include_mask[191:168] = 24'b000000000100000000000000;
    r_include_mask[215:192] = 24'b000000001000000000000000;
    r_include_mask[239:216] = 24'b000000010000000000000000;

    //----------------------------------------------------
    // Class1 Positive Clauses (10-14)
    //----------------------------------------------------

    r_include_mask[263:240] = 24'b000000000000000000100000;
    r_include_mask[287:264] = 24'b000000000000000001000000;
    r_include_mask[311:288] = 24'b000000000000000010000000;
    r_include_mask[335:312] = 24'b000000000000000100000000;
    r_include_mask[359:336] = 24'b000000000000001000000000;

    //----------------------------------------------------
    // Class1 Negative Clauses (15-19)
    //----------------------------------------------------

    r_include_mask[383:360] = 24'b000001000000000000000000;
    r_include_mask[407:384] = 24'b000010000000000000000000;
    r_include_mask[431:408] = 24'b000100000000000000000000;
    r_include_mask[455:432] = 24'b001000000000000000000000;
    r_include_mask[479:456] = 24'b010000000000000000000000;

    //----------------------------------------------------

    #20;
    r_reset = 1'b0;

    //----------------------------------------------------
    // Run for several clock cycles
    //----------------------------------------------------

    #100;

    //----------------------------------------------------
    // Change class label
    //----------------------------------------------------

    r_y = 1'b1;

    #100;

    $finish;

end

////////////////////////////////////////////////////////////
// Monitor
////////////////////////////////////////////////////////////

integer i;

always @(posedge r_clk)
begin

    $display("\n==========================================================");
    $display("TIME = %0t",$time);

    $display("Training Label (y) = %0d", r_y);

    $display("Input X            = %b", r_X);

    $display("----------------------------------------------------------");

    $display("Literals           = %b", w_literals);

    $display("Clause Outputs     = %b", w_clause_output);

    $display("----------------------------------------------------------");

    $display("Class0 Sum         = %0d", w_class0_sum);

    $display("Class1 Sum         = %0d", w_class1_sum);

    $display("----------------------------------------------------------");

    $display("Threshold0         = %0d", w_class0_threshold);

    $display("Threshold1         = %0d", w_class1_threshold);

    $display("----------------------------------------------------------");

    $display("Clause-wise Random Numbers and Feedback");

    for(i = 0; i < 20; i = i + 1)
    begin

        if(i < 10)
        begin
            $display(
            "Clause %02d | Random=%3d | Thr=%3d | Update=%0d | Feedback=%b",
                i,
                w_clause_random_bus[(i*8)+:8],
                w_class0_threshold,
                (w_clause_random_bus[(i*8)+:8] < w_class0_threshold),
                w_feedback_to_clause[(i*2)+:2]
            );
        end
        else
        begin
            $display(
            "Clause %02d | Random=%3d | Thr=%3d | Update=%0d | Feedback=%b",
                i,
                w_clause_random_bus[(i*8)+:8],
                w_class1_threshold,
                (w_clause_random_bus[(i*8)+:8] < w_class1_threshold),
                w_feedback_to_clause[(i*2)+:2]
            );
        end

    end

    $display("==========================================================");

end

endmodule