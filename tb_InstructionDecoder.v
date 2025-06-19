`timescale 1ns / 1ps

module tb_InstructionDecoder();
    reg [7:0] instruction;
    wire [3:0] opcode;
    wire [1:0] reg_a_addr, reg_b_addr;
    wire [3:0] imm_value;
    wire is_immediate;
    
    InstructionDecoder id (
        .instruction(instruction),
        .opcode(opcode),
        .reg_a_addr(reg_a_addr),
        .reg_b_addr(reg_b_addr),
        .imm_value(imm_value),
        .is_immediate(is_immediate)
    );
    
    initial begin
        instruction = 8'b0010_01_10;
        #10;
        if (opcode !== 4'b0010) $error("ADD opcode failed");
        if (reg_a_addr !== 2'b01) $error("reg_a_addr failed");
        if (reg_b_addr !== 2'b10) $error("reg_b_addr failed");
        if (is_immediate !== 1'b0) $error("is_immediate failed");

        // Test immediate operation (e.g., LOADI)
        instruction = 8'b0001_11_01;  // OP=0001 (LOADI), reg_a=11, imm=01
        #10;
        if (opcode !== 4'b0001) $error("LOADI opcode failed");
        if (reg_a_addr !== 2'b11) $error("reg_a_addr failed");
        if (imm_value !== 4'b0001) $error("imm_value failed");
        if (is_immediate !== 1'b1) $error("is_immediate failed");

        $display("All tests passed!");
        $finish;
    end
endmodule
