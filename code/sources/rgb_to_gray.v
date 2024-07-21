`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/01 21:15:31
// Design Name: 
// Module Name: rgb_to_gray
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
module rgb_to_gray(
input clk,
input rst_n,
input [11:0] rgb_data,
output [7:0] data_out
    );
reg [15:0] R;//8
reg [15:0] G;
reg [15:0] B;
reg [15:0]gray_temp;

always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
		R <= 16'd0;
		G <= 16'd0; 	
	    B <= 16'd0;
	end
	else begin
		R <= {rgb_data[11:8],4'd0}*16'd76;//0.299*256
		G <= {rgb_data[7:4],4'd0}*16'd150;
        B <= {rgb_data[3:0],4'd0}*16'd29;
	end

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		gray_temp <= 16'd0;
	else 
		gray_temp <= R + G + B;

assign data_out = gray_temp>>16'd8;
endmodule

