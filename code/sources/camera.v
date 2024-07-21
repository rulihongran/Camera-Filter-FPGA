`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/10 19:53:37
// Design Name: 
// Module Name: camera
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


module camera(
    input clk_10MHz,//SCCB协议使用时钟
    input rst_n,//复位
    inout siod,//sccb数据，双向
    input href,//行有效信号输出
    input vsync,//场同步信号
    input pclk,//像素时钟
    input [7:0]camera_data,//8bit数据
    output camera_rst,//复位
    output pwdn,//省电
    output sioc,//SCCB时钟
    output write_en,
    output [11:0]rgb_data, 
    output [18:0]RAM_addr
);   
parameter SLAVE_ID = 8'h60;//从机ID

wire [15:0]write_data;//读取配置数据线
wire [7:0]reg_order;
wire cfg_done;

assign camera_rst = 1;
assign pwdn = 0;//省电

sccb_ctrl sccb_ctrl_inst(
    .clk_10MHz(clk_10MHz), 
    .rst_n(rst_n), 
    .sioc(sioc), 
    .siod(siod), 
    .reg_order(reg_order),
    .wire_data({SLAVE_ID, write_data[15:0]}),
    .config_done(cfg_done) 
);

reg_config reg_config_inst(
    .reg_order(reg_order), 
    .data_out(write_data)
);

pix_capture pix_capture_inst( 
        .pclk(pclk),
        .config_done(cfg_done),
        .href(href), 
        .vsync(vsync), 
        .data_in(camera_data), 
        .rgb_data(rgb_data), 
        .RAM_addr(RAM_addr),
        .data_en(write_en)
);

endmodule
