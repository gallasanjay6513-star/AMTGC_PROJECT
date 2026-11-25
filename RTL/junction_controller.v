
module junction_controller #(
    parameter COUNTER_WIDTH = 8,
    parameter GREEN_TIME    = 10,
    parameter YELLOW_TIME   = 3,
    parameter RED_TIME      = 2,
    parameter PED_TIME      = 5
)
(
    input wire clk,
    input wire rst_n,
    input wire emergency_override,
    input wire ped_request,
    input wire ped_grant,
    input wire ns_start_enable,
    input wire [1:0] traffic_density,

    output reg ped_req_out,
    output reg ped_walk,
    output reg ns_green_start,
    output reg [1:0] ns_light,
    output reg [1:0] ew_light
);

    localparam RED    = 2'b00;
    localparam YELLOW = 2'b01;
    localparam GREEN  = 2'b10;

    localparam NS_GREEN  = 4'd0;
    localparam NS_YELLOW = 4'd1;
    localparam ALL_RED_1 = 4'd2;
    localparam EW_GREEN  = 4'd3;
    localparam EW_YELLOW = 4'd4;
    localparam ALL_RED_2 = 4'd5;
    localparam PED_PHASE = 4'd6;
    localparam EMERGENCY = 4'd7;

    reg [3:0] state;
    reg [3:0] next_state;

    reg [COUNTER_WIDTH-1:0] adaptive_green_time;

    reg timer_start;
    reg [COUNTER_WIDTH-1:0] timer_target;
    wire timer_done;
    reg timer_pause;

    reg ped_pending;
    reg ped_request_seen;
    reg red_elapsed;

    // Adaptive green time selection
    always @(*) begin
        case (traffic_density)
            2'b00: adaptive_green_time = 5;
            2'b01: adaptive_green_time = 10;
            2'b10: adaptive_green_time = 15;
            2'b11: adaptive_green_time = 20;
            default: adaptive_green_time = GREEN_TIME;
        endcase
    end

    // Keep the arbiter request active until pedestrian service completes
    always @(*) begin
        ped_req_out = ped_pending;
    end

    // Generic timer
    generic_timer #(
        .COUNTER_WIDTH(COUNTER_WIDTH)
    ) timer_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start(timer_start),
        .count_target(timer_target),
        .done(timer_done)
    );

    // Timer control
    always @(*) begin
        timer_start  = 1'b0;
        timer_target = 0;

        case (state)
            NS_GREEN: begin
                timer_start  = 1'b1;
                timer_target = adaptive_green_time;
            end

            NS_YELLOW: begin
                timer_start  = 1'b1;
                timer_target = YELLOW_TIME;
            end

            ALL_RED_1: begin
                timer_start  = 1'b1;
                timer_target = RED_TIME;
            end

            EW_GREEN: begin
                timer_start  = 1'b1;
                timer_target = adaptive_green_time;
            end

            EW_YELLOW: begin
                timer_start  = 1'b1;
                timer_target = YELLOW_TIME;
            end

            ALL_RED_2: begin
                timer_start  = 1'b1;
                timer_target = RED_TIME;
            end

            PED_PHASE: begin
                timer_start  = 1'b1;
                timer_target = PED_TIME;
            end

            default: begin
                timer_start  = 1'b0;
                timer_target = 0;
            end
        endcase

        if (timer_pause)
            timer_start = 1'b0;
    end

    // Next-state logic
    always @(*) begin
        next_state = state;

        if (emergency_override) begin
            next_state = EMERGENCY;
        end
        else begin
            case (state)
                NS_GREEN:
                    if (timer_done)
                        next_state = NS_YELLOW;

                NS_YELLOW:
                    if (timer_done)
                        next_state = ALL_RED_1;

                ALL_RED_1:
                    if (timer_done)
                        next_state = EW_GREEN;

                EW_GREEN:
                    if (timer_done)
                        next_state = EW_YELLOW;

                EW_YELLOW:
                    if (timer_done)
                        next_state = ALL_RED_2;

                ALL_RED_2: begin
                    if (red_elapsed && ped_pending && ped_grant)
                        next_state = PED_PHASE;
                    else if (red_elapsed && ns_start_enable)
                        next_state = NS_GREEN;
                end

                PED_PHASE:
                    if (timer_done)
                        next_state = ALL_RED_2;

                EMERGENCY:
                    next_state = ALL_RED_2;

                default:
                    next_state = ALL_RED_2;
            endcase
        end
    end

    // Sequential logic
    always @(posedge clk) begin
        if (!rst_n) begin
            state           <= ALL_RED_2;
            ped_pending     <= 1'b0;
            ped_request_seen <= 1'b0;
            ns_green_start  <= 1'b0;
            timer_pause     <= 1'b0;
            red_elapsed     <= 1'b0;
        end
        else begin
            state <= next_state;
            ns_green_start <= 1'b0;

            // Detect a new request only once while input stays high
            if (!ped_request)
                ped_request_seen <= 1'b0;
            else if (!ped_request_seen)
                ped_request_seen <= 1'b1;

            // Latch a new pedestrian request
            if (ped_request && !ped_request_seen)
                ped_pending <= 1'b1;

            // Clear request only after the pedestrian phase finishes
            if (state == PED_PHASE && timer_done)
                ped_pending <= 1'b0;

            // Timer pause control
            if (state == EMERGENCY)
                timer_pause <= 1'b0;
            else if (timer_done)
                timer_pause <= 1'b1;
            else if (timer_pause)
                timer_pause <= 1'b0;

            // Red timer completion
            if (next_state == ALL_RED_2 && state != ALL_RED_2)
                red_elapsed <= 1'b0;
            else if (state == ALL_RED_2 && timer_done)
                red_elapsed <= 1'b1;

            // Green-wave start indication
            if (next_state == NS_GREEN && state != NS_GREEN)
                ns_green_start <= 1'b1;
        end
    end

    // Traffic light outputs
    always @(*) begin
        ns_light = RED;
        ew_light = RED;
        ped_walk = 1'b0;

        case (state)
            NS_GREEN: begin
                ns_light = GREEN;
                ew_light = RED;
            end

            NS_YELLOW: begin
                ns_light = YELLOW;
                ew_light = RED;
            end

            ALL_RED_1: begin
                ns_light = RED;
                ew_light = RED;
            end

            EW_GREEN: begin
                ns_light = RED;
                ew_light = GREEN;
            end

            EW_YELLOW: begin
                ns_light = RED;
                ew_light = YELLOW;
            end

            ALL_RED_2: begin
                ns_light = RED;
                ew_light = RED;
            end

            PED_PHASE: begin
                ns_light = RED;
                ew_light = RED;
                ped_walk = 1'b1;
            end

            EMERGENCY: begin
                ns_light = RED;
                ew_light = RED;
                ped_walk = 1'b0;
            end

            default: begin
                ns_light = RED;
                ew_light = RED;
                ped_walk = 1'b0;
            end
        endcase
    end

endmodule
