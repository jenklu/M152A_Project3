`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:13 05/03/2017 
// Design Name: 
// Module Name:    pause_reset 
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
module pause_reset(
//Inputs
pause, rst, clk, counter_logic,
//Outputs
next
    );
input pause;
input rst;
input clk;
input [5:0] counter_logic;
output reg [5:0] next;
always@(posedge clk) begin
    if(rst) begin
        next = 6'd0;
    end    
    else if(pause == 0) begin
        next = counter_logic;
    end
end
endmodule
