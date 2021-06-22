`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/18 14:08:45
// Design Name: 
// Module Name: bram_wrapper
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


module bram_wrapper(
    input wire clk,
    input wire [3:0] strb,
    input wire [31:0] write_data,
    output wire [31:0] read_data,
    input wire [31:0] write_addr,
    input wire [31:0] read_addr,
    input wire write_enable,
    input wire read_enable,

    output wire [14:0] axi_araddr,
    output wire [2:0] axi_arprot,
    input wire axi_arready,
    output wire axi_arvalid,

    output wire [14:0] axi_awaddr,
    output wire [2:0] axi_awprot,
    input wire axi_awready,
    output wire axi_awvalid,

    output wire axi_bready,
    input wire [1:0] axi_bresp,
    input wire axi_bvalid,

    input wire [31:0] axi_rdata,
    output wire axi_rready,
    input wire [1:0] axi_rresp,
    input wire axi_rvalid,

    output wire [31:0] axi_wdata,
    input wire axi_wready,
    output wire [3:0] axi_wstrb,
    output wire axi_wvalid,

    output wire axi_aresetn
    );
    bram _bram(
    .clk(clk),
    .strb(strb),
    .write_data(write_data),
    .read_data(read_data),
    .write_addr(write_addr),
    .read_addr(read_addr),
    .write_enable(write_enable),
    .read_enable(read_enable),

    .axi_araddr(axi_araddr),
    .axi_arprot(axi_arprot),
    .axi_arready(axi_arready),
    .axi_arvalid(axi_arvalid),

    .axi_awaddr(axi_awaddr),
    .axi_awprot(axi_awprot),
    .axi_awready(axi_awready),
    .axi_awvalid(axi_awvalid),

    .axi_bready(axi_bready),
    .axi_bresp(axi_bresp),
    .axi_bvalid(axi_bvalid),

    .axi_rdata(axi_rdata),
    .axi_rready(axi_rready),
    .axi_rresp(axi_rresp),
    .axi_rvalid(axi_rvalid),

    .axi_wdata(axi_wdata),
    .axi_wready(axi_wready),
    .axi_wvalid(axi_wvalid),

    .axi_aresetn(axi_aresetn)
    );
endmodule
