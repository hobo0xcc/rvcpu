`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 15:05:08
// Design Name: 
// Module Name: mother_board
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


module mother_board(
    input logic clk,
    input logic reset,
    input logic [3:0] switch,
    output logic [3:0] led
    );
    
    logic [31:0] instr;
    logic [31:0] addr;
    cpu cpu(.clk, .reset, .switch, .led, .addr, .instr_raw(instr));
    rom rom(.addr, .data(instr));
endmodule
