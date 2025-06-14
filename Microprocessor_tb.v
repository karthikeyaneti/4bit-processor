`timescale 1ns / 1ps

module Microprocessor_tb;
    
    reg clk;
    reg reset;
    
    Microprocessor uut (.clk(clk), .reset(reset));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 1;
        #20;
        reset = 0;
        
        #200;
        
        $finish;
    end
endmodule
