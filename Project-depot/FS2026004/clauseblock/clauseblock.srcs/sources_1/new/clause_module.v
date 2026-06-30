`timescale 1ns/1ps

module clause_module
#(
    parameter NUM_LITERALS = 24
)
(
    input  [NUM_LITERALS-1:0] i_literals,
    input  [NUM_LITERALS-1:0] i_include_mask,

    output reg o_clause_output
);

integer i;
reg r_any_include;

always @(*)
begin

    //------------------------------------------------
    // Assume Clause is TRUE
    //------------------------------------------------

    o_clause_output = 1'b1;

    //------------------------------------------------
    // Track whether at least one literal is included
    //------------------------------------------------

    r_any_include = 1'b0;

    //------------------------------------------------
    // Check all literals
    //------------------------------------------------

    for(i = 0; i < NUM_LITERALS; i = i + 1)
    begin

        if(i_include_mask[i])
        begin

            r_any_include = 1'b1;

            // If any included literal is FALSE,
            // clause becomes FALSE

            if(i_literals[i] == 1'b0)
                o_clause_output = 1'b0;

        end

    end

    //------------------------------------------------
    // Empty Clause is FALSE
    //------------------------------------------------

    if(r_any_include == 1'b0)
        o_clause_output = 1'b0;

end

endmodule