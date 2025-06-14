`timescale 1ns / 1ps

module ProgramCounter #(parameter WIDTH = 4) (
    input clk,
    input reset,
    input pc_enable,
    input pc_load,
    input [WIDTH-1:0] pc_in,
    output reg [WIDTH-1:0] pc_out
    );
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            pc_out <= {WIDTH{1'b0}};
        else if(pc_load)
            pc_out <= pc_in;
        else if(pc_enable)
            pc_out <= pc_out + 1;
        else
            pc_out <= pc_out;
    end
endmodule
