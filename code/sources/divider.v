`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/12 11:33:01
// Design Name: 
// Module Name: divider
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


module divider(
    input I_CLK,//输入时钟信号，上升沿有效
    input rst,//同步复位信号，高电平有效
    output reg O_CLK//输出时钟
);
integer i = 0;//计数器
parameter multiple = 1000;

always @ (posedge I_CLK)
begin
    if (rst)
        begin
        i <= 0;
        O_CLK <= 0;
        end
    else if (i >= multiple)
        begin
        i <= 1;
        O_CLK <= ~O_CLK;
        end
    else
        begin
        i <= i + 1;
        end
end
endmodule
