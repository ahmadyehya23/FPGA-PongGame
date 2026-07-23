module pong_engine (

    input logic clk,
    input logic reset,
    input logic enable,

    output logic [9:0] ball_x,
    output logic [9:0] ball_y,

    output logic [9:0] paddle_left_y,
    output logic [9:0] paddle_right_y

);


    // Ball movement direction
    logic ball_dx;
    logic ball_dy;


    // Screen dimensions
    parameter SCREEN_WIDTH  = 640;
    parameter SCREEN_HEIGHT = 480;


    // Paddle size
    parameter PADDLE_HEIGHT = 80;


    always_ff @(posedge clk or posedge reset) begin

        if (reset) begin

            // Start ball in center
            ball_x <= 320;
            ball_y <= 240;

            // Start paddles centered
            paddle_left_y  <= 200;
            paddle_right_y <= 200;


            // Initial direction
            ball_dx <= 1;
            ball_dy <= 1;

        end


        else if (enable) begin


            // Move ball horizontally
            if (ball_dx)
                ball_x <= ball_x + 1;

            else
                ball_x <= ball_x - 1;



            // Move ball vertically
            if (ball_dy)
                ball_y <= ball_y + 1;

            else
                ball_y <= ball_y - 1;



            // Bounce off top wall

            if (ball_y <= 0)
                ball_dy <= 1;



            // Bounce off bottom wall

            if (ball_y >= SCREEN_HEIGHT-1)
                ball_dy <= 0;



            // Bounce left/right walls temporarily

            if (ball_x <= 0)
                ball_dx <= 1;


            if (ball_x >= SCREEN_WIDTH-1)
                ball_dx <= 0;


        end


    end


endmodule