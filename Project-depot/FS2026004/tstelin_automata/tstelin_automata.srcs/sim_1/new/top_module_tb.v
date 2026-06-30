`timescale 1ns/1ps

module top_module_tb;

reg clk;
reg reset;

wire [99:0] action_out;
wire [9:0] clause_enable;
wire [29:0] clause_randoms;

integer cycle_count;

top_module DUT(
    .clk(clk),
    .reset(reset),
    .action_out(action_out),
    .clause_enable(clause_enable),
    .clause_randoms(clause_randoms)
);

// 100 MHz Clock
always #5 clk = ~clk;

// Cycle Counter
always @(posedge clk)
begin

    $display(
    "Cycle=%0d | C0(R=%0d,E=%0d) C1(R=%0d,E=%0d) C2(R=%0d,E=%0d) C3(R=%0d,E=%0d) C4(R=%0d,E=%0d)",
    cycle_count,
    clause_randoms[2:0],   clause_enable[0],
    clause_randoms[5:3],   clause_enable[1],
    clause_randoms[8:6],   clause_enable[2],
    clause_randoms[11:9],  clause_enable[3],
    clause_randoms[14:12], clause_enable[4]
    );

    $display(
    "           C5(R=%0d,E=%0d) C6(R=%0d,E=%0d) C7(R=%0d,E=%0d) C8(R=%0d,E=%0d) C9(R=%0d,E=%0d)",
    clause_randoms[17:15], clause_enable[5],
    clause_randoms[20:18], clause_enable[6],
    clause_randoms[23:21], clause_enable[7],
    clause_randoms[26:24], clause_enable[8],
    clause_randoms[29:27], clause_enable[9]
    );

end

end

initial
begin

    clk = 0;
    reset = 1;
    cycle_count = 0;

    #20;
    reset = 0;

end

endmodule
