`timescale 1ns / 1ps

module tb_ProgramCounter();
    reg clk, reset, pc_enable, pc_load;
    reg [3:0] pc_in;
    wire [3:0] pc_out;

    ProgramCounter pc (.clk(clk), .reset(reset), .pc_enable(pc_enable),
                    .pc_load(pc_load), .pc_in(pc_in), .pc_out(pc_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1; pc_enable = 0; pc_load = 0; pc_in = 4'b0000;
        #10 reset = 0; pc_enable = 1;  // PC increments: 0→1→2→...
        #30 pc_load = 1; pc_in = 4'b1010;  // Jump to 10
        #10 pc_load = 0;
        #20 $finish;
    end
endmodule
