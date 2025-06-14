`timescale 1ns / 1ps

module ROM (
    input [3:0] address,
    output reg [7:0] data
);

    always @(*) begin
        case(address)
            4'h1: data = 8'b01000110; // MOV R1, 2
            4'h2: data = 8'b01001011; // MOV R2, 3
            4'h3: data = 8'b00000110; // ADD R0, R1 => Acc = 1 + 2 = 3
            default: data = 8'h00;
        endcase
    end

endmodule
