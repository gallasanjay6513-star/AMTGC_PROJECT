
`timescale 1ns/1ps

module amtgc_top_tb;

    reg clk;
    reg rst_n;
    reg emergency_override;

    reg ped_request_a;
    reg ped_request_b;

    reg [1:0] traffic_density_a;
    reg [1:0] traffic_density_b;

    wire [1:0] a_ns_light;
    wire [1:0] a_ew_light;
    wire [1:0] b_ns_light;
    wire [1:0] b_ew_light;

    wire a_ped_walk;
    wire b_ped_walk;

    // DUT: Design Under Test

    amtgc_top #(
        .COUNTER_WIDTH(8),
        .GREEN_TIME(10),
        .YELLOW_TIME(3),
        .RED_TIME(2),
        .PED_TIME(5),
        .GREEN_WAVE_DELAY(3)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .emergency_override(emergency_override),

        .ped_request_a(ped_request_a),
        .ped_request_b(ped_request_b),

        .traffic_density_a(traffic_density_a),
        .traffic_density_b(traffic_density_b),

        .a_ns_light(a_ns_light),
        .a_ew_light(a_ew_light),
        .b_ns_light(b_ns_light),
        .b_ew_light(b_ew_light),

        .a_ped_walk(a_ped_walk),
        .b_ped_walk(b_ped_walk)
    );

    // Clock generation: 10 ns period

    always #5 clk = ~clk;

    // Test sequence

    initial begin

        clk = 0;
        rst_n = 0;
        emergency_override = 0;

        ped_request_a = 0;
        ped_request_b = 0;

        traffic_density_a = 2'b01;
        traffic_density_b = 2'b10;

        $display("AMTGC Integration Simulation Started");

        // Reset

        #20;
        rst_n = 1;

        // Normal traffic operation

        #150;

        // Simultaneous pedestrian requests

        ped_request_a = 1;
        ped_request_b = 1;

        #100;

        ped_request_a = 0;
        ped_request_b = 0;

        // Allow pedestrian service

        #200;

        // Emergency test

        emergency_override = 1;

        #50;

        emergency_override = 0;

        // Resume normal operation

        #200;

        $display("AMTGC Integration Simulation Completed");

        $finish;

    end

    // Monitor outputs

    initial begin

        $monitor(
            "Time=%0t | Reset=%b | Emergency=%b | A_NS=%b | A_EW=%b | B_NS=%b | B_EW=%b | A_PED=%b | B_PED=%b",
            $time,
            rst_n,
            emergency_override,
            a_ns_light,
            a_ew_light,
            b_ns_light,
            b_ew_light,
            a_ped_walk,
            b_ped_walk
        );

    end

endmodule
