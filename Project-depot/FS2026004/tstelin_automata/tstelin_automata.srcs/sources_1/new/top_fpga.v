module top_fpga
(
    input i_CLK100MHZ,
    input i_BTNC,
    input [3:0] i_SW,

    output [15:0] o_LED
);

//--------------------------------------------------
// DUT Signals
//--------------------------------------------------

wire [99:0] w_action_out;
wire [9:0]  w_clause_enable;
wire [79:0] w_clause_randoms;

//--------------------------------------------------
// Clock Divider
//--------------------------------------------------

reg [25:0] r_div_cnt = 26'd0;

always @(posedge i_CLK100MHZ)
begin
    r_div_cnt <= r_div_cnt + 1'b1;
end

// Slow clock for DUT
wire w_slow_clk;

assign w_slow_clk = r_div_cnt[20];

//--------------------------------------------------
// DUT
//--------------------------------------------------

topmodule DUT
(
    .i_clk(w_slow_clk),
    .i_reset(i_BTNC),

    .o_action_out(w_action_out),
    .o_clause_enable(w_clause_enable),
    .o_clause_randoms(w_clause_randoms)
);

//--------------------------------------------------
// Capture FINAL result after 20 cycles
//--------------------------------------------------

reg [99:0] r_final_action_out;
reg [9:0]  r_final_clause_enable;

reg [4:0]  r_cycle_count;
reg         r_capture_done;

always @(posedge w_slow_clk or posedge i_BTNC)
begin

    if(i_BTNC)
    begin

        r_cycle_count         <= 5'd0;
        r_capture_done        <= 1'b0;

        r_final_action_out    <= 100'd0;
        r_final_clause_enable <= 10'd0;

    end

    else
    begin

        if(!r_capture_done)
        begin

            r_cycle_count <= r_cycle_count + 1'b1;

            if(r_cycle_count == 5'd19)
            begin

                r_final_action_out    <= w_action_out;
                r_final_clause_enable <= w_clause_enable;

                r_capture_done <= 1'b1;

            end

        end

    end

end

//--------------------------------------------------
// Select Clause using switches
//--------------------------------------------------

reg [9:0] r_selected_clause;

always @(*)
begin

    case(i_SW)

        4'd0: r_selected_clause = r_final_action_out[9:0];
        4'd1: r_selected_clause = r_final_action_out[19:10];
        4'd2: r_selected_clause = r_final_action_out[29:20];
        4'd3: r_selected_clause = r_final_action_out[39:30];
        4'd4: r_selected_clause = r_final_action_out[49:40];

        4'd5: r_selected_clause = r_final_action_out[59:50];
        4'd6: r_selected_clause = r_final_action_out[69:60];
        4'd7: r_selected_clause = r_final_action_out[79:70];
        4'd8: r_selected_clause = r_final_action_out[89:80];
        4'd9: r_selected_clause = r_final_action_out[99:90];

        default:
            r_selected_clause = 10'b0;

    endcase

end

//--------------------------------------------------
// LEDs
//--------------------------------------------------

assign o_LED[9:0] = r_selected_clause;

assign o_LED[10] =
       (i_SW <= 9) ? r_final_clause_enable[i_SW] : 1'b0;

assign o_LED[14:11] = i_SW;

assign o_LED[15] = r_capture_done;

//--------------------------------------------------
// ILA
//--------------------------------------------------

ila_0 ILA_INST
(
    .clk(i_CLK100MHZ),

    .probe0(r_final_action_out[9:0]),
    .probe1(r_final_action_out[19:10]),
    .probe2(r_final_action_out[29:20]),
    .probe3(r_final_action_out[39:30]),
    .probe4(r_final_action_out[49:40]),

    .probe5(r_final_action_out[59:50]),
    .probe6(r_final_action_out[69:60]),
    .probe7(r_final_action_out[79:70]),
    .probe8(r_final_action_out[89:80]),
    .probe9(r_final_action_out[99:90]),

    .probe10(r_final_clause_enable),
    .probe11(r_cycle_count),
    .probe12(r_capture_done)
);

endmodule