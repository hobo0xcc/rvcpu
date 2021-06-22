//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue Jun 22 10:24:59 2021
//Host        : DESKTOP-OA7LPQJ running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CLK,
    LED,
    RESET,
    SWITCH);
  input CLK;
  output [3:0]LED;
  input RESET;
  input [3:0]SWITCH;

  wire CLK;
  wire [3:0]LED;
  wire RESET;
  wire [3:0]SWITCH;

  design_1 design_1_i
       (.CLK(CLK),
        .LED(LED),
        .RESET(RESET),
        .SWITCH(SWITCH));
endmodule
