`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/06 14:55:56
// Design Name: 
// Module Name: white_balance
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


module white_balance(
    input clk,
    input freq,
    output ready,
    output reg [1:0]filter_select,
    output reg [31:0]R_time,
    output reg [31:0]G_time,
    output reg [31:0]B_time
    );
parameter MAX_NUM = 255;
reg [31:0] cnt = 0;
reg [31:0] R_cnt = 0;
reg [31:0] G_cnt = 0;
reg [31:0] B_cnt = 0;

always @(posedge clk && !ready)
    begin
        cnt = cnt+1;    
    end 

always @(posedge freq && !ready)
    begin
        if(R_cnt < MAX_NUM)//求红色时间基数
        begin
            R_cnt = R_cnt+1;
            filter_select = 2'b00;
        end
        else if(R_cnt == MAX_NUM)
        begin
            R_cnt = R_cnt+1;
            R_time = cnt;
        end
        else if(G_cnt < MAX_NUM)//求绿色时间基数
        begin
            G_cnt = G_cnt+1;
            filter_select = 2'b11;
        end
        else if(G_cnt == MAX_NUM)
        begin
            G_cnt = G_cnt+1;
            G_time = cnt-R_time;
        end
        else if(B_cnt < MAX_NUM)//求蓝色时间基数
        begin
            B_cnt = B_cnt+1;
            filter_select = 2'b10;
        end
        else if(B_cnt == MAX_NUM)
        begin
            B_cnt = B_cnt+1;
            B_time = cnt-R_time-G_time;
        end                
    end
    
assign ready = (R_cnt>MAX_NUM) && (G_cnt>MAX_NUM) && (B_cnt>MAX_NUM);

endmodule    