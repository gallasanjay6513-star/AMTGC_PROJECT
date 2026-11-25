
`timescale 1ns/1ps

module generic_timer_tb;

    reg clk;
    reg rst_n;
    reg start;

    reg [3:0]  target4;
    reg [7:0]  target8;
    reg [11:0] target12;

    wire done4;
    wire done8;
    wire done12;

    // 4-bit Timer
    generic_timer #(
        .COUNTER_WIDTH(4)
    ) timer1 (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .count_target(target4),
        .done(done4)
    );

    // 8-bit Timer
    generic_timer #(
        .COUNTER_WIDTH(8)
    ) timer2 (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .count_target(target8),
        .done(done8)
    );

    // 12-bit Timer
    generic_timer #(
        .COUNTER_WIDTH(12)
    ) timer3 (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .count_target(target12),
        .done(done12)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin

        clk = 0;
        rst_n = 0;
        start = 0;

        target4  = 4'd5;
        target8  = 8'd10;
        target12 = 12'd20;

        #20;
        rst_n = 1;

        #10;
        start = 1;

        #250;
        start = 0;

        #20;
        $finish;

    end

    // Display outputs and internal counters
    initial begin

        $monitor(
            "Time=%0t | Start=%b | Count4=%d Done4=%b | Count8=%d Done8=%b | Count12=%d Done12=%b",
            $time, start,
            timer1.count, done4,
            timer2.count, done8,
            timer3.count, done12
        );

    end

endmodule
