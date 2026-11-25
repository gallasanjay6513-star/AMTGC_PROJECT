
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

    localparam RED    = 2'b00;
    localparam YELLOW = 2'b01;
    localparam GREEN  = 2'b10;

    integer errors;
    integer a_walk_count;
    integer b_walk_count;

    // DUT
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

    // Clock: 10 ns period
    always #5 clk = ~clk;

    // Monitor
    initial begin
        $monitor(
            "Time=%0t | Emergency=%b | A_NS=%b | A_EW=%b | B_NS=%b | B_EW=%b | A_PED=%b | B_PED=%b",
            $time, emergency_override,
            a_ns_light, a_ew_light,
            b_ns_light, b_ew_light,
            a_ped_walk, b_ped_walk
        );
    end

    // Safety checks and pedestrian counting
    always @(negedge clk) begin
        if (rst_n) begin

            if (a_ns_light == GREEN && a_ew_light == GREEN) begin
                $display("FAIL: Junction A conflicting GREEN lights");
                errors = errors + 1;
            end

            if (b_ns_light == GREEN && b_ew_light == GREEN) begin
                $display("FAIL: Junction B conflicting GREEN lights");
                errors = errors + 1;
            end

            if (a_ped_walk && b_ped_walk) begin
                $display("FAIL: Simultaneous pedestrian WALK");
                errors = errors + 1;
            end

            if (a_ped_walk)
                a_walk_count = a_walk_count + 1;

            if (b_ped_walk)
                b_walk_count = b_walk_count + 1;

            if (dut.ped_grant_a && dut.ped_grant_b) begin
                $display("FAIL: Both pedestrian grants active");
                errors = errors + 1;
            end
        end
    end

    // Reset task
    task reset_system;
        begin
            rst_n = 0;
            emergency_override = 0;
            ped_request_a = 0;
            ped_request_b = 0;
            traffic_density_a = 2'b00;
            traffic_density_b = 2'b00;

            repeat (2) @(negedge clk);
            rst_n = 1;
            @(negedge clk);
        end
    endtask

    // Adaptive green-duration measurement
    task measure_green_duration;
        input [1:0] density;
        input integer expected_cycles;

        integer measured_cycles;

        begin
            reset_system();

            traffic_density_a = density;
            traffic_density_b = density;

            // Wait for A NS GREEN
            wait (a_ns_light == GREEN);

            measured_cycles = 0;

            while (a_ns_light == GREEN) begin
                @(posedge clk);
                #1;

                if (a_ns_light == GREEN)
                    measured_cycles = measured_cycles + 1;
            end

            $display("------------------------------------");
            $display("Density = %b", density);
            $display("Expected GREEN cycles = %0d", expected_cycles);
            $display("Measured GREEN cycles = %0d", measured_cycles);

            if (measured_cycles == expected_cycles)
                $display("PASS: Adaptive GREEN duration");
            else begin
                $display("FAIL: Adaptive GREEN duration");
                errors = errors + 1;
            end
        end
    endtask

    // Green-wave measurement
    task measure_green_wave;
        time a_green_time;
        time b_green_time;
        integer delay_cycles;
        integer timeout_count;

        begin
            reset_system();

            traffic_density_a = 2'b00;
            traffic_density_b = 2'b00;

            timeout_count = 0;

            // Wait for A NS GREEN
            wait (a_ns_light == GREEN);
            a_green_time = $time;

            // Wait for B NS GREEN, with timeout
            while (b_ns_light != GREEN && timeout_count < 100) begin
                @(posedge clk);
                #1;
                timeout_count = timeout_count + 1;
            end

            if (b_ns_light == GREEN) begin
                b_green_time = $time;
                delay_cycles = (b_green_time - a_green_time) / 10;

                $display("------------------------------------");
                $display("GREEN-WAVE TIMING RESULTS");
                $display("Junction A NS GREEN time = %0t", a_green_time);
                $display("Junction B NS GREEN time = %0t", b_green_time);
                $display("Measured Green-Wave Delay = %0d clock cycles",
                         delay_cycles);

                if (delay_cycles == 3)
                    $display("PASS: Green-Wave Delay");
                else begin
                    $display("FAIL: Green-Wave Delay does not match 3 cycles");
                    errors = errors + 1;
                end
            end
            else begin
                $display("FAIL: Junction B NS GREEN timeout");
                errors = errors + 1;
            end
        end
    endtask

    // TEST 5: Repeated pedestrian requests - No starvation
    task repeated_pedestrian_test;

        integer round;
        integer timeout_count;
        integer a_before;
        integer b_before;

        begin
            reset_system();

            $display("------------------------------------");
            $display("TEST 5: Repeated Pedestrian Requests");

            for (round = 1; round <= 3; round = round + 1) begin

                a_before = a_walk_count;
                b_before = b_walk_count;

                // Send simultaneous requests
                @(negedge clk);
                ped_request_a = 1'b1;
                ped_request_b = 1'b1;

                // Release request inputs
                @(negedge clk);
                ped_request_a = 1'b0;
                ped_request_b = 1'b0;

                // Wait for both junctions to receive WALK
                timeout_count = 0;

                while ((a_walk_count == a_before ||
                        b_walk_count == b_before) &&
                       timeout_count < 300) begin

                    @(negedge clk);
                    timeout_count = timeout_count + 1;
                end

                if (a_walk_count > a_before &&
                    b_walk_count > b_before) begin

                    $display("PASS: Round %0d - Both junctions received service",
                             round);
                end
                else begin

                    $display("FAIL: Round %0d - Service timeout",
                             round);
                    errors = errors + 1;
                end

                // Wait for both pedestrian requests to be cleared
                timeout_count = 0;

                while ((dut.junction_a.ped_req_out ||
                        dut.junction_b.ped_req_out) &&
                       timeout_count < 300) begin

                    @(negedge clk);
                    timeout_count = timeout_count + 1;
                end

                if (timeout_count >= 300) begin
                    $display("FAIL: Round %0d - Pedestrian phase did not complete",
                             round);
                    errors = errors + 1;
                end

                repeat (2) @(negedge clk);
            end

            $display("Repeated pedestrian request test completed.");

        end
    endtask

    // Main test sequence
    initial begin

        clk = 0;
        rst_n = 0;
        emergency_override = 0;
        ped_request_a = 0;
        ped_request_b = 0;
        traffic_density_a = 0;
        traffic_density_b = 0;

        errors = 0;
        a_walk_count = 0;
        b_walk_count = 0;

        $display("------------------------------------");
        $display("AMTGC VERIFICATION STARTED");
        $display("------------------------------------");

        // TEST 0: Adaptive green duration
        $display("TEST 0: Adaptive Green Duration");

        measure_green_duration(2'b00, 5);
        measure_green_duration(2'b01, 10);
        measure_green_duration(2'b10, 15);
        measure_green_duration(2'b11, 20);

        // TEST 1: Green-wave timing
        $display("TEST 1: Green-Wave Timing");

        measure_green_wave();

        // TEST 2: Traffic density inputs
        $display("TEST 2: Traffic Density Inputs");

        reset_system();

        traffic_density_a = 2'b00;
        traffic_density_b = 2'b01;
        #100;

        traffic_density_a = 2'b10;
        traffic_density_b = 2'b11;
        #100;

        traffic_density_a = 2'b11;
        traffic_density_b = 2'b00;
        #100;

        $display("Traffic density input stimulus completed.");

        // TEST 3: Simultaneous pedestrian requests
        $display("TEST 3: Simultaneous Pedestrian Requests");

        reset_system();

        ped_request_a = 1;
        ped_request_b = 1;

        #1500;

        ped_request_a = 0;
        ped_request_b = 0;

        #500;

        $display("A pedestrian WALK samples = %0d", a_walk_count);
        $display("B pedestrian WALK samples = %0d", b_walk_count);

        if (a_walk_count > 0 && b_walk_count > 0)
            $display("PASS: Both junctions received pedestrian service.");
        else begin
            $display("FAIL: Pedestrian service missing.");
            errors = errors + 1;
        end

        // TEST 4: Emergency override
        $display("TEST 4: Emergency Override");

        reset_system();

        // Wait until at least one junction has a GREEN light
        wait (a_ns_light == GREEN || b_ns_light == GREEN);

        emergency_override = 1'b1;

        // Wait for sequential logic to update
        @(posedge clk);
        #1;

        if (a_ns_light == RED &&
            a_ew_light == RED &&
            b_ns_light == RED &&
            b_ew_light == RED &&
            a_ped_walk == 0 &&
            b_ped_walk == 0) begin

            $display("PASS: Emergency override - ALL RED");
        end
        else begin
            $display("FAIL: Emergency override - Expected ALL RED");
            errors = errors + 1;
        end

        // Verify ALL RED remains active
        repeat (3) begin
            @(posedge clk);
            #1;

            if (a_ns_light != RED ||
                a_ew_light != RED ||
                b_ns_light != RED ||
                b_ew_light != RED ||
                a_ped_walk != 0 ||
                b_ped_walk != 0) begin

                $display("FAIL: Emergency ALL RED condition not maintained");
                errors = errors + 1;
            end
        end

        if (a_ns_light == RED &&
            a_ew_light == RED &&
            b_ns_light == RED &&
            b_ew_light == RED)
            $display("PASS: Both junctions remain ALL RED");

        emergency_override = 0;

        repeat (2) @(posedge clk);

        // TEST 5: Repeated pedestrian requests
        repeated_pedestrian_test();

        // Final summary
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

        #10;
delete wave *
add wave -r sim:/amtgc_top_tb/*        $finish;
    end

endmodule
