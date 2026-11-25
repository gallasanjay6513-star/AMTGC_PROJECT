
module amtgc_top #(
    parameter COUNTER_WIDTH    = 8,
    parameter GREEN_TIME       = 10,
    parameter YELLOW_TIME      = 3,
    parameter RED_TIME         = 2,
    parameter PED_TIME         = 5,
    parameter GREEN_WAVE_DELAY = 3
)
(
    input wire clk,
    input wire rst_n,
    input wire emergency_override,

    input wire ped_request_a,
    input wire ped_request_b,

    input wire [1:0] traffic_density_a,
    input wire [1:0] traffic_density_b,

    output wire [1:0] a_ns_light,
    output wire [1:0] a_ew_light,
    output wire [1:0] b_ns_light,
    output wire [1:0] b_ew_light,

    output wire a_ped_walk,
    output wire b_ped_walk
);

    // Pedestrian request and grant signals
    wire ped_req_a;
    wire ped_req_b;

    wire ped_grant_a;
    wire ped_grant_b;

    // Green-wave signals
    wire a_ns_green_start;

    reg [COUNTER_WIDTH-1:0] green_wave_count;
    reg green_wave_active;

    wire b_ns_start_enable;

    // Junction A
    junction_controller #(
        .COUNTER_WIDTH(COUNTER_WIDTH),
        .GREEN_TIME(GREEN_TIME),
        .YELLOW_TIME(YELLOW_TIME),
        .RED_TIME(RED_TIME),
        .PED_TIME(PED_TIME)
    ) junction_a (
        .clk(clk),
        .rst_n(rst_n),
        .emergency_override(emergency_override),

        .ped_request(ped_request_a),
        .ped_grant(ped_grant_a),
        .ns_start_enable(1'b1),
        .traffic_density(traffic_density_a),

        .ped_req_out(ped_req_a),
        .ped_walk(a_ped_walk),
        .ns_green_start(a_ns_green_start),

        .ns_light(a_ns_light),
        .ew_light(a_ew_light)
    );

    // Junction B
    junction_controller #(
        .COUNTER_WIDTH(COUNTER_WIDTH),
        .GREEN_TIME(GREEN_TIME),
        .YELLOW_TIME(YELLOW_TIME),
        .RED_TIME(RED_TIME),
        .PED_TIME(PED_TIME)
    ) junction_b (
        .clk(clk),
        .rst_n(rst_n),
        .emergency_override(emergency_override),

        .ped_request(ped_request_b),
        .ped_grant(ped_grant_b),
        .ns_start_enable(b_ns_start_enable),
        .traffic_density(traffic_density_b),

        .ped_req_out(ped_req_b),
        .ped_walk(b_ped_walk),
        .ns_green_start(),

        .ns_light(b_ns_light),
        .ew_light(b_ew_light)
    );

    // Shared pedestrian arbiter
    ped_arbiter pedestrian_arbiter (
        .clk(clk),
        .rst_n(rst_n),

        .req_a(ped_req_a),
        .req_b(ped_req_b),

        .grant_a(ped_grant_a),
        .grant_b(ped_grant_b)
    );

    // B is enabled only after the configured delay.
    // It must still satisfy its own ALL-RED clearance.
    assign b_ns_start_enable =
        green_wave_active &&
        (green_wave_count >= GREEN_WAVE_DELAY - 1);

    // Green-wave counter and control
    always @(posedge clk) begin

        if (!rst_n) begin
            green_wave_count  <= 0;
            green_wave_active <= 1'b0;
        end

        else if (emergency_override) begin
            green_wave_count  <= 0;
            green_wave_active <= 1'b0;
        end

        else begin

            // Start timing when A enters NS GREEN
            if (a_ns_green_start && !green_wave_active) begin
                green_wave_count  <= 0;
                green_wave_active <= 1'b1;
            end

            // Count the configured delay
            else if (green_wave_active &&
                     green_wave_count < GREEN_WAVE_DELAY - 1) begin

                green_wave_count <= green_wave_count + 1'b1;
            end

            // Stop after B actually enters NS GREEN
            else if (green_wave_active &&
                     b_ns_light == 2'b10) begin

                green_wave_count  <= 0;
                green_wave_active <= 1'b0;
            end
        end
    end

endmodule
