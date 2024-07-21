`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/09 14:56:40
// Design Name: 
// Module Name: reg_config
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
module reg_config(
    input [7:0]reg_order,
    output reg[15:0]data_out
);//VGA,RGB565   

always @ (*)
begin
    case (reg_order)
    8'd0: data_out = {16'hFF01};
    8'd1: data_out = {16'h1280};// UXGA  h1280   CIF1290
    8'd2: data_out = {16'hFF00};
    8'd3: data_out = {16'h2CFF};
    8'd4: data_out = {16'h2EDF};
    8'd5: data_out = {16'hFF01};
    8'd6: data_out = {16'h3C32};
    8'd7: data_out = {16'h1101};
    8'd8: data_out = {16'h0902};
    8'd9: data_out = {16'h0420};
    8'd10: data_out = {16'h13E5};
    8'd11: data_out = {16'h1448};
    8'd12: data_out = {16'h2C0C};
    8'd13: data_out = {16'h3378};
    8'd14: data_out = {16'h3A33};
    8'd15: data_out = {16'h3BFB};
    8'd16: data_out = {16'h3E00};
    8'd17: data_out = {16'h4311};
    8'd18: data_out = {16'h1610};
    8'd19: data_out = {16'h3992};
    8'd20: data_out = {16'h35DA};
    8'd21: data_out = {16'h221A};
    8'd22: data_out = {16'h37C3};
    8'd23: data_out = {16'h2300};
    8'd24: data_out = {16'h34C0};
    8'd25: data_out = {16'h361A};
    8'd26: data_out = {16'h0688};
    8'd27: data_out = {16'h07C0};
    8'd28: data_out = {16'h0D87};
    8'd29: data_out = {16'h0E41};
    8'd30: data_out = {16'h4C00};
    8'd31: data_out = {16'h4800};
    8'd32: data_out = {16'h5B00};
    8'd33: data_out = {16'h4203};
    8'd34: data_out = {16'h4A81};
    8'd35: data_out = {16'h2199};
    8'd36: data_out = {16'h2440};
    8'd37: data_out = {16'h2538};
    8'd38: data_out = {16'h2682};
    8'd39: data_out = {16'h5C00};
    8'd40: data_out = {16'h6300};
    8'd41: data_out = {16'h4600};
    8'd42: data_out = {16'h0C3C};//default 3c   single frame 3d
    8'd43: data_out = {16'h6170};
    8'd44: data_out = {16'h6280};
    8'd45: data_out = {16'h7C05};
    8'd46: data_out = {16'h2080};
    8'd47: data_out = {16'h2830};
    8'd48: data_out = {16'h6C00};
    8'd49: data_out = {16'h6D80};
    8'd50: data_out = {16'h6E00};
    8'd51: data_out = {16'h7002};
    8'd52: data_out = {16'h7194};
    8'd53: data_out = {16'h73C1};
    8'd54: data_out = {16'h1240};//default 40  cif 50
    8'd55: data_out = {16'h1711};
    8'd56: data_out = {16'h1843};// 
    8'd57: data_out = {16'h1900};
    8'd58: data_out = {16'h1A4B};
    8'd59: data_out = {16'h3209};
    8'd60: data_out = {16'h37C0};
    8'd61: data_out = {16'h4FCA};
    8'd62: data_out = {16'h50A8};
    8'd63: data_out = {16'h5a23};
    8'd64: data_out = {16'h6D00};
    8'd65: data_out = {16'h3D38};
    8'd66: data_out = {16'hFF00};
    8'd67: data_out = {16'hE57F};
    8'd68: data_out = {16'hF9C0};
    8'd69: data_out = {16'h4124};
    8'd70: data_out = {16'hE014};//default 14  cif 15
    8'd71: data_out = {16'h76FF};
    8'd72: data_out = {16'h33A0};
    8'd73: data_out = {16'h4220};
    8'd74: data_out = {16'h4318};
    8'd75: data_out = {16'h4C00};
    8'd76: data_out = {16'h87D5};
    8'd77: data_out = {16'h883F};
    8'd78: data_out = {16'hD703};
    8'd79: data_out = {16'hD910};
    8'd80: data_out = {16'hD382};
    8'd81: data_out = {16'hC808};
    8'd82: data_out = {16'hC980};
    8'd83: data_out = {16'h7C00};
    8'd84: data_out = {16'h7D00};
    8'd85: data_out = {16'h7C03};
    8'd86: data_out = {16'h7D48};
    8'd87: data_out = {16'h7D48};
    8'd88: data_out = {16'h7C08};
    8'd89: data_out = {16'h7D20};
    8'd90: data_out = {16'h7D10};
    8'd91: data_out = {16'h7D0E};
    8'd92: data_out = {16'h9000};
    8'd93: data_out = {16'h910E};
    8'd94: data_out = {16'h911A};
    8'd95: data_out = {16'h9131};
    8'd96: data_out = {16'h915A};
    8'd97: data_out = {16'h9169};
    8'd98: data_out = {16'h9175};
    8'd99: data_out = {16'h917E};
    8'd100: data_out = {16'h9188};
    8'd101: data_out = {16'h918F};
    8'd102: data_out = {16'h9196};
    8'd103: data_out = {16'h91A3};
    8'd104: data_out = {16'h91AF};
    8'd105: data_out = {16'h91C4};
    8'd106: data_out = {16'h91D7};
    8'd107: data_out = {16'h91E8};
    8'd108: data_out = {16'h9120};
    8'd109: data_out = {16'h9200};
    8'd110: data_out = {16'h9306};
    8'd111: data_out = {16'h93E3};
    8'd112: data_out = {16'h9305};
    8'd113: data_out = {16'h9305};
    8'd114: data_out = {16'h9300};
    8'd115: data_out = {16'h9304};
    8'd116: data_out = {16'h9300};
    8'd117: data_out = {16'h9300};
    8'd118: data_out = {16'h9300};
    8'd119: data_out = {16'h9300};
    8'd120: data_out = {16'h9300};
    8'd121: data_out = {16'h9300};
    8'd122: data_out = {16'h9300};
    8'd123: data_out = {16'h9600};
    8'd124: data_out = {16'h9708};
    8'd125: data_out = {16'h9719};
    8'd126: data_out = {16'h9702};
    8'd127: data_out = {16'h970C};
    8'd128: data_out = {16'h9724};
    8'd129: data_out = {16'h9730};
    8'd130: data_out = {16'h9728};
    8'd131: data_out = {16'h9726};
    8'd132: data_out = {16'h9702};
    8'd133: data_out = {16'h9798};
    8'd134: data_out = {16'h9780};
    8'd135: data_out = {16'h9700};
    8'd136: data_out = {16'h9700};
    8'd137: data_out = {16'hC3ED};
    8'd138: data_out = {16'hA400};
    8'd139: data_out = {16'hA800};
    8'd140: data_out = {16'hC511};
    8'd141: data_out = {16'hC651};
    8'd142: data_out = {16'hBF80};
    8'd143: data_out = {16'hC710};
    8'd144: data_out = {16'hB666};
    8'd145: data_out = {16'hB8A5};
    8'd146: data_out = {16'hB764};
    8'd147: data_out = {16'hB97C};
    8'd148: data_out = {16'hB3AF};
    8'd149: data_out = {16'hB497};
    8'd150: data_out = {16'hB5FF};
    8'd151: data_out = {16'hB0C5};
    8'd152: data_out = {16'hB194};
    8'd153: data_out = {16'hB20F};
    8'd154: data_out = {16'hC45C};
    8'd155: data_out = {16'hC064};//default 64  CIF 32
    8'd156: data_out = {16'hC14B};//default 4B   CIF 25
    8'd157: data_out = {16'h8C00};
    8'd158: data_out = {16'h863D};
    8'd159: data_out = {16'h5000};
    8'd160: data_out = {16'h51C8};//default c8 CIF 64
    8'd161: data_out = {16'h5296};//default 96 CIF 4a
    8'd162: data_out = {16'h5300};
    8'd163: data_out = {16'h5400};
    8'd164: data_out = {16'h5500};
    8'd165: data_out = {16'h5AC8};//default c8 CIF 64
    8'd166: data_out = {16'h5B96};//default 96 CIF 4a
    8'd167: data_out = {16'h5C00};
    8'd168: data_out = {16'hD382};
    8'd169: data_out = {16'hC3ED};
    8'd170: data_out = {16'h7F00};
    8'd171: data_out = {16'hDA08};
    8'd172: data_out = {16'hE51F};
    8'd173: data_out = {16'hE167};
    8'd174: data_out = {16'hE000};//default 00 CIF 01
    8'd175: data_out = {16'hDD7F};
    8'd176: data_out = {16'h0500};
    8'd177: data_out = {16'hFF01};
    8'd178: data_out = {16'h0a61};
    default:  data_out = {16'hFF01};
    endcase
end

endmodule