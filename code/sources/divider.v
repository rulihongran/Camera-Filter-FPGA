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
    input I_CLK,//����ʱ���źţ���������Ч
    input rst,//ͬ����λ�źţ��ߵ�ƽ��Ч
    output reg O_CLK//���ʱ��
);
integer i = 0;//������
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
