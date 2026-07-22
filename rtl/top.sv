module top (

    input  logic CLOCK_50,
    input  logic [1:0] KEY,

    output logic VGA_HS,
    output logic VGA_VS,
    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B

);

    logic [9:0] pixel_x;
    logic [9:0] pixel_y;
    logic video_on;

    // VGA timing generator
    vga_controller vga_inst (

        .clk(CLOCK_50),
        .reset(~KEY[0]),

        .hsync(VGA_HS),
        .vsync(VGA_VS),

        .pixel_x(pixel_x),
        .pixel_y(pixel_y),

        .video_on(video_on)

    );

    // Temporary display
    assign VGA_R = video_on ? 4'hF : 4'h0;
    assign VGA_G = 4'h0;
    assign VGA_B = 4'h0;

endmodule