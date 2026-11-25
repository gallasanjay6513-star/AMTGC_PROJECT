
`timescale 1ns/1ps

module junction_controller_tb;

    // Testbench inputs
    reg clk;
    reg rst_n;
    reg emergency_override;
    reg ped_request;
    reg ped_grant;
    reg ns_start_enable;

    // Testbench outputs
    wire ped_req_out;
    wire ped_walk;
    wire ns_green_start;
    wire [1:0] ns_light;
    wire [1:0] ew_light;

    // Instantiate Junction Controller
    junction_controller #(
        .COUNTER_WIDTH(8),
        .GREEN_TIME(10),
        .YELLOW_TIME(3),
        .RED_TIME(2),
        .PED_TIME(5)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .emergency_override(emergency_override),
        .ped_request(ped_request),
        .ped_grant(ped_grant),
        .ns_start_enable(ns_start_enable),
        .ped_req_out(ped_req_out),
        .ped_walk(ped_walk),
        .ns_green_start(ns_green_start),
        .ns_light(ns_light),
        .ew_light(ew_light)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin

        // Initial values
        clk = 0;
        rst_n = 0;
        emergency_override = 0;
        ped_request = 0;
        ped_grant = 0;
        ns_start_enable = 1;

        // Reset
        #20;
        rst_n = 1;

        // Normal traffic operation
        #100;

        // Pedestrian request
        ped_request = 1;
        #10;
        ped_request = 0;

        // Hold grant until controller reaches pedestrian phase
        ped_grant = 1;
        #400;
        ped_grant = 0;

        // Allow pedestrian phase to complete
        #100;

        // Emergency test
        emergency_override = 1;
        #20;
        emergency_override = 0;

        // Continue normal operation
        #100;

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor(
            "Time=%0t | rst_n=%b | NS=%b | EW=%b | PED=%b | PED_GRANT=%b | Emergency=%b",
            $time,
            rst_n,
            ns_light,
            ew_light,
            ped_walk,
            ped_grant,
            emergency_override
        );
    end

endmodule
