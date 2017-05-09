`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:49 05/08/2017 
// Design Name: 
// Module Name:    sel_adj
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
module sel_adj(
//Input
sel, adj, clk, fast_clk, minutes, seconds,
//Ouput
new_minutes, new_seconds
    );

input sel;
input adj;
input clk;
input fast_clk;
input [5:0] minutes;
input [5:0] seconds;

output reg [5:0] new_minutes;
output reg [5:0] new_seconds;

always @ (posedge clk) begin
    // If adj = 0, stopwatch behaves normally
    if (!adj) begin
        new_minutes = minutes;
        new_seconds = seconds;
    end
end
// else stopwatch stops and ‘Selected’ increases at 2Hz
always @ (posedge fast_clk) begin
    if (adj) begin
		// If sel = 1, adjust seconds
		if (sel) begin
			new_minutes = minutes;
			new_seconds = seconds;
		end
		// else adjust minutes
		else begin
			new_minutes = seconds;
			new_seconds = minutes;
		end
	end
end    

endmodule
