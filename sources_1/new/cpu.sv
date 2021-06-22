`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 15:07:51
// Design Name: 
// Module Name: cpu
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

module cpu(
    input logic clk,
    input logic reset,
    input logic [3:0] switch,
    input logic [31:0] instr_raw,
    output logic [3:0] led,
    output logic [31:0] addr_rom,
    output logic [31:0] read_addr,
    output logic [31:0] write_addr,
    output logic read_enable,
    output logic write_enable,
    output logic [31:0] write_data,
    output logic [3:0] write_strb,
    input logic [31:0] read_data,
    output logic [3:0] read_strb
    );
    
    // レジスタ群
    logic [31:0] regs[0:31] = '{32{32'd0}};
    logic [31:0] next_regs[0:31] = '{32{32'd0}};
    logic [31:0] pc = 32'd0;
    logic [31:0] next_pc = 32'd0;

    assign led = regs[10][3:0];
    
    // 命令アドレスにpcを接続
    assign addr_rom = pc;

    Instr instr;
    decoder decoder(.instr_raw, .instr);

    initial begin
        regs[2] = 32'd255;
    end

    task next_state(); begin
        regs[1:31]      <= next_regs[1:31];
        regs[0]         <= 32'd0;
        pc              <= next_pc;
        // memory_wait     <= 1'b0;
    end endtask

    // レジスタを更新
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            regs            <= '{32{32'd0}};
            pc              <= 32'd0;
        end else begin
            next_state();
        end
    end
    
    always_comb begin
        next_regs = regs;
        next_pc <= pc + 32'd4;
        write_enable = 1'b0;
        read_enable = 1'b0;
        unique case (instr.ty)
            NOP: ;
            ADDI: begin
                next_regs[instr.i_type.rd] = $signed(regs[instr.i_type.rs1]) + $signed(instr.i_type.imm);
            end
            SLTI: begin
                next_regs[instr.i_type.rd] = $signed(regs[instr.i_type.rs1]) < $signed(instr.i_type.imm);
            end
            SLTIU: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] < instr.i_type.imm;
            end
            XORI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] ^ instr.i_type.imm;
            end
            ORI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] | instr.i_type.imm;
            end
            ANDI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] & instr.i_type.imm;
            end
            SLLI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] << instr.i_type.imm[4:0];
            end
            SRLI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] >> instr.i_type.imm[4:0];
            end
            SRAI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] >>> instr.i_type.imm[4:0];
            end
            ADD: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] + regs[instr.r_type.rs2];
            end
            SUB: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] - regs[instr.r_type.rs2];
            end
            SLT: begin
                if ($signed(regs[instr.r_type.rs1]) < $signed(regs[instr.r_type.rs2]))
                    next_regs[instr.r_type.rd] = 32'd1;
                else
                    next_regs[instr.r_type.rd] = 32'd0;
            end
            SLTU: begin
                if (regs[instr.r_type.rs1] < regs[instr.r_type.rs2])
                    next_regs[instr.r_type.rd] = 32'd1;
                else
                    next_regs[instr.r_type.rd] = 32'd0;
            end
            AND: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] & regs[instr.r_type.rs2];
            end
            OR: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] | regs[instr.r_type.rs2];
            end
            XOR: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] ^ regs[instr.r_type.rs2];
            end
            SLL: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1]  << regs[instr.r_type.rs2][4:0];
            end
            SRL: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] >> regs[instr.r_type.rs2][4:0];
            end
            SRA: begin
                next_regs[instr.r_type.rd] = regs[instr.r_type.rs1] >>> regs[instr.r_type.rs2];
            end
            LUI: begin
                next_regs[instr.u_type.rd] = instr.u_type.imm;
            end
            AUIPC: begin
                next_regs[instr.u_type.rd] = instr.u_type.imm + pc;
            end
            LB: begin
                read_addr = regs[instr.i_type.rs1] + $signed(instr.i_type.imm);
                if (read_addr[1:0] == 2'b00) read_strb = 4'b1000;
                else if (read_addr[1:0] == 2'b01) read_strb = 4'b0100;
                else if (read_addr[1:0] == 2'b10) read_strb = 4'b0010;
                else if (read_addr[1:0] == 2'b11) read_strb = 4'b0001;
                read_enable = 1'b1;
                next_regs[instr.i_type.rd] = {{24{read_data[7]}}, read_data[7:0]};
            end
            LBU: begin
                read_addr = regs[instr.i_type.rs1] + $signed(instr.i_type.imm);
                if (read_addr[1:0] == 2'b00) read_strb = 4'b1000;
                else if (read_addr[1:0] == 2'b01) read_strb = 4'b0100;
                else if (read_addr[1:0] == 2'b10) read_strb = 4'b0010;
                else if (read_addr[1:0] == 2'b11) read_strb = 4'b0001;
                read_enable = 1'b1;
                next_regs[instr.i_type.rd] = {24'b0, read_data[7:0]};
            end
            LH: begin
                read_addr = regs[instr.i_type.rs1] + $signed(instr.i_type.imm);
                if (read_addr[1:0] == 2'b00) read_strb = 4'b1100;
                else if (read_addr[1:0] == 2'b10) read_strb = 4'b0011;
                read_enable = 1'b1;
                next_regs[instr.i_type.rd] = {{16{read_data[15]}}, read_data[15:0]};
            end
            LHU: begin
                read_addr = regs[instr.i_type.rs1] + $signed(instr.i_type.imm);
                if (read_addr[1:0] == 2'b00) read_strb = 4'b1100;
                else if (read_addr[1:0] == 2'b10) read_strb = 4'b0011;
                read_enable = 1'b1;
                next_regs[instr.i_type.rd] = {16'b0, read_data[15:0]};
            end
            LW: begin
                read_addr = regs[instr.i_type.rs1] + $signed(instr.i_type.imm);
                read_strb = 4'b1111;
                read_enable = 1'b1;
                next_regs[instr.i_type.rd] = read_data;
            end
            SB: begin
                write_addr = regs[instr.s_type.rs1] + $signed(instr.s_type.imm);
                write_data = regs[instr.s_type.rs2];
                if (write_addr[1:0] == 2'b00) write_strb = 4'b1000;
                else if (write_addr[1:0] == 2'b01) write_strb = 4'b0100;
                else if (write_addr[1:0] == 2'b10) write_strb = 4'b0010;
                else if (write_addr[1:0] == 2'b11) write_strb = 4'b0001;
                write_enable = 1'b1;
            end
            SH: begin
                write_addr = regs[instr.s_type.rs1] + $signed(instr.s_type.imm);
                write_data = regs[instr.s_type.rs2];
                if (write_addr[1:0] == 2'b00) write_strb = 4'b1100;
                else if (write_addr[1:0] == 2'b10) write_strb = 4'b0011;
                write_enable = 1'b1;
            end
            SW: begin
                write_addr = regs[instr.s_type.rs1] + $signed(instr.s_type.imm);
                write_data = regs[instr.s_type.rs2];
                write_strb = 4'b1111;
                write_enable = 1'b1;
            end
            JAL: begin
                next_regs[instr.j_type.rd] = pc + 4;
                next_pc <= pc + $signed(instr.j_type.imm);
            end
            JALR: begin
                next_regs[instr.i_type.rd] = pc + 4;
                next_pc <= (regs[instr.i_type.rs1] + $signed(instr.i_type.imm)) & 32'hfffffffc;
            end
            BEQ: begin
                if (regs[instr.b_type.rs1] == regs[instr.b_type.rs2])
                    next_pc <= pc + $signed(instr.b_type.imm);
            end
            BNE: begin
                if (regs[instr.b_type.rs1] != regs[instr.b_type.rs2])
                    next_pc <= pc + $signed(instr.b_type.imm);
            end
            BLT: begin
                if ($signed(regs[instr.b_type.rs1]) < $signed(regs[instr.b_type.rs2]))
                    next_pc <= pc + $signed(instr.b_type.imm);
            end
            BGE: begin
                if ($signed(regs[instr.b_type.imm]) >= $signed(regs[instr.b_type.rs2]))
                    next_pc <= pc + $signed(instr.b_type.imm);
            end

            BLTU: begin
                if (regs[instr.b_type.rs1] < regs[instr.b_type.rs2])
                    next_pc <= pc + $signed(instr.b_type.imm);
            end
            BGEU: begin
                if (regs[instr.b_type.imm] >= regs[instr.b_type.rs2])
                    next_pc <= pc + $signed(instr.b_type.imm);
            end
            default: ;
        endcase
    end
endmodule
