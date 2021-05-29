`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 14:50:15
// Design Name: 
// Module Name: top
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


module top(
    input logic pin_clk,
    input logic pin_reset,
    input logic [3:0] pin_switch,
    output logic [3:0] pin_led
    );
    
    logic clk;
    prescaler prescaler(.clk(pin_clk), .slow_clk(clk));
    mother_board mother_board(.clk, .reset(pin_reset), .switch(pin_switch), .led(pin_led));
endmodule
