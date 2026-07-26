module vga_controller (
    input logic clk,
    input logic reset,

    output logic hsync,
    output logic vsync,

    output logic [9:0] pixel_x,
    output logic [9:0] pixel_y,

    output logic video_on
);

    // VGA 640x480 @ 60Hz timing
    // Horizontal timing
    parameter H_VISIBLE = 640;
    parameter H_FRONT   = 16;
    parameter H_SYNC    = 96;
    parameter H_BACK    = 48;

    parameter H_TOTAL = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;


    // Vertical timing
    parameter V_VISIBLE = 480;
    parameter V_FRONT   = 10;
    parameter V_SYNC    = 2;
    parameter V_BACK    = 33;

    parameter V_TOTAL = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;


    logic [9:0] h_count;
    logic [9:0] v_count;


    // Horizontal and vertical counters
    always_ff @(posedge clk or posedge reset) begin

        if (reset) begin
            h_count <= 0;
            v_count <= 0;
        end

        else begin

            if (h_count == H_TOTAL-1) begin
                h_count <= 0;

                if (v_count == V_TOTAL-1)
                    v_count <= 0;

                else
                    v_count <= v_count + 1;

            end

            else begin
            h_count <= h_count + 1;
            end

        end
    end


    // Current pixel location
    assign pixel_x = h_count;
    assign pixel_y = v_count;


    // Active drawing area
    assign video_on =
        (h_count < H_VISIBLE) &&
        (v_count < V_VISIBLE);


    // VGA sync pulses are active low
    assign hsync =
        ~((h_count >= H_VISIBLE + H_FRONT) &&
          (h_count < H_VISIBLE + H_FRONT + H_SYNC));


    assign vsync =
        ~((v_count >= V_VISIBLE + V_FRONT) &&
          (v_count < V_VISIBLE + V_FRONT + V_SYNC));


endmodule

