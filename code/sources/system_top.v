`timescale 1ns / 1ps
`include "D:\DigitalLogicCircuit\VivadoProject\BigHW_2022_fall\BigHW_2022_fall.srcs\sources_1\new\params.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/10 20:07:33
// Design Name: 
// Module Name: system_top
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


module system_top(
       input clk,//100Mhz
       input rst_n,
       input filter_start,//开启滤镜
       input pause,
       //摄像头
       input pclk,
       input camera_href,
       input camera_vsync,
       input[7:0]camera_data_in,//摄像头传入的图像信息
       inout siod,
       output sioc,
       output xclk,
       output camera_rst,//摄像头的reset
       output pwdn,//power_down
       output [7:0]camera_data_led,//摄像头的数据，检查摄像头是否正常工作
       output write_en,
       //VGA
       output vga_hs,//行时序
       output vga_vs,//列时序
       output[3:0]red,
       output[3:0]green,
       output[3:0]blue,
       //颜色传感器
       input freq,
       output color_sensor_led,
       output [1:0] filter_out,
       output [1:0] freq_rate,
       output [2:0]color_type,
       //7段数码管
       output [6:0]tube_data,//数码管显示
       output [7:0]bit_ctrl//位控
    );

wire clk_10MHz;
wire clk_25MHz;
wire [2:0]word_disp;
//wire [2:0]color_type;
//wire write_en;
wire[9:0]pos_x;
wire[9:0]pos_y;
wire [11:0]vga_data;
wire [11:0]RAM_data_in;
wire [11:0]RAM_data_out;
wire [18:0]RAM_write_addr;
wire [18:0]RAM_read_addr;

assign camera_data_led = camera_data_in;
assign word_disp = (filter_start?color_type:`COLOR_INIT);

clk_gen clk_gen_inst(
    .clk_in1(clk),
    .reset(!rst_n),
    .clk_out1(clk_10MHz),
    .clk_out2(xclk),
    .clk_out3(clk_25MHz)
);

color_sensor color_sensor_inst(
    .clk(clk),
    .freq(freq),
    .led(color_sensor_led),
    .filter_out(filter_out),
    .freq_rate(freq_rate),
    .color_type(color_type)
);

camera camera_inst(
    .clk_10MHz(clk_10MHz),
    .rst_n(rst_n),
    .siod(siod),
    .sioc(sioc),
    .href(camera_href),
    .vsync(camera_vsync),
    .pclk(pclk),
    .camera_data(camera_data_in),
    .camera_rst(camera_rst),//复位
    .pwdn(pwdn),//省电
    .write_en(write_en),
    .rgb_data(RAM_data_in),
    .RAM_addr(RAM_write_addr)
);

SDRAM SDRAM_inst(
    .clka(pclk),//写
    .ena(!pause),//暂停
    .wea(write_en), 
    .addra(RAM_write_addr),
    .dina(RAM_data_in), 
    .clkb(clk_25MHz),//读
    .enb(1'b1), 
    .addrb(RAM_read_addr), 
    .doutb(RAM_data_out)
);

display7_color_type display7_inst(
    .clk(clk), 
    .color_type(word_disp),
    .tube_data(tube_data), 
    .bit_ctrl(bit_ctrl)
);

vga vga_inst(
    .vga_clk(clk_25MHz),
    .rst_n(rst_n),
    .filter_start(filter_start),
    .color_type(color_type),
    .pix_data(RAM_data_out),
    .hs(vga_hs),
    .vs(vga_vs),
    .vga_data({red,green,blue}),
    .pix_addr(RAM_read_addr)
);


endmodule
