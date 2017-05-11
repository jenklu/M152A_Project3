`timescale 1ns / 1ps
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
module counter(
//Inputs
clk, pause, rst,
//Outputs
next, reach60
    );
input clk;
input pause;
input rst;

output reg [5:0] next;
output reg reach60;
always @ (posedge clk) begin
    // If reset
    if (rst) begin
        next = 6'd0;
        reach60 = 0;
    end
    // If pause
    if (pause) begin
        next = next;
        reach60 = 0;
    end
    // Normal counter
    else begin
        if(next == 6'd59) begin
            next = 6'd0;
            reach60 = 1;
        end
        else begin
            reach60 = 0;
            next = next + 1;
        end
    end
end
endmodule
