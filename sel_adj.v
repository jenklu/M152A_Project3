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
sel, adj, clk, onehz_clk, twohz_clk, minutes, seconds,
//Ouput
new_minutes, new_seconds
    );

input sel;
input adj;
input onehz_clk;
input twohz_clk;

output reg [5:0] new_minutes;
output reg [5:0] new_seconds;
reg ignore;
reg min_clk [5:0];
reg sec_clk [5:0];
reg reach_60;
counter min_counter(.clk(min_clk), .next(new_minutes), .reach60(ignore));
counter sec_counter(.clk(sec_clk), .next(new_seconds), .reach60(reach_60);
	
always @ (posedge clk) begin
    // If adj = 0, stopwatch behaves normally
    if (!adj) begin
        min_clk = reach_60;
	sec_clk = onehz_clk;
    end 
    else if (sel == 1) begin
	sec_clk = twohz_clk;
	min_clk = 0;
    end
    // else adjust minutes
    else begin
	min_clk = twohz_clk;
	sec_clk = 0;
    end
end    

endmodule
