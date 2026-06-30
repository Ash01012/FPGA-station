`timescale 1ns/1ps

module clause_block
#(
    parameter NUM_CLAUSES  = 20,
    parameter NUM_LITERALS = 24
)
(
    input  [NUM_LITERALS-1:0] i_literals,

    // 20 clauses × 24 include bits = 480 bits
    input  [NUM_CLAUSES*NUM_LITERALS-1:0] i_include_mask,

    output [NUM_CLAUSES-1:0] o_clause_output
);

genvar i;

generate

    for(i = 0; i < NUM_CLAUSES; i = i + 1)
    begin : CLAUSE_ARRAY

        clause_module u_clause_module
        (
            .i_literals(i_literals),

            .i_include_mask(
                i_include_mask[(i+1)*NUM_LITERALS-1 :
                               i*NUM_LITERALS]
            ),

            .o_clause_output(o_clause_output[i])
        );

    end

endgenerate

endmodule
