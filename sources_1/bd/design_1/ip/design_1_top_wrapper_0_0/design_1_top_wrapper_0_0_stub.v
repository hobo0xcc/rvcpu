// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue Jun 22 10:29:01 2021
// Host        : DESKTOP-OA7LPQJ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/slime/RISCV/RISCV.srcs/sources_1/bd/design_1/ip/design_1_top_wrapper_0_0/design_1_top_wrapper_0_0_stub.v
// Design      : design_1_top_wrapper_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "top_wrapper,Vivado 2020.1" *)
module design_1_top_wrapper_0_0(clk, reset, switch, led)
/* synthesis syn_black_box black_box_pad_pin="clk,reset,switch[3:0],led[3:0]" */;
  input clk;
  input reset;
  input [3:0]switch;
  output [3:0]led;
endmodule
