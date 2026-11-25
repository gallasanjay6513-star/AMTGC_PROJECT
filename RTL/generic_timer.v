module generic_timer #(
    parameter COUNTER_WIDTH = 8
)
(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [COUNTER_WIDTH-1:0] count_target,
    output reg done
);

    reg [COUNTER_WIDTH-1:0] count;

    always @(posedge clk)
    begin
        if (!rst_n)
        begin
            count <= 0;
            done  <= 0;
        end
        else
        begin
            done <= 0;

            if (start)
            begin
                if (count_target == 0)
                begin
                    count <= 0;
                    done  <= 1;
                end
                else if (count >= count_target - 1'b1)
                begin
                    count <= 0;
                    done  <= 1;
                end
                else
                begin
                    count <= count + 1'b1;
                end
            end
            else
            begin
                count <= 0;
                done  <= 0;
            end
        end
    end

endmodule