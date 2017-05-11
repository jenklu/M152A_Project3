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
//TODO: Figure out how fast to make blink_clk blink
module clk_div(
    //Input
    sys_clk, rst,
    //Ouput
    onehz_clk, twohz_clk, fast_clk, blink_clk
    );
// Master clock: 100 MHz
input sys_clk;
// 1 Hz clock
// 100,000,000 clock cycles for onehz_clk to go high and return to low
// Thus, it takes half (i.e. 50,000,000) for onehz_clk to go high
output reg onehz_clk;
// 2 Hz clock
// 50,000,000 clock cycles for twohz_clk to go high and return to low
// Thus, it takes half (i.e. 25,000,000) for twohz_clk to go high
output reg twohz_clk;
// 100 Hz clock
// 1,000,000 clock cycles for fasthz_clk to go high and return to low
// Thus, it takes half (i.e. 500,000) for fasthz_clk to go high
output reg fast_clk;
// 4 Hz clock
// 25,000,000 clock cycles for blinkhz_clk to go high and return to low
// Thus, it takes half (i.e. 12,500,000) for blinkhz_clk to go high
output reg blink_clk;

// Counters to count the clock cycles before the specified clock goes high
reg [31:0] onehz_count;
reg [31:0] twohz_count;
reg [31:0] fasthz_count;
reg [31:0] blinkhz_count;

    // 1 Hz Clock Implementation
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            onehz_count <= 1'b0;
            onehz_clk <= 1'b0;
        end
        else if (onehz_count == 32'b50000000 - 1) begin
            onehz_count <= 1'b0;
            onehz_clk <= ~onehz_clk;
        end
        else begin
            onehz_count <= onehz_count + 1;
            onehz_clk <= onehz_clk;
        end
    end
    // 2 Hz Clock Implementation
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            twohz_count <= 1'b0;
            twohz_clk <= 1'b0;
        end
        else if (twohz_count == 32'b25000000 - 1) begin
            twohz_count <= 1'b0;
            twohz_clk <= ~twohz_clk;
        end
        else begin
            twohz_count <= twohz_count + 1;
            twohz_clk <= twohz_clk;
        end
    end
    // Fast (100 Hz) Clock Implementation
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            fasthz_count <= 1'b0;
            fasthz_clk <= 1'b0;
        end
        else if (fasthz_count == 32'b500000 - 1) begin
            fasthz_count <= 1'b0;
            fasthz_clk <= ~fasthz_clk;
        end
        else begin
            fasthz_count <= fasthz_count + 1;
            fasthz_clk <= fasthz_clk;
        end
    end
    // Blink (4 Hz) Clock Implementation
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            blinkhz_count <= 1'b0;
            onehz_clk <= 1'b0;
        end
        else if (blinkhz_count == 32'b12500000 - 1) begin
            blinkhz_count <= 1'b0;
            blinkhz_clk <= ~blinkhz_clk;
        end
        else begin
            blinkhz_count <= blinkhz_count + 1;
            blinkhz_clk <= blinkhz_clk;
        end
    end
endmodule
