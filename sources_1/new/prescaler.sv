`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 14:59:15
// Design Name: 
// Module Name: prescaler
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


module prescaler #(
    parameter CLK_THRESHOLD = 32'd100_000_000
) (
    input logic clk,
    output logic slow_clk
    );
    
    logic [31:0] clk_counter = 32'd0;
    logic cur_clk = 0;
    assign slow_clk = cur_clk;
    
    always_ff @(posedge clk) begin
        if (clk_counter == CLK_THRESHOLD / 2 - 1) begin
            clk_counter <= 32'd0;
            cur_clk <= ~cur_clk;
        end else begin
            clk_counter <= clk_counter + 32'd1;
        end
    end
endmodule
