`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/07 15:31:43
// Design Name: 
// Module Name: sccb
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


module sccb_ctrl(
    input clk_10MHz,//10MHz
    input rst_n,
    input [23:0]wire_data,//{�ӻ�ID, �Ĵ�����ַ���Ĵ�������}
    inout siod,   
    output sioc,
    output reg[7:0]reg_order,//��ǰ���õļĴ�����ţ����ǼĴ����ĵ�ַ���������ã�
    output config_done//�����Ƿ����
 );   
    
parameter REG_NUM = 179;
parameter DELAY_NUM = 100000;//10ms
parameter WAIT_NUM = 1000;
parameter ST_IDLE = 5'd0;//��ʼ״̬
parameter ST_W_START = 5'd1;//д
parameter ST_W_ID = 5'd2;
parameter ST_W_ACK1 = 5'd3;
parameter ST_W_REGADDR = 5'd4;
parameter ST_W_ACK2 = 5'd5;
parameter ST_W_REGDATA = 5'd6;
parameter ST_W_ACK3 = 5'd7;
parameter ST_W_STOP = 5'd8;

reg [16:0]delay_cnt;   
reg [16:0]clk_cnt;
reg [4:0]cur_state;//��ǰ״̬
reg [4:0]next_state;//��һ״̬
reg [3:0]bit_cnt;//ÿ���Ѵ����λ��
reg sccb_clk;//sioc
reg sccb_out;//siodҪ���������    
wire delay_done = (delay_cnt == DELAY_NUM) ? 1'b1 : 1'b0;//�ӳ��Ƿ����
wire transfer_en = (clk_cnt == 17'd0) ? 1'b1 :1'b0;//���ݷ���ʹ���ź�
wire transfer_done;//һ�δ����Ƿ����

////////////////////�ϵ�����ӳ�////////////////////
always @ (posedge clk_10MHz or negedge rst_n)
begin
    if (!rst_n)//��λ
        delay_cnt <= 0;
    else if (delay_cnt < DELAY_NUM)
        delay_cnt <= delay_cnt + 1'b1;
    else
        delay_cnt <= delay_cnt;
end

////////////////////sccb״̬��////////////////////
reg [7:0]data_temp;//�ݴ�Ҫд������
//����״̬ת��
always @ (posedge clk_10MHz or negedge rst_n)
    if (!rst_n)//����
        cur_state = ST_IDLE;
    else
        cur_state = next_state;
//����״̬ת������
always @ (*)
begin
    next_state = ST_IDLE;
    case (cur_state)
    ST_IDLE: 
        if (delay_done)
            next_state = ST_W_START;
        else
            next_state = ST_IDLE;
    ST_W_START://��ʼ
        if (transfer_en)
            next_state = ST_W_ID;
        else
            next_state = ST_W_START;
    ST_W_ID://����ID��ַ
        if (transfer_en == 1'b1 && bit_cnt == 4'd8)
            next_state = ST_W_ACK1;
        else
            next_state = ST_W_ID;
    ST_W_ACK1://���Ӧ��ACK1
        if (transfer_en)
            next_state = ST_W_REGADDR;
        else
            next_state = ST_W_ACK1;
    ST_W_REGADDR://���ͼĴ�����ַ
        if (transfer_en == 1'b1 && bit_cnt == 4'd8)
            next_state = ST_W_ACK2;
        else
            next_state = ST_W_REGADDR;
    ST_W_ACK2: //���Ӧ��ACK2
        if (transfer_en)
            next_state = ST_W_REGDATA;
        else
            next_state = ST_W_ACK2;
    ST_W_REGDATA: //���ͼĴ�������
        if (transfer_en == 1'b1 && bit_cnt == 4'd8)
            next_state = ST_W_ACK3;
        else
            next_state = ST_W_REGDATA;
    ST_W_ACK3: //���Ӧ��ACK3
        if (transfer_en)
            next_state = ST_W_STOP;
        else 
            next_state = ST_W_ACK3;
    ST_W_STOP: //ֹͣ
        if (transfer_en && !config_done)
                next_state = ST_W_START;//������һ��д��
        else
            next_state = ST_W_STOP;//����ֹͣ״̬
    endcase
end 

 ////////////////////sccbʱ������////////////////////
always @ (posedge clk_10MHz or negedge rst_n)
begin
   if (!rst_n)//��λ
       begin 
       clk_cnt <= 0;
       sccb_clk <= 0;
       end
   else if (delay_done)
       begin 
       if (clk_cnt < (WAIT_NUM - 1'b1))
           clk_cnt <= (clk_cnt + 1'd1);
       else
           clk_cnt <= 0;
       sccb_clk <= (clk_cnt >= (WAIT_NUM/4 + 1'b1))&&(clk_cnt  < (3*WAIT_NUM/4) + 1'b1) ? 1'b1 : 1'b0;
       end
   else
       begin
       clk_cnt <= 0;
       sccb_clk <= 0;
       end
end

////////////////////����λ����////////////////////
always @ (posedge sccb_clk or negedge rst_n)
begin
    if (!rst_n)//����
        begin
        bit_cnt <= 0;
        end
    else
        begin
        case (next_state)
        ST_W_START,ST_W_ACK1,ST_W_ACK2,ST_W_ACK3: 
            bit_cnt <= 0; 
        ST_W_ID, ST_W_REGDATA,ST_W_REGADDR: 
            bit_cnt <= bit_cnt + 1'b1;
        endcase
        end
end

////////////////////�����ݸ���////////////////////
always @ (negedge clk_10MHz or negedge rst_n)
begin
    if (!rst_n)
        begin
        sccb_out <= 1'b0;//next_state <= ST_IDLE;
        end
    else if (transfer_en)
        case (next_state)
        ST_W_START: 
            begin
            sccb_out <= 1'b0;
            data_temp <= wire_data[23:16];//�ӻ�ID
            end
        ST_W_ID,ST_W_REGDATA,ST_W_REGADDR: 
            sccb_out <= data_temp[3'd7 - bit_cnt];//����1bit����
        ST_W_ACK1: 
            data_temp <= wire_data[15:8];//�Ĵ�����ַ
        ST_W_ACK2: 
            data_temp <= wire_data[7:0];//�Ĵ�������
        ST_W_ACK3: 
            ;//�Ѿ�д�꣬�޲���
        ST_W_STOP: 
            sccb_out <= 1'b0;
        endcase
end
    
////////////////////reg��Ÿ���////////////////////
assign transfer_done = (cur_state == ST_W_STOP) ? 1'b1 : 1'b0;
always @ (negedge clk_10MHz or negedge rst_n)
begin
    if (!rst_n)
        reg_order <= 0;
    else if (transfer_en && transfer_done) 
    begin
            if (reg_order < REG_NUM)
                reg_order <= reg_order + 1'b1;
            else
                reg_order <= REG_NUM;
    end
    else
        reg_order <= reg_order;
end
assign config_done = (reg_order == REG_NUM) ? 1'b1 : 1'b0;
//����sioc,siod
assign sioc = (cur_state >= ST_W_ID && cur_state <= ST_W_ACK3) ? sccb_clk : 1'b1;
assign siod = (cur_state != ST_W_ACK1 && cur_state != ST_W_ACK2 && cur_state != ST_W_ACK3)? sccb_out : 1'bz;  

endmodule