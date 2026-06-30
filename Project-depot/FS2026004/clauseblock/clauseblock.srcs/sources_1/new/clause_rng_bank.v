`timescale 1ns/1ps

module clause_rng_bank
#(
    parameter NUM_CLAUSES = 20
)
(
    input i_clk,
    input i_reset,

    output [NUM_CLAUSES*8-1:0] o_clause_random_bus
);

genvar i;

generate

for(i = 0; i < NUM_CLAUSES; i = i + 1)
begin : RNG_ARRAY

    wire [7:0] w_random_num;

    lfsr_rng
    #(
        .SEED(8'hA5 + i)
    )
    u_lfsr_rng
    (
        .i_clk(i_clk),
        .i_reset(i_reset),

        .o_random_num(w_random_num)
    );

    assign o_clause_random_bus[(i*8)+7 : (i*8)] = w_random_num;

end

endgenerate

endmodule