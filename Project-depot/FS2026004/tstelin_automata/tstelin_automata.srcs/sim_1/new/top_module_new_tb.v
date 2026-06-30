`timescale 1ns/1ps

module top_module_tb;

reg r_clk;
reg r_reset;

wire [99:0] w_action_out;
wire [9:0]  w_clause_enable;
wire [79:0] w_clause_randoms;

integer r_cycle_count;

//--------------------------------------------------
// DUT
//--------------------------------------------------

topmodule DUT
(
    .i_clk(r_clk),
    .i_reset(r_reset),

    .o_action_out(w_action_out),
    .o_clause_enable(w_clause_enable),
    .o_clause_randoms(w_clause_randoms)
);

//--------------------------------------------------
// Clock Generation
//--------------------------------------------------

always #10 r_clk = ~r_clk;

//--------------------------------------------------
// Monitor
//--------------------------------------------------

always @(posedge r_clk)
begin

    if(!r_reset)
    begin

        r_cycle_count <= r_cycle_count + 1;

        $display("");
        $display("====================================================");
        $display("Cycle = %0d", r_cycle_count);

        $display(
        "C0(R=%0d,E=%0d) C1(R=%0d,E=%0d) C2(R=%0d,E=%0d) C3(R=%0d,E=%0d) C4(R=%0d,E=%0d)",
        w_clause_randoms[7:0],    w_clause_enable[0],
        w_clause_randoms[15:8],   w_clause_enable[1],
        w_clause_randoms[23:16],  w_clause_enable[2],
        w_clause_randoms[31:24],  w_clause_enable[3],
        w_clause_randoms[39:32],  w_clause_enable[4]
        );

        $display(
        "C5(R=%0d,E=%0d) C6(R=%0d,E=%0d) C7(R=%0d,E=%0d) C8(R=%0d,E=%0d) C9(R=%0d,E=%0d)",
        w_clause_randoms[47:40],  w_clause_enable[5],
        w_clause_randoms[55:48],  w_clause_enable[6],
        w_clause_randoms[63:56],  w_clause_enable[7],
        w_clause_randoms[71:64],  w_clause_enable[8],
        w_clause_randoms[79:72],  w_clause_enable[9]
        );

        //--------------------------------------------------
        // Match FPGA Capture Point
        //--------------------------------------------------

        if(r_cycle_count == 20)
        begin

            $display("");
            $display("====================================");
            $display("FINAL CLAUSE ACTIONS");
            $display("====================================");

            $display("Clause0 = %b", w_action_out[9:0]);
            $display("Clause1 = %b", w_action_out[19:10]);
            $display("Clause2 = %b", w_action_out[29:20]);
            $display("Clause3 = %b", w_action_out[39:30]);
            $display("Clause4 = %b", w_action_out[49:40]);

            $display("Clause5 = %b", w_action_out[59:50]);
            $display("Clause6 = %b", w_action_out[69:60]);
            $display("Clause7 = %b", w_action_out[79:70]);
            $display("Clause8 = %b", w_action_out[89:80]);
            $display("Clause9 = %b", w_action_out[99:90]);

            $display("");
            $display("Simulation Complete");
            $display("====================================");

            $finish;

        end

    end

end

//--------------------------------------------------
// Reset
//--------------------------------------------------

initial
begin

    r_clk = 1'b0;
    r_reset = 1'b1;
    r_cycle_count = 0;

    #40;
    r_reset = 1'b0;

end

endmodule