module top (

    input logic CLOCK_50,
    input logic [1:0] KEY,

    output logic VGA_HS,
    output logic VGA_VS,

    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B

);


    // =========================
    // Internal signals
    // =========================

    logic reset;

    logic game_enable;

    logic [9:0] pixel_x;
    logic [9:0] pixel_y;

    logic video_on;


    logic [9:0] ball_x;
    logic [9:0] ball_y;

    logic [9:0] paddle_left_y;
    logic [9:0] paddle_right_y;



    assign reset = ~KEY[0];



    // =========================
    // VGA Controller
    // =========================

    vga_controller vga_inst (

        .clk(CLOCK_50),
        .reset(reset),

        .hsync(VGA_HS),
        .vsync(VGA_VS),

        .pixel_x(pixel_x),
        .pixel_y(pixel_y),

        .video_on(video_on)

    );



    // =========================
    // Game clock enable
    // =========================

    clock_enable clock_inst (

        .clk(CLOCK_50),
        .reset(reset),

        .enable(game_enable)

    );



    // =========================
    // Pong Engine
    // =========================

    pong_engine game_inst (

        .clk(CLOCK_50),
        .reset(reset),
        .enable(game_enable),

        .ball_x(ball_x),
        .ball_y(ball_y),

        .paddle_left_y(paddle_left_y),
        .paddle_right_y(paddle_right_y)

    );



    // =========================
    // Renderer
    // =========================

    renderer render_inst (

        .pixel_x(pixel_x),
        .pixel_y(pixel_y),

        .ball_x(ball_x),
        .ball_y(ball_y),

        .paddle_left_y(paddle_left_y),
        .paddle_right_y(paddle_right_y),

        .red(VGA_R),
        .green(VGA_G),
        .blue(VGA_B)

    );


endmodule