
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

    integer errors;
    integer a_walk_count;
    integer b_walk_count;

    localparam RED   = 2'b00;
    localparam GREEN = 2'b10;

    // DUT Instantiation
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

    // Clock Generation
    always #5 clk = ~clk;

    // Output Monitor
    initial begin
        $monitor(
            "Time=%0t | Emergency=%b | A_NS=%b | A_EW=%b | B_NS=%b | B_EW=%b | A_PED=%b | B_PED=%b",
            $time,
            emergency_override,
            a_ns_light,
            a_ew_light,
            b_ns_light,
            b_ew_light,
            a_ped_walk,
            b_ped_walk
        );
    end

    // Continuous Safety Monitoring
    always @(negedge clk) begin
        if (rst_n) begin

            // Junction A vehicle-light safety
            if (a_ns_light == GREEN && a_ew_light == GREEN) begin
                $display("FAIL: Junction A conflicting GREEN signals");
                errors = errors + 1;
            end

            // Junction B vehicle-light safety
            if (b_ns_light == GREEN && b_ew_light == GREEN) begin
                $display("FAIL: Junction B conflicting GREEN signals");
                errors = errors + 1;
            end

            // Pedestrian WALK exclusivity
            if (a_ped_walk && b_ped_walk) begin
                $display("FAIL: Both pedestrian WALK signals active");
                errors = errors + 1;
            end

            // Count pedestrian service
            if (a_ped_walk)
                a_walk_count = a_walk_count + 1;

            if (b_ped_walk)
                b_walk_count = b_walk_count + 1;

        end
    end

    // Emergency Override Verification
    task check_emergency;
    begin
        emergency_override = 1'b1;

        // Wait for synchronous state update
        @(posedge clk);
        #1;

        if (a_ns_light == RED &&
            a_ew_light == RED &&
            b_ns_light == RED &&
            b_ew_light == RED &&
            a_ped_walk == 1'b0 &&
            b_ped_walk == 1'b0) begin

            $display("PASS: Emergency override - Both junctions ALL RED");

        end
        else begin

            $display("FAIL: Emergency override - Expected ALL RED");
            errors = errors + 1;

        end

        // Keep emergency active briefly
        repeat (3) @(posedge clk);

        #1;

        if (a_ns_light == RED &&
            a_ew_light == RED &&
            b_ns_light == RED &&
            b_ew_light == RED)
            $display("PASS: Both junctions remain ALL RED");
        else begin
            $display("FAIL: Junctions did not remain ALL RED");
            errors = errors + 1;
        end

        emergency_override = 1'b0;
    end
    endtask

    // Main Test Sequence
    initial begin

        clk = 0;
        rst_n = 0;
        emergency_override = 0;

        ped_request_a = 0;
        ped_request_b = 0;

        traffic_density_a = 2'b00;
        traffic_density_b = 2'b00;

        errors = 0;
        a_walk_count = 0;
        b_walk_count = 0;

        $display("------------------------------------");
        $display("AMTGC VERIFICATION STARTED");
        $display("------------------------------------");

        // Reset
        #20;
        rst_n = 1;

        // TEST 1: Traffic Density Inputs
        $display("TEST 1: Traffic Density Inputs");

        traffic_density_a = 2'b00;
        traffic_density_b = 2'b00;
        #100;

        traffic_density_a = 2'b01;
        traffic_density_b = 2'b01;
        #100;

        traffic_density_a = 2'b10;
        traffic_density_b = 2'b10;
        #100;

        traffic_density_a = 2'b11;
        traffic_density_b = 2'b11;
        #100;

        $display("Density input stimulus completed.");
        $display("Green duration measurement requires separate timing checks.");

        // TEST 2: Green-Wave Observation
        $display("TEST 2: Green-Wave Observation");

        #300;

        $display("A_NS=%b | B_NS=%b", a_ns_light, b_ns_light);
        $display("Exact green-wave delay requires separate timing verification.");

        // TEST 3: Simultaneous Pedestrian Requests
        $display("TEST 3: Simultaneous Pedestrian Requests");

        ped_request_a = 1'b1;
        ped_request_b = 1'b1;

        // Allow enough time for both junctions to receive service
        #1500;

        ped_request_a = 1'b0;
        ped_request_b = 1'b0;

        #20;

        $display("A pedestrian WALK samples = %0d", a_walk_count);
        $display("B pedestrian WALK samples = %0d", b_walk_count);

        if (a_walk_count > 0 && b_walk_count > 0)
            $display("PASS: Both junctions received pedestrian service.");
        else begin
            $display("FAIL: Both junctions were not served.");
            errors = errors + 1;
        end

        // TEST 4: Emergency Override
        $display("TEST 4: Emergency Override");

        check_emergency();

        #100;

        // Final Verification Summary
        $display("------------------------------------");
        $display("AMTGC VERIFICATION SUMMARY");
        $display("A pedestrian WALK samples = %0d", a_walk_count);
        $display("B pedestrian WALK samples = %0d", b_walk_count);
        $display("Number of detected errors = %0d", errors);

        if (errors == 0)
            $display("PASS: All implemented checks passed.");
        else
            $display("FAIL: Verification errors detected.");

        $display("------------------------------------");
        $display("AMTGC SIMULATION COMPLETED");

        #20;
        $finish;

    end

endmodule
