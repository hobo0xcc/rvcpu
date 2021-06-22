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
    logic [31:0] addr_rom;
    logic [31:0] read_addr;
    logic [31:0] write_addr;
    logic read_enable;
    logic write_enable;
    logic [31:0] write_data;
    logic [3:0] write_strb;
    logic [31:0] read_data;
    logic [3:0] read_strb;

    cpu cpu(.clk, .reset, .switch, .led, .addr_rom, .instr_raw(instr),
        .read_addr,
        .write_addr,
        .read_enable,
        .write_enable,
        .write_data,
        .write_strb,
        .read_data,
        .read_strb);
    rom rom(.addr(addr_rom), .data(instr));
    ram ram(.read_addr, .write_addr, .read_enable, .write_enable, .write_data, .write_strb, .read_data, .read_strb);
endmodule
