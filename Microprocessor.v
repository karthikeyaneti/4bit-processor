`timescale 1ns / 1ps

module Microprocessor (
    input clk,
    input reset
);

    // Wires and internal signals
    wire [7:0] instruction;
    wire [3:0] opcode;
    wire [3:0] reg_a, reg_b_or_imm;
    wire [3:0] data_a, data_b;
    wire [3:0] alu_result;
    wire pc_enable, pc_load;
    wire acc_load, rf_write;
    wire mem_read, mem_write;
    wire [2:0] alu_op;
    wire [3:0] accumulator_out;
    wire [3:0] regfile_out;
    wire imm;
    wire [3:0] pc_out;

    // Program Counter
    ProgramCounter pc (
        .clk(clk),
        .reset(reset),
        .pc_enable(pc_enable),
        .pc_load(pc_load),
        .pc_out(pc_out)
    );

    // Program ROM
    ROM rom (
        .address(pc_out),
        .data(instruction)
    );

    // Instruction Decoder
    InstructionDecoder decoder (
        .instruction(instruction),
        .opcode(opcode),
        .reg_a(reg_a),
        .reg_b_or_imm(reg_b_or_imm)
    );

    // Control Unit
    ControlUnit cu (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .imm(imm),
        .pc_enable(pc_enable),
        .acc_load(acc_load),
        .rf_write(rf_write),
        .alu_op(alu_op)
    );

    // Register File
    RegisterFile rf (
        .clk(clk),
        .reset(reset),
        .imm(imm),
        .write_enable(rf_write),
        .write_addr(reg_a),
        .write_data(reg_b_or_imm),
        .read_addr1(reg_a),
        .read_addr2(reg_b_or_imm),
        .read_data1(data_a),
        .read_data2(data_b)
    );

    // Accumulator
    Accumulator acc (
        .clk(clk),
        .reset(reset),
        .load(acc_load),
        .data_in(alu_result),
        .data_out(accumulator_out)
    );

    // ALU
    ALU alu (
        .A(data_a),
        .B(data_b),
        .opcode(alu_op),
        .result(alu_result)
    );

endmodule
