`timescale 1ns / 1ps

module RegisterFile(
    input clk,
    input reset,
    input imm,
    input write_enable,
    input [3:0] write_addr,
    input [3:0] write_data,
    input [3:0] read_addr1,
    input [3:0] read_addr2,
    output [3:0] read_data1,
    output [3:0] read_data2
);
    reg [3:0] registers [3:0]; // 4 registers, 4-bit wide
    integer i;
    
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1)
                registers[i] <= 4'b0000;
        end
        else if (write_enable) begin
            registers[write_addr] <= {2'b00,write_data};
        end
    end

    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];
endmodule

