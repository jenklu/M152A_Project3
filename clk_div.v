`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:49 05/03/2017 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(
//Input
sys_clk, rst,
//Ouput
onehz_clk, twohz_clk, fast_clk, blink_clk
    );
input sys_clk;
output reg onehz_clk;
output reg twohz_clk;
output reg fast_clk;
output reg blink_clk;
//Counts to a million so that fast_clk is high 100 times per second
reg [19:0] fast_counter;
//Counts the amount of times that fast_clk has been high
reg [6:0] count_fast_high;
always@(posedge sys_clk) begin
    if(rst == 1) begin
        fast_counter = 19'd0;
    end
    else begin
        fast_counter = counter + 1;
    end
    //If fast_counter
    if(fast_counter == 19'd1000000) begin
        fast_clk = 1;
        fast_counter = 19'd0;
        if(count_fast_high == 7'd101) begin
            count_fast_high = 0;
        end
        else begin
            count_fast_high = count_fast_high + 1;
        end
    end
    else begin
        fast_clk = 0;
    end
    if(count_fast_high == 7'd100) begin
        onehz_clk = 1;
        twohz_clk = 1;
    end
    else if(count_fast_high == 7'd50) begin
        twohz_clk = 1;
        onehz_clk = 0;
    end
    else
        twohz_clk = 0;
        onehz_clk = 0;
    end
end    

endmodule
