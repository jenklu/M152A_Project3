`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:21 05/03/2017 
// Design Name: 
// Module Name:    top 
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
output [6:0] cathode_vec;
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
clock_divider clk_div(.sys_clk(clk), .rst(rst_db), .onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .fast_clk(fast_clk), .blink_clk(blink_clk));
//Debounce inputs
debouncer_metastability sel_db_func(.clk(clk), .button(sel), .bounce_state(sel_db));
debouncer_metastability adj_db_func(.clk(clk), .button(adj), .bounce_state(adj_db));
debouncer_metastability rst_db_func(.clk(clk), .button(rst), .bounce_state(rst_db));
debouncer_metastability pause_db_func(.clk(clk), .button(pause), .bounce_state(pause_db));
//Main counting logic
wire [5:0] minutes;
wire [5:0] seconds;
sel_adj adjust(.sel(sel_db), .adj(adj_db), .clk(clk), .onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .pause(pause_db), .rst(rst_db),
.new_minutes(minutes), .new_seconds(seconds));

display seven_seg_disp(.min(minutes), .sec(seconds), .fast_clk(fast_clk), .blink_clk(blink_clk), .sel(sel_db), .adj(adj_db), .anode_vec(anode_vec), .cathode_vec(cathode_vec));

endmodule
