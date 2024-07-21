`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/06 18:45:14
// Design Name: 
// Module Name: color_identify
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


module color_identify(
    input clk,
    input freq,
    input ready,//白平衡完成
    input [31:0] R_time,
    input [31:0] G_time,
    input [31:0] B_time,
    output reg [9:0] red,
    output reg [9:0] green,
    output reg [9:0] blue,
    output reg [1:0] filter_select,
    output finish//颜色识别完成
    );
    
reg [31:0]cnt = 0;  
reg [9:0] R_cnt = 0;
reg [9:0] G_cnt = 0;
reg [9:0] B_cnt = 0;
reg reset = 0;

always @(posedge clk && ready)
    begin
        if(!reset)
            cnt = cnt+1;    
        else
           cnt = 0;
    end

always @(posedge freq && ready)
    begin
        if(cnt==0)//进行初始化
        begin
            R_cnt = 0;
            G_cnt = 0;
            B_cnt = 0;
            reset = 0;
       end
       else if(cnt < R_time)
       begin
            filter_select = 2'b00;
            R_cnt = R_cnt+1;
       end      
       else if(cnt >= R_time && cnt < R_time + G_time)     
       begin
            filter_select = 2'b11;
            G_cnt = G_cnt+1;
       end
       else if(cnt >= R_time + G_time && cnt < R_time + G_time + B_time)
       begin
            filter_select = 2'b10;
            B_cnt = B_cnt+1;
       end
       else 
       begin
            red = R_cnt;
            green = G_cnt;
            blue = B_cnt;
            reset = 1;
       end
   end    

assign finish = (cnt >= R_time + G_time + B_time)?1:0;    

endmodule
