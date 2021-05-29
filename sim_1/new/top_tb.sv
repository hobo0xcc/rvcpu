`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 18:11:19
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    logic clk = 0;
    logic reset = '0;
    logic [3:0] led = 4'b0000;
    logic [3:0] switch = 4'b0000;
    
    always begin
        clk = 1'b1;
        #5;
        clk = 1'b0;
        #5;
    end
    
    mother_board mother_board(.clk, .reset, .switch, .led);
endmodule
