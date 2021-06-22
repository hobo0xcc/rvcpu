`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 15:08:18
// Design Name: 
// Module Name: rom
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


module rom(
    input logic [31:0] addr,
    output logic [31:0] data
    );

    logic [7:0] mem[0:255];
    // int fd, status;
    // int start, e, size;
    // initial begin
    //     fd = $fopen("C:\\Users\\slime\\work\\src\\rvml\\work\\test.bin", "rb");
    //     $fseek(fd, 0, 2);
    //     e = $ftell(fd);
    //     $fseek(fd, 0, 0);
    //     start = $ftell(fd);
    //     status = $fread(mem, fd, start, e - start);
    //     $display("status = %d", status);
    //     $display("mem[0] = %x", mem[0]);
    //     $fclose(fd);
    // end

    initial begin
        $readmemh("fib.mem", mem);
    end

    assign data[7:0] = mem[addr];
    assign data[15:8] = mem[addr + 1];
    assign data[23:16] = mem[addr + 2];
    assign data[31:24] = mem[addr + 3];
    
    // always_comb begin
    //     case (addr)
    //         32'h00: data = 32'b000000000001_00001_000_00001_0010011;
    //         32'h04: data = 32'b1_1111111100_111111111_00000_1101111;
    //         default: data = 32'h00;
    //     endcase
    // end
endmodule
