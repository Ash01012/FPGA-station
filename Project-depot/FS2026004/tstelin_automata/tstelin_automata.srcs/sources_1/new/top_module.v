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

// 20 ns Clock Period
always #10 clk = ~clk;

always @(posedge clk)
begin

    cycle_count <= cycle_count + 1;

    $display("");
    $display("================================================");

    $display(
    "Cycle=%0d",
    cycle_count
    );

    $display(
    "C0(R=%0d,E=%0d) C1(R=%0d,E=%0d) C2(R=%0d,E=%0d) C3(R=%0d,E=%0d) C4(R=%0d,E=%0d)",
    clause_randoms[2:0],   clause_enable[0],
    clause_randoms[5:3],   clause_enable[1],
    clause_randoms[8:6],   clause_enable[2],
    clause_randoms[11:9],  clause_enable[3],
    clause_randoms[14:12], clause_enable[4]
    );

    $display(
    "C5(R=%0d,E=%0d) C6(R=%0d,E=%0d) C7(R=%0d,E=%0d) C8(R=%0d,E=%0d) C9(R=%0d,E=%0d)",
    clause_randoms[17:15], clause_enable[5],
    clause_randoms[20:18], clause_enable[6],
    clause_randoms[23:21], clause_enable[7],
    clause_randoms[26:24], clause_enable[8],
    clause_randoms[29:27], clause_enable[9]
    );

    if(cycle_count == 20)
    begin

        $display("");
        $display("====================================");
        $display("FINAL CLAUSE ACTIONS");
        $display("====================================");

        $display("Clause0 = %b", action_out[9:0]);
        $display("Clause1 = %b", action_out[19:10]);
        $display("Clause2 = %b", action_out[29:20]);
        $display("Clause3 = %b", action_out[39:30]);
        $display("Clause4 = %b", action_out[49:40]);
        $display("Clause5 = %b", action_out[59:50]);
        $display("Clause6 = %b", action_out[69:60]);
        $display("Clause7 = %b", action_out[79:70]);
        $display("Clause8 = %b", action_out[89:80]);
        $display("Clause9 = %b", action_out[99:90]);

        $display("");
        $display("Simulation Complete");
        $display("====================================");

        $finish;

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
