`timescale 1ns/1ps

module feedback_controller
(
    input i_y,

    input [7:0] i_class0_threshold,
    input [7:0] i_class1_threshold,

    input [159:0] i_clause_random_bus,

    output reg [39:0] o_feedback_to_clause
);

integer i;

reg  [7:0] r_random;

always @(*)
begin

    o_feedback_to_clause = 40'd0;

    //--------------------------------------------------
    // Class 0
    //--------------------------------------------------

    for(i = 0; i < 10; i = i + 1)
    begin

        r_random = i_clause_random_bus[(i*8)+:8];

        if(r_random < i_class0_threshold)
        begin

            if(i_y == 1'b0)
            begin
                if(i < 5)
                    o_feedback_to_clause[(i*2)+:2] = 2'b01;
                else
                    o_feedback_to_clause[(i*2)+:2] = 2'b10;
            end
            else
            begin
                if(i < 5)
                    o_feedback_to_clause[(i*2)+:2] = 2'b10;
                else
                    o_feedback_to_clause[(i*2)+:2] = 2'b01;
            end

        end

    end

    //--------------------------------------------------
    // Class 1
    //--------------------------------------------------

    for(i = 10; i < 20; i = i + 1)
    begin

        r_random = i_clause_random_bus[(i*8)+:8];

        if(r_random < i_class1_threshold)
        begin

            if(i_y == 1'b1)
            begin
                if(i < 15)
                    o_feedback_to_clause[(i*2)+:2] = 2'b01;
                else
                    o_feedback_to_clause[(i*2)+:2] = 2'b10;
            end
            else
            begin
                if(i < 15)
                    o_feedback_to_clause[(i*2)+:2] = 2'b10;
                else
                    o_feedback_to_clause[(i*2)+:2] = 2'b01;
            end

        end

    end

end

endmodule