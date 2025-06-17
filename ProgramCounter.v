`timescale 1ns / 1ps

module ProgramCounter #(parameter WIDTH = 4) (
    input clk,
    input reset,
    input pc_enable,
    input pc_load,
    input [WIDTH-1:0] pc_in,
    output reg [WIDTH-1:0] pc_out = 0
    );
    
    always @(posedge clk) begin
        if(reset)
            pc_out <= 0;
        else if(pc_load)
            pc_out <= pc_in;
        else if(pc_enable)
            pc_out <= pc_out + 1;
    end
endmodule
