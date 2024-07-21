`timescale 1ns / 1ps
`include "D:\DigitalLogicCircuit\VivadoProject\BigHW_2022_fall\BigHW_2022_fall.srcs\sources_1\new\params.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/06 19:36:04
// Design Name: 
// Module Name: color_sensor_top
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


module color_sensor(
    input clk,
    input freq,
    output led,
    output [1:0] filter_out,
    output [1:0] freq_rate,
    output reg [2:0]color_type
    );

assign freq_rate = 2'b01;//�����������2%
assign led = 1'b1;

wire [31:0] R_time;  //��ɫ��Ӧ��ʱ�����
wire [31:0] G_time;  //��ɫ��Ӧ��ʱ�����
wire [31:0] B_time;  //��ɫ��Ӧ��ʱ�����

wire [1:0]filter_balance;
wire [1:0]filter_identify;

wire [9:0] red;
wire [9:0] green;
wire [9:0] blue;

wire ready;
wire finish;

////////// ���а�ƽ�� //////////
white_balance white_balance_inst(
    .clk(clk),
    .freq(freq),
    .ready(ready),
    .R_time(R_time),
    .G_time(G_time),
    .B_time(B_time),
    .filter_select(filter_balance)
);

////////// ��ȡRGBֵ //////////
color_identify color_identify_inst(
    .clk(clk),
    .freq(freq),
    .ready(ready),
    .R_time(R_time),
    .G_time(G_time),
    .B_time(B_time),
    .red(red),
    .green(green),
    .blue(blue),
    .filter_select(filter_identify),
    .finish(finish)
);

assign filter_out = ready ? filter_identify :filter_balance;

////////// ȷ����ɫ��� //////////
always @(finish)
    begin
        if (!ready)
            color_type = 3'b111;
        else if(red<60 && green<60 && blue<60)//��
            color_type = `COLOR_BLACK;
        else if(red>180 && green>180 && blue>180)//��
            color_type = `COLOR_WHITE;
        else if(red>green && red>blue)//��
            color_type = `COLOR_RED;
        else if(green>red && green>blue)//��
            color_type = `COLOR_GREEN;
        else if(blue>red && blue>green)//��
            color_type = `COLOR_BLUE;
        else
            color_type = 3'b000;    
    end 

endmodule

