`timescale 1ns / 1ps

module RegisterFile(
    input clk,
    input reset,
    input write_enable,
    input acc_write_enable,
    input [1:0] write_addr,
    input [3:0] write_data,
    input [3:0] acc_in,
    input [1:0] read_addr1,
    input [1:0] read_addr2,
    output reg [3:0] read_data1,
    output reg [3:0] read_data2,
    output reg [3:0] acc_out
);
    reg [3:0] registers [0:3];
    reg [3:0] accumulator;

    // Write logic (registers + accumulator)
    always @(posedge clk) begin
        if (reset) begin
            registers[0] <= 4'b0;
            registers[1] <= 4'b0;
            registers[2] <= 4'b0;
            registers[3] <= 4'b0;
            accumulator  <= 4'b0;
        end
        else begin
            if (write_enable) 
                registers[write_addr] <= write_data;
            if (acc_write_enable) 
                accumulator <= acc_in;
        end
    end

    always @(*) begin
        if (reset) begin
            read_data1 = 4'b0;
            read_data2 = 4'b0;
        end
        else begin
            if (write_enable && (write_addr == read_addr1))
                read_data1 = write_data;
            else
                read_data1 = registers[read_addr1];
            
            if (write_enable && (write_addr == read_addr2))
                read_data2 = write_data;
            else
                read_data2 = registers[read_addr2];
        end
        acc_out = accumulator;
    end
endmodule