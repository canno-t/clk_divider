`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2026 21:43:04
// Design Name: 
// Module Name: clk_divider
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


module clk_divider#(
parameter f=1,//wyjsciowa czestotliwosc zegara
parameter clk_freq = 27000000,//czetotliwosc uzywanego zegara
parameter cnt = (clk_freq/(2*f))//
)(
    input clk,
    input res,
    output reg out
    );
    reg [$clog2(cnt)-1:0] count;
    
    always@(posedge clk)begin
        if(!res)begin
            out<=0;
            count<=0;
        end 
        else begin
            if(count==cnt-1)begin
                count<=0;
                out<=~out;
            end 
            else begin
                count<=count+1;
            end
        end 
    end 
endmodule
