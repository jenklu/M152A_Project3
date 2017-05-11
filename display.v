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
min, sec, fast_clk, blink_clk, sel, adj,
//Outputs
anode_vec, cathode_vec
    );
input [5:0] min;
input [5:0] sec;
input fast_clk;
//anode_vec of form: [ AN3 AN2 AN1 AN0 ]
output [3:0] anode_vec;
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
reg [3:0] anode_vec_temp;
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
            anode_vec_temp = 4'b0001;
        end
        1: begin
            curr_dig = digits[1];
            anode_vec_temp = 4'b0010;
        end
        2:  begin
            curr_dig = digits[2];
            anode_vec_temp = 4'b0100;
        end
        3: begin
            curr_dig = digits[3];
            anode_vec_temp = 4'b1000;
        end
    endcase
    case(curr_dig)
        0: cathode_vec = 7'b0000001 //
        1: cathode_vec = 7'b1001111
        2: cathode_vec = 7'b0010010 //
        3: cathode_vec = 7'b0000110 //
        4: cathode_vec = 7'b1001100 //
        5: cathode_vec = 7'b0100100 //
        6: cathode_vec = 7'b0100000 //
        7: cathode_vec = 7'b0001111 //
        8: cathode_vec = 7'b0000000 //
        9: cathode_vec = 7'b0001100 //
        default: cathode_vec = 7'b1001000
    endcase
end
reg [1:0] highlow;
reg [3:0] mask;
always @ posedge(blink_clk) begin
    highlow = ~highlow;
    //If adjusting seconds, make the seconds anodes blink
    if(adj && sel) begin
        mask = {1, 1, highlow};
    end
    //If adjusting minutes, make the minutes anodes blink
    else if (adj && !sel) begin
        mask = {highlow, 1, 1};
    end
    else begin
        mask = 4'b1111;
    end
end
assign anode_vec = ~(anode_vec_temp & mask);
endmodule
