module random_generation #(
    parameter SEED = 8'hAC // change this seed value AC for generating different numbers while running multiple times 
)(
    input i_clk,
    input i_reset,

    output [7:0] o_random_num
);

reg [7:0] r_lfsr;

always @(posedge i_clk or posedge i_reset)
begin

    if(i_reset)
        r_lfsr <= SEED;

    else
        r_lfsr <= {
                    r_lfsr[6:0],
                    r_lfsr[7] ^
                    r_lfsr[5] ^
                    r_lfsr[4] ^
                    r_lfsr[3]
                  };

end

assign o_random_num = r_lfsr;

endmodule 