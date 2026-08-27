`timescale 1ns/1ps

module pong_tb;

    logic clk;
    logic reset;
    logic enable;

    logic [9:0] ball_x;
    logic [9:0] ball_y;

    logic [9:0] paddle_left_y;
    logic [9:0] paddle_right_y;


    // Clock generation
    always begin
        #10 clk = ~clk;
    end

    // Connect Pong Engine
    pong_engine DUT (

        .clk(clk),
        .reset(reset),
        .enable(enable),

        .ball_x(ball_x),
        .ball_y(ball_y),

        .paddle_left_y(paddle_left_y),
        .paddle_right_y(paddle_right_y)

    );

    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        enable = 0;


        // Hold reset
        #100;

        reset = 0;


        //Enable game updates
        enable = 1;


        // Run simulation
        #1000;


        $finish;

    end

endmodule