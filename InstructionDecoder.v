`timescale 1ns / 1ps

module InstructionDecoder(
    input [7:0] instruction,
    output reg [3:0] opcode,
    output reg [1:0] reg_a_addr,
    output reg [1:0] reg_b_addr,
    output reg [3:0] imm_value,
    output reg is_immediate
    );
    
    always @(*) begin
        opcode = instruction[7:4];
        reg_a_addr = instruction[3:2];
        
        // Default: reg_b is a register address (not immediate)
        reg_b_addr = instruction[1:0];
        imm_value = {2'b00, instruction[1:0]};
        is_immediate = 1'b0;

        // Override for instructions using immediates (e.g., LOADI)
        case (opcode)
            4'b0001: begin          // LOADI
                is_immediate = 1'b1;
                imm_value = {2'b00, instruction[1:0]};
            end
            default: ;
        endcase
    end

endmodule