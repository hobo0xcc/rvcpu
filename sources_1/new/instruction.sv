`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 15:21:42
// Design Name: 
// Module Name: instruction
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

package Instruction;
    // 命令一覧
    typedef enum logic [31:0] {
        ADDI,
        JAL
    } InstrType;
    
    typedef struct {
        logic [4:0] rd;
        logic [2:0] funct3;
        logic [4:0] rs1;
        logic [31:0] imm;
    } I_Type;
    
    typedef struct {
        logic [4:0] rd;
        logic [31:0] imm;
    } J_Type;
    
    typedef struct {
        InstrType ty;
        I_Type i_type;
        J_Type j_type;
    } Instr;
endpackage
