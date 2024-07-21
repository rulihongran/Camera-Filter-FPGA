`timescale 1ns / 1ps
`include "D:\DigitalLogicCircuit\VivadoProject\BigHW_2022_fall\BigHW_2022_fall.srcs\sources_1\new\params.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/10 20:53:37
// Design Name: 
// Module Name: image_process
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module image_process(
    input vga_clk,
    input rst_n,
    input process_en,
    input [11:0]rgb_data,
    input [9:0]pos_x,
    input [9:0]pos_y,
    input [2:0]color_type,
    output reg[11:0] final_data
    );

wire [11:0]sobel_data;
wire [7:0]gray;

rgb_to_gray rgb2gray_inst(
    .clk(vga_clk),
    .rst_n(rst_n),
    .rgb_data(rgb_data),
    .data_out(gray)
    );
    
sobel sobel_inst(
    .vga_clk(vga_clk),
    .rst_n(rst_n),
    .color_type(color_type),
    .pos_x(pos_x),
    .pos_y(pos_y),
    .gray(gray),
    .sobel_out(sobel_data)
);

wire [2:0]mode = process_en?color_type:`COLOR_INIT;

always @(*)
begin
    case(mode)
    `COLOR_BLACK,`COLOR_WHITE:
        final_data <= sobel_data;
    `COLOR_RED:
        final_data <= {gray[7:4],4'b0,4'b0};
    `COLOR_GREEN:
        final_data <= {4'b0,gray[7:4],4'b0};
    `COLOR_BLUE:
        final_data <= {4'b0,4'b0,gray[7:4]};
    default:
        final_data <= rgb_data;
    endcase
end
endmodule
