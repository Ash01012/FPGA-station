module reward_penalty_generation
(
    input        i_action,
    input  [7:0] i_random_num,

    output reg o_reward,
    output reg o_penalty
);

localparam [2:0] C1 = 3'd2;
localparam [2:0] C2 = 3'd5;

wire [2:0] w_r;

assign w_r = i_random_num[2:0];

always @(*)
begin

    o_reward  = 1'b0;
    o_penalty = 1'b0;

    if(i_action == 1'b0)
    begin

        if(w_r <= C1)
            o_penalty = 1'b1;

        else if(w_r <= C2)
            o_reward = 1'b1;

    end

    else
    begin

        if(w_r >= C2)
            o_penalty = 1'b1;

        else if(w_r >= C1)
            o_reward = 1'b1;

    end

end

endmodule