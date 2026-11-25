
`timescale 1ns/1ps

module ped_arbiter_tb;

    reg clk;
    reg rst_n;
    reg req_a;
    reg req_b;

    wire grant_a;
    wire grant_b;

    ped_arbiter dut (
        .clk(clk),
        .rst_n(rst_n),
        .req_a(req_a),
        .req_b(req_b),
        .grant_a(grant_a),
        .grant_b(grant_b)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst_n = 0;
        req_a = 0;
        req_b = 0;

        #20;
        rst_n = 1;

        // Test 1: Junction A request
        #10;
        req_a = 1;
        #20;
        req_a = 0;

        // Test 2: Junction B request
        #30;
        req_b = 1;
        #20;
        req_b = 0;

        // Test 3: Both request simultaneously
        #30;
        req_a = 1;
        req_b = 1;

        #20;
        req_a = 0;

        #30;
        req_b = 0;

        // Test 4: Both request again
        #30;
        req_a = 1;
        req_b = 1;

        #20;
        req_b = 0;

        #30;
        req_a = 0;

        #30;
        $finish;

    end

    initial begin
        $monitor("Time=%0t A_req=%b B_req=%b A_grant=%b B_grant=%b",
                  $time, req_a, req_b, grant_a, grant_b);
    end

endmodule
