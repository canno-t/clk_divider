`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2026 21:43:21
// Design Name: 
// Module Name: clk_divider_tb
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


module clk_divider_tb(

    );
    
    
    reg clk;
    reg res;
    wire out;
    parameter clk_freq = 100;//10ms uzuwane w symulacji 100hz
    parameter f = 10;//przykladowa testowa wartosc
    clk_divider#(.clk_freq(clk_freq), .f(f)) dut(.clk(clk), .res(res), .out(out));
    reg ref;
    wire out1;
    parameter f1 = 25;//przykladowa testowa wartosc
    clk_divider#(.clk_freq(clk_freq), .f(f1)) dut1(.clk(clk), .res(res), .out(out1));
    reg ref1;
    
    initial begin
        clk = 0;
        res = 1;
        ref = 0;
        ref1 = 0;
    end 
    
    always #5 clk = ~clk;//T=10ms
    reg good = 1;
   
    
    
    initial begin
        //test resetu
        @(negedge clk)
        res = 0;
        @(posedge clk)
        #2
        res = 1;
        if(dut.count == 0 && out ==0)
        $display("TEST 1 - SUKCES - poprawny reset parametrow modulu");
        else
        $display("TEST 1 - FIAL - counter %d, out %d", dut.count, out);
        //test wyjscia
        @(negedge clk)
        res = 0;
        @(posedge clk)
        fork
        begin:loop2
        forever
        begin
         #50 ref = ~ref;
         end
        end
        begin:loop3
        forever
        begin
         #20 ref1 = ~ref1;
         end
        end
        begin
        begin:loop1
            repeat (100) begin
                @(negedge clk or posedge clk)
                #1//dodane do ustabilizowania bez tego mimo ze na wizualizacji widac ze dziala daje blad
                if (ref !== out) begin
                    good = 0;
                    $display("TEST 2 FAIL - dzielnik nie dziala poprawnie, time %t, ref %b, out %b", $time, ref, out);
                    //disable loop1;
                end
                else if(ref1!==out1)begin
                    good = 0;
                    $display("TEST 3 FAIL - dzielnik nie dziala poprawnie, time %t, ref %b, out %b", $time, ref1, out1);
                end
            end
            end
            disable loop2;
            disable loop3;
        end
        begin
        #2
        res = 1;
        end
    join
    if(good)
    $display("TEST 2 - SUKCES - poprawne dzialanie dzielnika");
               
     $finish;
    end 
endmodule
