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
module top(
//Inputs
sel, adj, rst, pause, clk,
//Outputs
anode_vec, cathode_vec
    );
input sel;
input adj;
input rst;
input pause;
input clk;
output [3:0] anode_vec;
output [4:0] cathode_vec;
wire sel_db;
wire adj_db;
wire rst_db;
wire pause_db;
debouncer sel_db(.clk(clk), .button(sel), .debounce(sel_db));
debouncer adj_db(.clk(clk), .button(adj), .debounce(adj_db));
debouncer rst_db(.clk(clk), .button(rst), .debounce(rst_db));
debouncer pause_db(.clk(clk), .button(pause), .debounce(pause_db));


endmodule
