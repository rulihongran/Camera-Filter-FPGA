`timescale 1ns / 1ps
`include "D:\DigitalLogicCircuit\VivadoProject\BigHW_2022_fall\BigHW_2022_fall.srcs\sources_1\new\params.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/10 22:51:26
// Design Name: 
// Module Name: display7
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


module display7_letter(
    input [4:0] iData,
    output reg[6:0] oData
    );
always @(*)
begin
    case(iData)
        `LETTER_A://A
        oData <= 7'b0001000; 
        `LETTER_B://b
        oData <= 7'b0000011; 
        `LETTER_C://C
        oData <= 7'b1000110; 
        `LETTER_D://d
        oData <= 7'b0100001; 
        `LETTER_E://E
        oData <= 7'b0000110; 
        `LETTER_F://F
        oData <= 7'b0001110; 
        `LETTER_G://G
        oData <= 7'b1000010; 
        `LETTER_H://H
        oData <= 7'b0001001; 
        `LETTER_I://I
        oData <= 7'b1111001;
        `LETTER_J://J
        oData <= 7'b1110001;
        `LETTER_K://K
        oData <= 7'b0001010;
        `LETTER_L://L
        oData <= 7'b1000111;
        `LETTER_M://M
        oData <= 7'b1001000;
        `LETTER_N://n(´ó°æ)
        oData <= 7'b1001000;
        `LETTER_O://o
        oData <= 7'b0100011;
        `LETTER_P://P
        oData <= 7'b0001100;
        `LETTER_Q://q
        oData <= 7'b0011000;
        `LETTER_R://r
        oData <= 7'b1001110;
        `LETTER_S://S
        oData <= 7'b0110110;
        `LETTER_T://t
        oData <= 7'b0000111;
        `LETTER_U://U
        oData <= 7'b1000001;
        `LETTER_V://v
        oData <= 7'b1100011;
        `LETTER_W://W
        oData <= 7'b0000001;
        `LETTER_X://X
        oData <= 7'b0011011;
        `LETTER_Y://y
        oData <= 7'b0010001;
        `LETTER_Z://Z
        oData <= 7'b0100101;
        default: 
        oData <= 7'b1111111;//È«Ãð
    endcase
end
endmodule
