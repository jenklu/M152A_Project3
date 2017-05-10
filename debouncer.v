`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang 
// 
// Create Date:    21:08:17 05/06/2017 
// Design Name: 
// Module Name:    C:/Users/JasonLess/Documents/
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
module debouncer(
  //Inputs
  clk, button, 
  //Outputs
  debounce
  );

  reg [15:0] counter;

  reg sync_to_clk0;
  reg sync_to_clk1;

  always @ (posedge clk) begin
    sync_to_clk0 <= button;
  end
  always @ (posedge clk) begin
    sync_to_clk1 <= sync_to_clk0;
  end


  always @ (posedge clk) begin
  	if (debounce == sync_to_clk1) begin
		counter <= 0;
	end
	else begin
		counter <= counter + 1'b1;
		if (counter == 16'hffff) begin
	     		debounce <= ~debouce;
		end
        end
  end
endmodule
