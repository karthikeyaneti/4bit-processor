`timescale 1ns / 1ps

module Accumulator #(parameter WIDTH = 4) (
    input clk,
    input reset,
    input load,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
    );
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            data_out <= 0;
        else if(load)
            data_out <= data_in;
    end
    
endmodule
