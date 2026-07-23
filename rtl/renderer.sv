module renderer (

    input  logic [9:0] pixel_x,
    input  logic [9:0] pixel_y,

    input  logic [9:0] ball_x,
    input  logic [9:0] ball_y,

    input  logic [9:0] paddle_left_y,
    input  logic [9:0] paddle_right_y,

    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue

);

    parameter BALL_SIZE = 10;

    parameter PADDLE_WIDTH  = 10;
    parameter PADDLE_HEIGHT = 80;

    always_comb begin

        // Default background
        red   = 4'h0;
        green = 4'h0;
        blue  = 4'h0;


        // Draw left paddle
        if (pixel_x >= 20 &&
            pixel_x < 20 + PADDLE_WIDTH &&
            pixel_y >= paddle_left_y &&
            pixel_y < paddle_left_y + PADDLE_HEIGHT)

        begin
            red   = 4'hF;
            green = 4'hF;
            blue  = 4'hF;
        end


        // Draw right paddle
        else if (pixel_x >= 610 &&
                 pixel_x < 610 + PADDLE_WIDTH &&
                 pixel_y >= paddle_right_y &&
                 pixel_y < paddle_right_y + PADDLE_HEIGHT)

        begin
            red   = 4'hF;
            green = 4'hF;
            blue  = 4'hF;
        end


        // Draw ball
        else if (pixel_x >= ball_x &&
                 pixel_x < ball_x + BALL_SIZE &&
                 pixel_y >= ball_y &&
                 pixel_y < ball_y + BALL_SIZE)

        begin
            red   = 4'hF;
            green = 4'hF;
            blue  = 4'hF;
        end

    end

endmodule