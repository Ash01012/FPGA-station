
module clause_block_top
#(
    parameter NUM_FEATURES = 12,
    parameter NUM_LITERALS = 24,
    parameter NUM_CLAUSES  = 20,
    parameter T            = 15
)
(
    //----------------------------------------------------
    // Inputs
    //----------------------------------------------------

    input                         i_clk,
    input                         i_reset,

    input                         i_y,
    input  [NUM_FEATURES-1:0]     i_X,

    input  [NUM_CLAUSES*NUM_LITERALS-1:0] i_include_mask,

    //----------------------------------------------------
    // Outputs
    //----------------------------------------------------

    output [NUM_LITERALS-1:0] o_literals,

    output [NUM_CLAUSES-1:0] o_clause_output,

    output signed [4:0] o_class0_sum,
    output signed [4:0] o_class1_sum,

    output [7:0] o_class0_threshold,
    output [7:0] o_class1_threshold,

    output [NUM_CLAUSES*8-1:0] o_clause_random_bus,

    output [39:0] o_feedback_to_clause
);

////////////////////////////////////////////////////////////
// Literal Generator
////////////////////////////////////////////////////////////

literal_generator u_literal_generator
(
    .i_X(i_X),
    .o_literals(o_literals)
);

////////////////////////////////////////////////////////////
// Clause Block
////////////////////////////////////////////////////////////

clause_block u_clause_block
(
    .i_literals(o_literals),
    .i_include_mask(i_include_mask),
    .o_clause_output(o_clause_output)
);

////////////////////////////////////////////////////////////
// Class Sum
////////////////////////////////////////////////////////////

class_sum u_class_sum
(
    .i_clause_output(o_clause_output),
    .o_class0_sum(o_class0_sum),
    .o_class1_sum(o_class1_sum)
);

////////////////////////////////////////////////////////////
// Feedback Probability
////////////////////////////////////////////////////////////

feedback_probability
#(
    .T(T)
)
u_feedback_probability
(
    .i_y(i_y),

    .i_class0_sum(o_class0_sum),
    .i_class1_sum(o_class1_sum),

    .o_class0_threshold(o_class0_threshold),
    .o_class1_threshold(o_class1_threshold)
);

////////////////////////////////////////////////////////////
// Clause Random Number Generator
////////////////////////////////////////////////////////////

clause_rng_bank
#(
    .NUM_CLAUSES(NUM_CLAUSES)
)
u_clause_rng_bank
(
    .i_clk(i_clk),
    .i_reset(i_reset),

    .o_clause_random_bus(o_clause_random_bus)
);

////////////////////////////////////////////////////////////
// Feedback Controller
////////////////////////////////////////////////////////////

feedback_controller u_feedback_controller
(
    .i_y(i_y),

    .i_class0_threshold(o_class0_threshold),
    .i_class1_threshold(o_class1_threshold),

    .i_clause_random_bus(o_clause_random_bus),

    .o_feedback_to_clause(o_feedback_to_clause)
);

endmodule