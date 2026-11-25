
module ped_arbiter (
    input wire clk,
    input wire rst_n,

    input wire req_a,
    input wire req_b,

    output reg grant_a,
    output reg grant_b
);

    reg busy;
    reg owner;
    reg last_served;

    // owner: 0 = Junction A, 1 = Junction B
    // last_served: 0 = A, 1 = B

    always @(posedge clk) begin

        if (!rst_n) begin
            busy       <= 1'b0;
            owner      <= 1'b0;
            last_served <= 1'b1;
            grant_a    <= 1'b0;
            grant_b    <= 1'b0;
        end

        else begin

            if (!busy) begin

                grant_a <= 1'b0;
                grant_b <= 1'b0;

                // Both junctions request simultaneously
                if (req_a && req_b) begin
                    busy <= 1'b1;

                    if (last_served == 1'b1) begin
                        owner   <= 1'b0;
                        grant_a <= 1'b1;
                    end
                    else begin
                        owner   <= 1'b1;
                        grant_b <= 1'b1;
                    end
                end

                // Only Junction A requests
                else if (req_a) begin
                    busy    <= 1'b1;
                    owner   <= 1'b0;
                    grant_a <= 1'b1;
                end

                // Only Junction B requests
                else if (req_b) begin
                    busy    <= 1'b1;
                    owner   <= 1'b1;
                    grant_b <= 1'b1;
                end
            end

            // Junction A currently receiving grant
            else if (owner == 1'b0) begin

                if (req_a) begin
                    grant_a <= 1'b1;
                    grant_b <= 1'b0;
                end
                else begin
                    busy       <= 1'b0;
                    grant_a    <= 1'b0;
                    grant_b    <= 1'b0;
                    last_served <= 1'b0;
                end
            end

            // Junction B currently receiving grant
            else begin

                if (req_b) begin
                    grant_a <= 1'b0;
                    grant_b <= 1'b1;
                end
                else begin
                    busy       <= 1'b0;
                    grant_a    <= 1'b0;
                    grant_b    <= 1'b0;
                    last_served <= 1'b1;
                end
            end
        end
    end

endmodule
