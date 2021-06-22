`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 13:46:45
// Design Name: 
// Module Name: bram
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


module bram(
    input logic clk,
    input logic [3:0] strb,
    input logic [31:0] write_data,
    output logic [31:0] read_data,
    input logic [31:0] write_addr,
    input logic [31:0] read_addr,
    input logic write_enable,
    input logic read_enable,

    output logic [14:0] axi_araddr,
    output logic [2:0] axi_arprot,
    input logic axi_arready,
    output logic axi_arvalid,

    output logic [14:0] axi_awaddr,
    output logic [2:0] axi_awprot,
    input logic axi_awready,
    output logic axi_awvalid,

    output logic axi_bready,
    input logic [1:0] axi_bresp,
    input logic axi_bvalid,

    input logic [31:0] axi_rdata,
    output logic axi_rready,
    input logic [1:0] axi_rresp,
    input logic axi_rvalid,

    output logic [31:0] axi_wdata,
    input logic axi_wready,
    output logic [3:0] axi_wstrb,
    output logic axi_wvalid,
    
    output logic axi_aresetn
    );

    assign axi_aresetn = 1'b1;

    logic reset = 1'b0;
    typedef enum logic [31:0] {
        WAIT,
        WAIT_MEM,
        WAIT_MEM2,
        READ_COMPLETE,
        WRITE_COMPLETE
    } BramState;
    BramState state = WAIT;

    task reset_value();
        // read
        axi_arvalid <= 1'b0;
        axi_rready <= 1'b0;

        // write
        axi_awvalid <= 1'b0;
        axi_wvalid <= 1'b0;
        axi_bready <= 1'b0;
    endtask

    always_ff @(posedge clk) begin
        if (state == WAIT) begin
            if (axi_wvalid) begin
                state <= WAIT_MEM;
            end else if (axi_arvalid) begin
                state <= WAIT_MEM;
            end
        end else if (state == WAIT_MEM) begin
            if (axi_wready) begin
                state <= WRITE_COMPLETE;
            end else if (axi_arready) begin
                axi_rready <= 1'b1;
                state <= WAIT_MEM2;
            end else ;
        end else if (state == WAIT_MEM2) begin
            if (axi_rvalid) begin
                state = READ_COMPLETE;
            end
        end else if (state == WRITE_COMPLETE) begin
            reset_value();
            state <= WAIT;
        end else if (state == READ_COMPLETE) begin
            read_data <= axi_rdata;
            reset_value();
            state <= WAIT;
        end
    end

    always @(posedge write_enable) begin
        axi_awaddr <= write_addr[14:0];
        axi_awprot <= 3'b000;
        axi_awvalid <= 1'b1;
        axi_wdata <= write_data;
        axi_wstrb <= strb;
        axi_wvalid <= 1'b1;
        axi_bready <= 1'b1;
    end

    always @(posedge read_enable) begin
        axi_araddr <= read_addr[14:0];
        axi_arprot <= 3'b000;
        axi_arvalid <= 1'b1;
    end

    // always @(posedge clk) begin
    //     if (write_enable) begin
    //         axi_awaddr <= write_addr;
    //         axi_awprot <= 3'b000;
    //         axi_awvalid <= 1'b1;
    //         axi_wdata <= write_data;
    //         axi_wstrb <= strb;
    //         axi_wvalid <= 1'b1;
    //         axi_bready <= 1'b1;
    //     end else if (read_enable) begin
    //         axi_araddr <= read_addr;
    //         axi_arprot <= 3'b000;
    //         axi_arvalid <= 1'b1;
    //         axi_rready <= 1'b1;
    //     end else ;
    // end

    // always @(posedge axi_bvalid) begin
    //     if (axi_bresp[1] == 1'b0) begin
    //         axi_awvalid <= 1'b0;
    //         axi_wvalid <= 1'b0;
    //         axi_bready <= 1'b0;
    //     end else ;
    // end

    // always @(posedge axi_rvalid) begin
    //     if (axi_rresp[1] == 1'b0) begin
    //         read_data <= axi_rdata;
    //         axi_arvalid <= 1'b0;
    //         axi_rready <= 1'b0;
    //     end else ;
    // end
endmodule
