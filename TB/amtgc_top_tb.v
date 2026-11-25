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

    integer error_count;
    integer a_grant_count;
    integer b_grant_count;
    integer i;
    time a_ns_start_time;
    time b_ns_start_time;
    time green_start_t;
    time green_dur_low;
    time green_dur_high;

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

    // Clock Generation (10 ns period)
    always #5 clk = ~clk;

    // Continuous Safety Checks (Runs on every clock edge)
    always @(posedge clk) begin
        if (rst_n) begin
            // 1. Conflicting green lights must never occur simultaneously
            if (a_ns_light == 2'b10 && a_ew_light == 2'b10) begin
                $display("FAIL [Time=%0t]: Junction A conflicting NS and EW greens!", $time);
                error_count = error_count + 1;
            end
            if (b_ns_light == 2'b10 && b_ew_light == 2'b10) begin
                $display("FAIL [Time=%0t]: Junction B conflicting NS and EW greens!", $time);
                error_count = error_count + 1;
            end

            // 2. Pedestrian walk safety: walk must only occur when vehicle lights are ALL-RED (2'b00)
            if (a_ped_walk && (a_ns_light != 2'b00 || a_ew_light != 2'b00)) begin
                $display("FAIL [Time=%0t]: Junction A pedestrian walk active during non-red vehicle signal!", $time);
                error_count = error_count + 1;
            end
            if (b_ped_walk && (b_ns_light != 2'b00 || b_ew_light != 2'b00)) begin
                $display("FAIL [Time=%0t]: Junction B pedestrian walk active during non-red vehicle signal!", $time);
                error_count = error_count + 1;
            end

            // 3. Simultaneous pedestrian walk check
            if (a_ped_walk && b_ped_walk) begin
                $display("FAIL [Time=%0t]: Both pedestrian walks active simultaneously!", $time);
                error_count = error_count + 1;
            end
        end
    end

    // Pedestrian Grant Fairness Counters
    always @(posedge a_ped_walk) begin
        a_grant_count = a_grant_count + 1;
    end

    always @(posedge b_ped_walk) begin
        b_grant_count = b_grant_count + 1;
    end

    // Task 1: Green-Wave Delay Check
    task check_green_wave;
        begin
            wait (a_ns_light == 2'b10);
            a_ns_start_time = $time;
            wait (b_ns_light == 2'b10);
            b_ns_start_time = $time;
            if (b_ns_start_time > a_ns_start_time) begin
                $display("PASS [Time=%0t]: Green-wave delay verified (Offset = %0t ns)", $time, (b_ns_start_time - a_ns_start_time));
            end else begin
                $display("FAIL [Time=%0t]: Green-wave delay failed", $time);
                error_count = error_count + 1;
            end
        end
    endtask

    // Task 2: Emergency Override Check
    task check_emergency;
        begin
            emergency_override = 1'b1;
            repeat (2) @(posedge clk);
            #1;
            if (a_ns_light == 2'b00 && a_ew_light == 2'b00 &&
                b_ns_light == 2'b00 && b_ew_light == 2'b00 &&
                !a_ped_walk && !b_ped_walk) begin
                $display("PASS [Time=%0t]: Emergency override - Both junctions ALL RED", $time);
            end else begin
                $display("FAIL [Time=%0t]: Emergency override failed to force ALL RED", $time);
                error_count = error_count + 1;
            end
        end
    endtask

    // Test Stimulus
    initial begin
        clk = 0;
        rst_n = 0;
        emergency_override = 0;
        ped_request_a = 0;
        ped_request_b = 0;
        traffic_density_a = 2'b00;
        traffic_density_b = 2'b00;
        error_count = 0;
        a_grant_count = 0;
        b_grant_count = 0;

        $display("=== AMTGC Self-Checking Simulation Started ===");

        #20;
        rst_n = 1;

        // 1. Verify Green-Wave Synchronization
        check_green_wave();

        // 2. Measure Low Density (00) Green Duration
        traffic_density_a = 2'b00;
        traffic_density_b = 2'b00;
        wait (a_ns_light != 2'b10);
        wait (a_ns_light == 2'b10);
        green_start_t = $time;
        wait (a_ns_light != 2'b10);
        green_dur_low = $time - green_start_t;
        $display("INFO [Time=%0t]: Density 00 Green Duration = %0t ns", $time, green_dur_low);

        // Sweep Density 01 and 10
        traffic_density_a = 2'b01;
        traffic_density_b = 2'b01;
        #150;
        traffic_density_a = 2'b10;
        traffic_density_b = 2'b10;
        #200;

        // 3. Measure High Density (11) Green Duration & Compare
        traffic_density_a = 2'b11;
        traffic_density_b = 2'b11;
        wait (a_ns_light != 2'b10);
        wait (a_ns_light == 2'b10);
        green_start_t = $time;
        wait (a_ns_light != 2'b10);
        green_dur_high = $time - green_start_t;
        $display("INFO [Time=%0t]: Density 11 Green Duration = %0t ns", $time, green_dur_high);

        if (green_dur_high > green_dur_low) begin
            $display("PASS [Time=%0t]: Adaptive timing verified (High=%0t ns > Low=%0t ns)", $time, green_dur_high, green_dur_low);
        end else begin
            $display("FAIL [Time=%0t]: Adaptive timing did not increase green duration", $time);
            error_count = error_count + 1;
        end

        // 4. Pedestrian Fairness Check across Repeated Simultaneous Requests
        for (i = 0; i < 6; i = i + 1) begin
            ped_request_a = 1'b1;
            ped_request_b = 1'b1;
            #250;
            ped_request_a = 1'b0;
            ped_request_b = 1'b0;
            #50;
        end

        if (a_grant_count > 0 && b_grant_count > 0) begin
            $display("PASS [Time=%0t]: Pedestrian fairness verified (A grants=%0d, B grants=%0d)", $time, a_grant_count, b_grant_count);
        end else begin
            $display("FAIL [Time=%0t]: Pedestrian starvation detected (A grants=%0d, B grants=%0d)", $time, a_grant_count, b_grant_count);
            error_count = error_count + 1;
        end

        // 5. Emergency Override Check
        #100;
        check_emergency();
        #50;
        emergency_override = 1'b0;

        #150;

        // Final Self-Checking Summary
        $display("=== Simulation Summary ===");
        if (error_count == 0) begin
            $display("PASS: All checks passed with 0 errors!");
        end else begin
            $display("FAIL: Simulation completed with %0d error(s).", error_count);
        end

        $finish;
    end

    // Monitor Outputs
    initial begin
        $monitor(
            "Time=%0t | Reset=%b | Emergency=%b | Density_A=%b | Density_B=%b | A_NS=%b | A_EW=%b | B_NS=%b | B_EW=%b | A_PED=%b | B_PED=%b",
            $time,
            rst_n,
            emergency_override,
            traffic_density_a,
            traffic_density_b,
            a_ns_light,
            a_ew_light,
            b_ns_light,
            b_ew_light,
            a_ped_walk,
            b_ped_walk
        );
    end

endmodule
