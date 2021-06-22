`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 11:17:59
// Design Name: 
// Module Name: top_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_wrapper(
    input wire clk,
    input wire reset,
    input wire [3:0] switch,
    output wire [3:0] led
    );
    top _top(.pin_clk(clk), .pin_reset(reset), .pin_switch(switch), .pin_led(led));
endmodule
