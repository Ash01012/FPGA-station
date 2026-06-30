module ta_update_unit #(
    parameter N = 8
)(
    input i_clk,
    input i_reset,

    input i_enable,
    input i_reward,
    input i_penalty,

    output reg [3:0] o_state,
    output o_action
);

localparam INIT_STATE = N - 1;

always @(posedge i_clk or posedge i_reset)
begin

    if(i_reset)
    begin
        o_state <= INIT_STATE;
    end

    else if(i_enable)
    begin

        //---------------------------------
        // Reward
        //---------------------------------
        if(i_reward)
        begin

            if(o_state < N)
            begin
                if(o_state > 0)
                    o_state <= o_state - 1;
            end
            else
            begin
                if(o_state < (2*N-1))
                    o_state <= o_state + 1;
            end

        end

        //---------------------------------
        // Penalty
        //---------------------------------
        else if(i_penalty)
        begin

            if(o_state < N)
            begin
                if(o_state < (2*N-1))
                    o_state <= o_state + 1;
            end
            else
            begin
                if(o_state > N)
                    o_state <= o_state - 1;
            end

        end

    end

end

assign o_action = (o_state >= N);

endmodule