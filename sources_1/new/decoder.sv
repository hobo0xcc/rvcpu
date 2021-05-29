`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 15:39:36
// Design Name: 
// Module Name: decoder
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

import Instruction::*;

module decoder(
    input logic [31:0] instr_raw,
    output Instr instr
    );
    
    logic [6:0] opcode;
    assign opcode = instr_raw[6:0];
    
    // 命令の種類
    always_comb begin
        case (opcode)
            7'b0010011: begin
                case (instr_raw[14:12])
                    3'b000: instr.ty = ADDI;
                    default: $display("Unknown opcode: funct3");
                endcase
            end
            7'b1101111: begin
                instr.ty = JAL;
            end
            default: $display("Unknown opcode");
        endcase
        
        $display("opcode: %x, %x", opcode, instr_raw);
    end
    
    // 命令フォーマット
    wire i_type = (opcode == 7'b0010011);
    wire j_type = (opcode == 7'b1101111);

    always_comb begin
        if (i_type) begin
            instr.i_type.rd = instr_raw[11:7];
            instr.i_type.funct3 = instr_raw[14:12];
            instr.i_type.rs1 = instr_raw[19:15];
            instr.i_type.imm[11:0] = instr_raw[31:20];
            // Sign-extend
            instr.i_type.imm[31:12] = {20{instr.i_type.imm[11]}};
        end else if (j_type) begin
            instr.j_type.rd = instr_raw[11:7];
            instr.j_type.imm[19:12] = instr_raw[19:12];
            instr.j_type.imm[11] = instr_raw[20];
            instr.j_type.imm[10:1] = instr_raw[30:21];
            instr.j_type.imm[20] = instr_raw[31];
            instr.j_type.imm[0] = '0;
            // Sign-extend
            instr.j_type.imm[31:21] = {11{instr.j_type.imm[20]}};
        end else ;
    end
endmodule
