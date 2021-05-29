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
    output logic [31:0] addr
    );
    
    // レジスタ群
    logic [31:0] regs[0:31] = '{32{32'd0}};
    logic [31:0] next_regs[0:31] = '{32{32'd0}};
    logic [31:0] pc = 32'd0;
    logic [31:0] next_pc = 32'd0;
    
    // 命令アドレスにpcを接続
    assign addr = pc;
    
    // レジスタを更新
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            regs            <= '{32{32'd0}};
            pc              <= 32'd0;
        end else begin
            regs[1:31]      <= next_regs[1:31];
            regs[0]         <= 32'd0;
            pc              <= next_pc;
        end
    end
    
    Instr instr;
    decoder decoder(.instr_raw, .instr);
    
    always_comb begin
        next_regs = regs;
        next_pc <= pc + 32'd4;
        unique case (instr.ty)
            ADDI: begin
                next_regs[instr.i_type.rd] = regs[instr.i_type.rs1] + instr.i_type.imm;
            end
            JAL: begin
                next_regs[instr.j_type.rd] = pc + 4;
                next_pc <= pc + instr.j_type.imm;
            end
            default: ;
        endcase
    end
endmodule
