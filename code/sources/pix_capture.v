`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/10 19:51:28
// Design Name: 
// Module Name: pix_capture
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


module pix_capture(
    input pclk, 
    input config_done,//�������
    input href,
    input vsync,
    input [7:0]data_in,//8bit
    output [18:0]RAM_addr,
    output reg[11:0]rgb_data,
    output reg data_en//�������ʹ���ź�,���ӻ��л���
);
parameter MAX_COL_NUM = 11'd640;
parameter MAX_ADDR = 19'd307200;

reg [18:0]addr;
reg [11:0]hcnt;
reg [1:0]v_edge;
reg v_valid;//֡��Ч
reg flag;//ƴ�Ӹ�λ/��λ

//////////�ж�vsync�Ƿ���Ч//////////
always @(posedge pclk)
begin
     if (config_done)
    begin
        v_edge <= {v_edge[0], vsync};
        if(v_edge == 2'b01) //��һ֡��ʼ
            v_valid <= 1; 
        else if(v_edge == 2'b10) //��ǰ֡����
            v_valid <= 0;
    end
end

//////////ƴ����������//////////
always @ (posedge pclk)
begin
    if (config_done && v_valid)
    begin
        if ((href == 1'b1) && (vsync == 1'b1) && (hcnt < MAX_COL_NUM)) //��һ��֡���д���
        begin   
            if (!flag)//�����λ
            begin                                    
                rgb_data[11:5] = {data_in[7:4], data_in[2:0]};
                data_en <= 0;
            end
            else//�����λ
            begin                                                 
                rgb_data[4:0] <= {data_in[7], data_in[4:1]};
                addr <=(addr < MAX_ADDR)? (addr + 1'b1):addr;
                hcnt <= hcnt+ 1'b1;
                data_en <= 1'b1;                      
            end
            flag <= ~flag;
        end
        else 
        begin   
            hcnt <=((href == 1'b0) && (vsync == 1'b1))? 0:hcnt;//һ�н��������һ���׼�����ʼ
            flag <= 0;
            data_en <= 0;
        end
    end
    else 
    begin
        hcnt <= 0;
        addr <= 0;
        flag <= 0;
        data_en <= 0;
    end   
end    
assign RAM_addr = addr;

endmodule

