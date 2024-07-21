`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/27 14:11:12
// Design Name: 
// Module Name: vga
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


module vga(
        input vga_clk,//25MHz
        input rst_n,//�͵�ƽ��Ч
        input filter_start,
        input [2:0]color_type,
        input [11:0]pix_data,
        output hs,
        output vs,
       // output wire[9:0]pos_x,//�������꣬sobel��
       // output wire[9:0]pos_y,
        output [11:0] vga_data,//��Чʱͬpix_data��������0
        output [18:0] pix_addr
    );

////////// 640*480 ��ʱ����� //////////
parameter H_SYNC_PULSE = 96,
            H_BACK_PORCH = 48,//ͬ���źŷ����������ĵ���ǹ��ɨ��ʱ��
            H_ACTIVE_TIME = 640,
            H_FRONT_PORCH = 16,
            H_LINE_PERIOD = 800;
            
////////// 640*480 ��ʱ����� //////////
parameter V_SYNC_PULSE = 2,
            V_BACK_PORCH = 33,
            V_ACTIVE_TIME = 480,
            V_FRONT_PORCH = 10,
            V_FRAME_PERIOD = 525;

wire active;
wire [9:0]pos_x;
wire [9:0]pos_y;
wire [11:0]final_data;
reg [11:0] hcnt;
reg [11:0] vcnt;

//////////��ɨ�����//////////
always @(posedge vga_clk or negedge rst_n)
    begin
        if(!rst_n)
            hcnt <= 12'd0;
        else if(hcnt==H_LINE_PERIOD-1'b1)//һ�����
            hcnt <= 12'd0;
        else
            hcnt <= hcnt+1'd1;
    end
assign hs = hcnt<H_SYNC_PULSE?1'b0:1'b1;
    
//////////��ɨ�����//////////
always @(posedge vga_clk or negedge rst_n)
    begin
        if(!rst_n)
            vcnt <=12'd0;
        else if(vcnt==V_FRAME_PERIOD-1'b1)
            vcnt<=12'd0;
        else if(hcnt==H_LINE_PERIOD-1'b1)
            vcnt<=vcnt+1'd1;
        else
            vcnt<=vcnt;
    end
assign vs = vcnt<V_SYNC_PULSE?1'b0:1'b1;
assign active=(hcnt >= (H_SYNC_PULSE + H_BACK_PORCH))  && (hcnt <= (H_SYNC_PULSE + H_BACK_PORCH + H_ACTIVE_TIME))  &&
              (vcnt >= (V_SYNC_PULSE + V_BACK_PORCH ))  &&(vcnt <= (V_SYNC_PULSE + V_BACK_PORCH + V_ACTIVE_TIME));
              
assign vga_data = (rst_n && active)?final_data:12'h0;
assign pix_addr = (rst_n && active)?(hcnt-H_SYNC_PULSE - H_BACK_PORCH+1'b1)+(vcnt-V_SYNC_PULSE - V_BACK_PORCH)*640:19'b0;

assign  pos_x = active?(hcnt-H_SYNC_PULSE-H_BACK_PORCH):10'h3ff;
assign  pos_y = active?(vcnt-V_SYNC_PULSE-V_BACK_PORCH):10'h3ff;

image_process image_process_inst(
    .vga_clk(vga_clk),
    .rst_n(rst_n),
    .process_en(filter_start),
    .rgb_data(pix_data),
    .pos_x(pos_x),
    .pos_y(pos_y),
    .color_type(color_type),
    .final_data(final_data)
);

endmodule
