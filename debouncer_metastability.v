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
module debouncer_metastability(
    //Inputs
    clk, button,
    //Outputs
    bounce_state
    );

	 input clk;
	 input button;
    output bounce_state;
	 reg bounce_state_temp;
	 reg [7:0] debounce;
    // Filter out the noise by sampling at a lower frequency than the noise
    // TODO: what clk should be passed in

    // Shift register to sample the button press for a set time to deal w/ debounce
    reg [7:0] debounced;

    always @ (posedge clk) begin
        debounced <= {debounced[6:0], button};
        if (debounced == 8'b00000000) begin
            bounce_state_temp <= 1'b0;
        end
        else if (debounced == 8'b11111111) begin
            bounce_state_temp <= 1'b1;
        end
        else begin
            bounce_state_temp <= bounce_state;
        end
    end
	 assign bounce_state = bounce_state_temp;
endmodule
