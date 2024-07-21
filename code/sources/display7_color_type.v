`timescale 1ns / 1ps
`include "D:\DigitalLogicCircuit\VivadoProject\BigHW_2022_fall\BigHW_2022_fall.srcs\sources_1\new\params.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/12 10:51:47
// Design Name: 
// Module Name: display7_color_type
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


module display7_color_type(
    input clk,//100MHz
    input [2:0]color_type,
    output [6:0]tube_data,
    output reg[7:0]bit_ctrl
    );
    
wire tube_clk;
reg [24:0]word_data;
reg [4:0]temp;
reg [2:0]bit_flag=0;

always @(*)
begin
    case(color_type)
    `COLOR_INIT:
        word_data <= {5'd31,`LETTER_I,`LETTER_N,`LETTER_I,`LETTER_T};
    `COLOR_BLACK:
        word_data <= {`LETTER_B,`LETTER_L,`LETTER_A,`LETTER_C,`LETTER_K};
    `COLOR_WHITE:
        word_data <= {`LETTER_W,`LETTER_H,`LETTER_I,`LETTER_T,`LETTER_E};
    `COLOR_RED:
        word_data <= {5'd31,5'd31,`LETTER_R,`LETTER_E,`LETTER_D};
    `COLOR_GREEN:
        word_data <= {`LETTER_G,`LETTER_R,`LETTER_E,`LETTER_E,`LETTER_N};
    `COLOR_BLUE:
        word_data <= {5'd31,`LETTER_B,`LETTER_L,`LETTER_U,`LETTER_E};
    default:
        word_data <= {5'd31,5'd31,5'd31,5'd31,5'd31};
    endcase
end

always @ (posedge tube_clk)
begin
    case(bit_flag)
    3'b000:
        begin
        bit_ctrl = 8'b1111_1110;
        temp <= {word_data[4:0]};
        bit_flag <= bit_flag + 1;
        end
    3'b001:
        begin
        bit_ctrl = 8'b1111_1101;
        temp <= {word_data[9:5]};
        bit_flag <= bit_flag + 1;
        end
     3'b010:
        begin
        bit_ctrl = 8'b1111_1011;
        temp <= {word_data[14:10]};
        bit_flag <= bit_flag + 1;
        end
     3'b011:
        begin
        bit_ctrl = 8'b1111_0111;
        temp <= {word_data[19:15]};
        bit_flag <= bit_flag + 1;
        end
     3'b100:
        begin
        bit_ctrl = 8'b1110_1111;
        temp <= {word_data[24:20]};
        bit_flag <= 3'b0;
        end
     /*default:
        begin
        bit_ctrl = 8'b1111_1111;
        temp <= {5'd31};
        bit_flag <= 3'b0;
        end*/
    endcase
end

display7_letter display7_letter_inst(
    .iData(temp), 
    .oData(tube_data)
);
//assign tube_clk = clk; //tbÓÃ

divider divider_inst(
    .I_CLK(clk), 
    .rst(0), 
    .O_CLK(tube_clk)
);
endmodule
