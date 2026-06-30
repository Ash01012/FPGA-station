
module lfsr_rng
#(
    parameter [7:0] SEED = 8'hA5
)
(
    input i_clk,
    input i_reset,

    output reg [7:0] o_random_num
);

wire w_feedback;

assign w_feedback = o_random_num[7] ^
                    o_random_num[5] ^
                    o_random_num[4] ^
                    o_random_num[3];

always @(posedge i_clk or posedge i_reset)
begin

    if(i_reset)
        o_random_num <= SEED;
    else
        o_random_num <= {o_random_num[6:0], w_feedback};

end

endmodule