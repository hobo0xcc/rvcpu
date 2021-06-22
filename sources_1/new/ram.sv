`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/22 04:45:04
// Design Name: 
// Module Name: ram
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


module ram(
    input logic clk,
    input logic [31:0] read_addr,
    input logic [31:0] write_addr,
    input logic read_enable,
    input logic write_enable,
    input logic [31:0] write_data,
    input logic [3:0] write_strb,
    output logic [31:0] read_data,
    input logic [3:0] read_strb
    );

    logic [7:0] mem[0:255];

    always_comb begin
        if (read_enable) begin
            if (read_strb[0] == 1'b1) read_data[7:0] = mem[read_addr];
            if (read_strb[1] == 1'b1) read_data[15:8] = mem[read_addr + 1];
            if (read_strb[2] == 1'b1) read_data[23:16] = mem[read_addr + 2];
            if (read_strb[3] == 1'b1) read_data[31:24] = mem[read_addr + 3];
        end
        if (write_enable) begin
            if (write_strb[0] == 1'b1) mem[write_addr] = write_data[7:0];
            if (write_strb[1] == 1'b1) mem[write_addr + 1] = write_data[15:8];
            if (write_strb[2] == 1'b1) mem[write_addr + 2] = write_data[23:16];
            if (write_strb[3] == 1'b1) mem[write_addr + 3] = write_data[31:24];
        end
    end
endmodule
