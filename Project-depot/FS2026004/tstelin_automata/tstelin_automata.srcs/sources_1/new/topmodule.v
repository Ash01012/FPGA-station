module topmodule
(
    input i_clk,
    input i_reset,

    output [99:0] o_action_out,
    output [9:0]  o_clause_enable,
    output [79:0] o_clause_randoms
);

wire [7:0] w_clause_random [0:9];

genvar c;

generate

for(c = 0; c < 10; c = c + 1)
begin : CLAUSE_BANK

    clause #(
        .NUM_TA(10),
        .CLAUSE_SEED(8'hAA + (c * 13))
    )
    CLAUSE
    (
        .i_clk(i_clk),
        .i_reset(i_reset),

        .o_action_out(
            o_action_out[(c+1)*10-1:c*10]
        ),

        .o_clause_enable(
            o_clause_enable[c]
        ),

        .o_clause_random(
            w_clause_random[c]
        )
    );

    assign o_clause_randoms[(c+1)*8-1:c*8]
           = w_clause_random[c];

end

endgenerate

endmodule