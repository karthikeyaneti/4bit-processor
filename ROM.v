`timescale 1ns / 1ps

module ROM (
    input [3:0] address,
    output reg [7:0] data
);

    always @(*) begin
        case(address)
            4'h1: data = 8'b01000110; // MOV R1, 2
            4'h2: data = 8'b01001011; // MOV R2, 3
            4'h3: data = 8'b00000110; // ADD R1, R2 => Acc = 2 + 3 = 5
            4'h4: data = 8'b01001101; // MOV R3, 1
            4'h5: data = 8'b01000011; // MOV R0, 3
            4'h6: data = 8'b00010011; // SUB R3, R0 => Acc = 3 - 1 = 2
            default: data = 8'h00;
        endcase
    end

endmodule
