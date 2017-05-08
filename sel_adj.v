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

reg [5:0] temp_minutes;
reg [5:0] temp_seconds;

output [5:0] new_minutes;
output [5:0] new_seconds;

// If adj = 0, stopwatch behaves normally
if (!adj) begin
	always @ (posedge clk) begin
		temp_minutes = minutes;
		temp_seconds = seconds;
end
// else stopwatch stops and ‘Selected’ increases at 2Hz
else begin
	always @ (posedge fast_clk) begin
		// If sel = 1, adjust seconds
		if (sel) begin
			temp_minutes = minutes;
			temp_seconds = seconds;
		end
		// else adjust minutes
		else begin
			temp_seconds = seconds;
			temp_minutes = minutes;
		end
	end
end    

new_minutes = temp_minutes;
new_seconds = temp_seconds;

endmodule