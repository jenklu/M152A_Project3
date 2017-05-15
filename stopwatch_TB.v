`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:55 05/15/2017
// Design Name:   stopwatch
// Module Name:   stopwatch_TB.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stopwatch_TB;

	// Inputs
	reg sel;
	reg adj;
	reg rst;
	reg pause;
	reg clk;

	// Outputs
	wire [3:0] anode_vec;
	wire [6:0] cathode_vec;

	// Instantiate the Unit Under Test (UUT)
	top stopwatch (
		//Input
		.sel(sel), .adj(adj), .rst(rst), .pause(pause), .clk(clk),
		//Outputs
		.anode_vec(anode_vec), .cathode_vec(cathode_vec)
	);

	initial begin
		sel = 0;
		adj = 0;
		rst = 0;
		pause = 0;
		clk = 0;
	end
    always #5 clk = ~clk;
    always @ posedge(clk)
    	coun
endmodule

