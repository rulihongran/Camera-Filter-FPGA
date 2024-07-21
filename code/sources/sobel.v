`timescale 1ns / 1ps
`include "D:\DigitalLogicCircuit\VivadoProject\BigHW_2022_fall\BigHW_2022_fall.srcs\sources_1\new\params.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/01 21:18:09
// Design Name: 
// Module Name: sobel
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


module sobel(
    input vga_clk,
    input rst_n,
    input [2:0]color_type,
    input wire [9:0] pos_x,
    input wire [9:0] pos_y,
    input wire [7:0] gray,
    output reg [11:0] sobel_out
    );
parameter THRESHOLD = 4'b0100;
parameter COL_NUM = 650;
//parameter COLOR_BLACK = 3'b001; 

wire [23:0] gray_data;
wire [3:0]color_foreground;
wire [3:0]color_background;

assign gray_data = {gray,gray,gray};
assign color_foreground = (color_type == `COLOR_BLACK)?4'hf:4'h0;
assign color_background = (color_type == `COLOR_BLACK)?4'h0:4'hf;

reg state;//idle
reg [7:0] line_buf0[COL_NUM-1:0];
reg [7:0] line_buf1[COL_NUM-1:0];
reg [7:0] p0;
reg [7:0] p1;
reg [7:0] p2;
reg [9:0] conv_out;
reg [3:0] tmp;
initial state = 0;

//////////state/////////
always @(posedge vga_clk)
begin
    case(state)
    1'b0:
    begin
        line_buf0[pos_x] <= gray;
        line_buf1[pos_x] <= line_buf1[pos_x];
        p2 <= gray;
        p1 <= p2;
        p0 <= p1;
        if(pos_x>=2 && pos_y>=3)
        begin
            if((p0 + p1*2 + p2)>(line_buf0[pos_x-2] + line_buf0[pos_x-1]*2 + line_buf0[pos_x]))
                conv_out <= (p0 + p1*2 + p2) - (line_buf0[pos_x-2] + line_buf0[pos_x-1]*2 + line_buf0[pos_x]);
            else
                conv_out <= (line_buf0[pos_x-2] + line_buf0[pos_x-1]*2 + line_buf0[pos_x]) - (p0 + p1*2 + p2);
        end
    end
   /* 1'b1:
    begin
        line_buf1[pos_x] <= gray;
        line_buf0[pos_x] <= line_buf0[pos_x];
        p2 <= gray;
        p1 <= p2;
        p0 <= p1;
        if(pos_x>=2 && pos_y>=3)
        begin
            if((p0 + p1*2 + p2)>(line_buf1[pos_x-2] + line_buf1[pos_x-1]*2 + line_buf1[pos_x]))
                conv_out <= (p0 + p1*2 + p2) - (line_buf1[pos_x-2] + line_buf1[pos_x-1]*2 + line_buf1[pos_x]);
            else
                conv_out <= (line_buf1[pos_x-2] + line_buf1[pos_x-1]*2 + line_buf1[pos_x]) - (p0 + p1*2 + p2);
        end
    end
    default:
    begin
        conv_out <= conv_out;
        line_buf0[pos_x] <= line_buf0[pos_x];
        line_buf1[pos_x] <= line_buf1[pos_x];
    end*/
    endcase
end
//========comparison threshold======
always @(posedge vga_clk)
begin
    tmp = (conv_out[5:2]>THRESHOLD)?color_foreground:color_background;
    sobel_out = {tmp,tmp,tmp};
end   
endmodule

