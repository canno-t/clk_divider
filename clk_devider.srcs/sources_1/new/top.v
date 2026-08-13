`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2026 00:39:05
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input res,
    output [2:0]out
    );
    
    clk_divider#(.f(1)) div1(.clk(clk), .res(res), .out(out[0]));
    clk_divider#(.f(2)) div2(.clk(clk), .res(res), .out(out[1]));
    clk_divider#(.f(4)) div3(.clk(clk), .res(res), .out(out[2]));

endmodule
