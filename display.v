timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:21 05/03/2017 
// Design Name: 
// Module Name:    counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module display(
//Inputs
min, sec, fast_clk
//Outputs

    );
input [5:0] min;
input [5:0] sec;
input fast_clk;
//anode_vec of form: [ AN3 AN2 AN1 AN0 ]
output reg [3:0] anode_vec;
//cathode_vec of form: [ CA CB CC CD CE CF CG ]
output reg[6:0] cathode_vec;
wire [3:0] digits [3:0];
//Integer division truncates, so this works to extract the 1s digit
assign digits[3] = min/10;
assign digits[1] = min/10;
//Because modulo does not work on this board, we implement it ourselves
assign digits[2] = min - (10*digits[3]);
assign digits[0] = sec - (10*digits[1]);
reg [1:0] switch_signal;
reg[3:0] curr_dig;
always @ (posedge fast_clk) begin
    if(switch_signal == 2'b11) begin
        switch_signal = 2'b00;
    end
    else begin
        switch_signal = switch_signal + 1;
    end
    case(switch_signal)
        0: begin
            curr_dig = digits[0];
            anode_vec = 4'b0001;
        end
        1: begin
            curr_dig = digits[1];
            anode_vec = 4'b0010;
        end
        2:  begin
            curr_dig = digits[2];
            anode_vec = 4'b0100;
        end
        3: begin
            curr_dig = digits[3];
            anode_vec = 4'b1000;
        end
    endcase
    case(curr_dig)
        0: cathode_vec = 7'b1111110
        1: cathode_vec = 7'b0110000
        2: cathode_vec = 7'b1101101
        3: cathode_vec = 7'b1111001
        4: cathode_vec = 7'b0110011
        5: cathode_vec = 7'b1011011
        6: cathode_vec = 7'b1011111
        7: cathode_vec = 7'b1110000
        8: cathode_vec = 7'b1111111
        9: cathode_vec = 7'b1110011
        default: cathode_vec = 7'b0110111
    endcase
end
endmodule
