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
//Signals internal ot the module
wire sel_db;
wire adj_db;
wire rst_db;
wire pause_db;
wire onehz_clk;
wire twohz_clk;
wire fast_clk;
wire blink_clk;
//Divide clock into slower clocks to be passed to other modules
clk_div clock_divider(.sys_clk(clk), .rst(rst_db), .onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .fast_clk(fast_clk), .blink_clk(blink_clk));
//Debounce inputs
debouncer sel_db(.clk(clk), .button(sel), .debounce(sel_db));
debouncer adj_db(.clk(clk), .button(adj), .debounce(adj_db));
debouncer rst_db(.clk(clk), .button(rst), .debounce(rst_db));
debouncer pause_db(.clk(clk), .button(pause), .debounce(pause_db));
//Main counting logic
wire [5:0] minutes;
wire [5:0] seconds;
sel_adj adjust(.sel(sel_db), .adj(adj_db), .clk(clk), .onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .pause(pause_db), .rst(rst_db),
.new_minutes(minutes), .new_seconds(seconds));

display seven_seg_disp(.min(minutes), .sec(seconds), .fast_clk(fast_clk), .blink_clk(blink_clk), .sel(sel_db), .adj(adj_db), .anode_vec(anode_vec), .cathod_vec(cathod_vec));

endmodule
