`timescale 1ns / 1ps

module ALU (
    input [3:0] A,
    input [3:0] B,
    input [2:0] opcode,
    output reg [3:0] result,
    output reg carry,
    output zero
);
    wire [4:0] sum = A + B;
    wire [4:0] diff = A - B;

    always @(*) begin
        carry = 0;
        case (opcode)
            3'b000: begin  // ADD
                result = sum[3:0];
                carry = sum[4];
            end
            3'b001: begin  // SUB
                result = diff[3:0];
                carry = diff[4];  // borrow
            end
            3'b010: result = A & B;
            3'b011: result = A | B;
            3'b100: result = A ^ B;
            3'b101: result = ~A;
            3'b110: result = A + 1;
            3'b111: result = A - 1;
            default: result = 4'b0000;
        endcase
    end

    assign zero = (result == 4'b0000);
endmodule

