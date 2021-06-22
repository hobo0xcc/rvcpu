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
                    3'b010: instr.ty = SLTI;
                    3'b011: instr.ty = SLTIU;
                    3'b100: instr.ty = XORI;
                    3'b110: instr.ty = ORI;
                    3'b111: instr.ty = ANDI;
                    3'b001: instr.ty = SLLI;
                    3'b101: begin
                        if (instr_raw[31:25] == 7'b0000000) instr.ty = SRLI;
                        else if (instr_raw[31:25] == 7'b0100000) instr.ty = SRAI;
                        else ;
                    end
                    default: ;
                endcase
            end
            7'b0110011: begin
                case (instr_raw[14:12])
                    3'b000: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = ADD;
                            7'b0100000: instr.ty = SUB;
                            default: ;
                        endcase
                    end
                    3'b001: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = SLL;
                            default: ;
                        endcase
                    end
                    3'b010: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = SLT;
                            default: ;
                        endcase
                    end
                    3'b011: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = SLTU;
                            default: ;
                        endcase
                    end
                    3'b100: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = XOR;
                            default: ;
                        endcase
                    end
                    3'b101: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = SRL;
                            7'b0100000: instr.ty = SRA;
                            default: ;
                        endcase
                    end
                    3'b110: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = OR;
                            default: ;
                        endcase
                    end
                    3'b111: begin
                        case (instr_raw[31:25])
                            7'b0000000: instr.ty = AND;
                            default: ;
                        endcase
                    end
                    default: ;
                endcase
            end
            7'b0110111: begin
                instr.ty = LUI;
            end
            7'b0010111: begin
                instr.ty = AUIPC;
            end
            7'b0000011: begin
                case (instr_raw[14:12])
                    3'b000: instr.ty = LB;
                    3'b100: instr.ty = LBU;
                    3'b001: instr.ty = LH;
                    3'b101: instr.ty = LHU;
                    3'b010: instr.ty = LW;
                    default: ;
                endcase
            end
            7'b0100011: begin
                case (instr_raw[14:12])
                    3'b000: instr.ty = SB;
                    3'b001: instr.ty = SH;
                    3'b010: instr.ty = SW;
                    default: ;
                endcase
            end
            7'b1101111: begin
                instr.ty = JAL;
            end
            7'b1100111: begin
                instr.ty = JALR;
            end
            7'b1100011: begin
                case (instr_raw[14:12])
                    3'b000: instr.ty = BEQ;
                    3'b001: instr.ty = BNE;
                    3'b100: instr.ty = BLT;
                    3'b101: instr.ty = BGE;
                    3'b110: instr.ty = BLTU;
                    3'b111: instr.ty = BGEU;
                    default ;
                endcase
            end
            default: ;
        endcase
    end
    
    // 命令フォーマット
    wire r_type = (
        opcode == 7'b0110011
    );
    wire i_type = (
        opcode == 7'b0010011 |
        opcode == 7'b0000011 |
        opcode == 7'b1100111
    );
    wire s_type = (opcode == 7'b0100011);
    wire b_type = (opcode == 7'b1100011);
    wire u_type = (
        opcode == 7'b0110111 |
        opcode == 7'b0010111
    );
    wire j_type = (opcode == 7'b1101111);

    wire imm_signed = (
        instr.ty == ADDI    |
        instr.ty == SLTI    |
        instr.ty == XORI    |
        instr.ty == ORI     |
        instr.ty == ANDI    |
        instr.ty == LB      |
        instr.ty == LBU     |
        instr.ty == LH      |
        instr.ty == LHU     |
        instr.ty == LW      |
        instr.ty == SB      |
        instr.ty == SH      |
        instr.ty == SW      |
        instr.ty == JAL     |
        instr.ty == JALR    |
        instr.ty == BEQ     |
        instr.ty == BNE     |
        instr.ty == BLT     |
        instr.ty == BGE     |
        instr.ty == BLTU    |
        instr.ty == BGEU
    );

    always_comb begin
        if (r_type) begin
            instr.r_type.rd = instr_raw[11:7];
            instr.r_type.funct3 = instr_raw[14:12];
            instr.r_type.rs1 = instr_raw[19:15];
            instr.r_type.rs2 = instr_raw[24:20];
            instr.r_type.funct7 = instr_raw[31:25];
        end else if (i_type) begin
            instr.i_type.rd = instr_raw[11:7];
            instr.i_type.funct3 = instr_raw[14:12];
            instr.i_type.rs1 = instr_raw[19:15];
            instr.i_type.imm[11:0] = instr_raw[31:20];
            // Sign-extend or Zero-extend
            if (imm_signed)
                instr.i_type.imm[31:12] = {20{instr.i_type.imm[11]}};
            else
                instr.i_type.imm[31:12] = {20{1'b0}};
        end else if (s_type) begin
            instr.s_type.imm[4:0] = instr_raw[11:7];
            instr.s_type.funct3 = instr_raw[14:12];
            instr.s_type.rs1 = instr_raw[19:15];
            instr.s_type.rs2 = instr_raw[24:20];
            instr.s_type.imm[11:5] = instr_raw[31:25];
            if (imm_signed)
                instr.s_type.imm[31:12] = {20{instr.s_type.imm[11]}};
            else
                instr.s_type.imm[31:12] = {20{1'b0}};
        end else if (b_type) begin
            instr.b_type.imm[11] = instr_raw[7];
            instr.b_type.imm[4:1] = instr_raw[11:8];
            instr.b_type.imm[10:5] = instr_raw[30:25];
            instr.b_type.imm[12] = instr_raw[31];
            instr.b_type.imm[0] = 1'b0;
            instr.b_type.rs1 = instr_raw[19:15];
            instr.b_type.rs2 = instr_raw[24:20];
            if (imm_signed)
                instr.b_type.imm[31:13] = {19{instr.b_type.imm[12]}};
            else
                instr.b_type.imm[31:13] = {19{1'b0}};
        end else if (u_type) begin
            instr.u_type.imm[31:12] = instr_raw[31:12];
            instr.u_type.imm[11:0] = 11'd0;
            instr.u_type.rd = instr_raw[11:7];
        end else if (j_type) begin
            instr.j_type.rd = instr_raw[11:7];
            instr.j_type.imm[19:12] = instr_raw[19:12];
            instr.j_type.imm[11] = instr_raw[20];
            instr.j_type.imm[10:1] = instr_raw[30:21];
            instr.j_type.imm[20] = instr_raw[31];
            instr.j_type.imm[0] = '0;
            // Sign-extend or Zero-extend
            if (imm_signed)
                instr.j_type.imm[31:21] = {11{instr.j_type.imm[20]}};
            else
                instr.j_type.imm[31:21] = {11{1'b0}};
        end else ;
    end
endmodule
