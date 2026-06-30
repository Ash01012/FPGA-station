module clause #(
    parameter NUM_TA = 10,
    parameter CLAUSE_SEED = 8'h80
)(
    input i_clk,
    input i_reset,

    output [NUM_TA-1:0] o_action_out,
    output o_clause_enable,
    output [7:0] o_clause_random
);

//--------------------------------------------------
// Clause Random Generator
//--------------------------------------------------

random_generation #(
    .SEED(CLAUSE_SEED)
)
CLAUSE_RNG
(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_random_num(o_clause_random)
);

//--------------------------------------------------
// Clause Participation
//--------------------------------------------------

assign o_clause_enable = (o_clause_random > 8'd4);

//--------------------------------------------------
// TA Array
//--------------------------------------------------

genvar i;

generate

for(i=0; i<NUM_TA; i=i+1)
begin : TA_ARRAY

    wire [7:0] w_random_num;
    wire w_reward;
    wire w_penalty;
    wire [3:0] w_state;

    //--------------------------------------------------
    // Random Number Generator
    //--------------------------------------------------

    random_generation #(
        .SEED(CLAUSE_SEED + i + 1)
    )
    RNG
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_random_num(w_random_num)
    );

    //--------------------------------------------------
    // Reward/Penalty Generation
    //--------------------------------------------------

    reward_penalty_generation ENV
    (
        .i_action(o_action_out[i]),
        .i_random_num(w_random_num),

        .o_reward(w_reward),
        .o_penalty(w_penalty)
    );

    //--------------------------------------------------
    // Tsetlin Automaton
    //--------------------------------------------------

    ta_update_unit #(
        .N(8)
    )
    TA
    (
        .i_clk(i_clk),
        .i_reset(i_reset),

        .i_enable(o_clause_enable),

        .i_reward(w_reward),
        .i_penalty(w_penalty),

        .o_state(w_state),
        .o_action(o_action_out[i])
    );

end

endgenerate

endmodule

