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
        NOP,
        // I Type
        ADDI,
        SLTI,
        SLTIU,
        XORI,
        ORI,
        ANDI,
        SLLI,
        SRLI,
        SRAI,

        LB,
        LBU,
        LH,
        LHU,
        LW,

        JALR,

        // R Type
        ADD,
        SUB,
        SLL,
        SLT,
        SLTU,
        XOR,
        SRL,
        SRA,
        OR,
        AND,

        // U Type
        LUI,
        AUIPC,

        // S Type
        SB,
        SH,
        SW,

        // J Type
        JAL,

        // B Type
        BEQ,
        BNE,
        BLT,
        BGE,
        BLTU,
        BGEU
    } InstrType;

    typedef struct {
        logic [4:0] rd;
        logic [2:0] funct3;
        logic [4:0] rs1;
        logic [4:0] rs2;
        logic [6:0] funct7;
    } R_Type;
    
    typedef struct {
        logic [4:0] rd;
        logic [2:0] funct3;
        logic [4:0] rs1;
        logic [31:0] imm;
    } I_Type;

    typedef struct {
        logic [31:0] imm;
        logic [2:0] funct3;
        logic [4:0] rs1;
        logic [4:0] rs2;
    } S_Type;

    typedef struct {
        logic [31:0] imm;
        logic [2:0] funct3;
        logic [4:0] rs1;
        logic [4:0] rs2;
    } B_Type;

    typedef struct {
        logic [4:0] rd;
        logic [31:0] imm;
    } U_Type;
    
    typedef struct {
        logic [4:0] rd;
        logic [31:0] imm;
    } J_Type;
    
    typedef struct {
        InstrType ty;
        R_Type r_type;
        I_Type i_type;
        S_Type s_type;
        B_Type b_type;
        U_Type u_type;
        J_Type j_type;
    } Instr;
endpackage
