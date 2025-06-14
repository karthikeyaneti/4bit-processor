`timescale 1ns / 1ps

module InstructionDecoder(
    input [7:0] instruction,
    output [3:0] opcode,
    output [3:0] reg_a,
    output [3:0] reg_b_or_imm
    );
    
    assign opcode = instruction[7:4];
    assign reg_a = {2'b00, instruction[3:2]};
    assign reg_b_or_imm = {2'b00, instruction[1:0]};
    
endmodule
