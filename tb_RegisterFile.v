`timescale 1ns / 1ps

module tb_RegisterFile();

    reg clk;
    reg reset;
    reg write_enable;
    reg acc_write_enable;
    reg [1:0] write_addr;
    reg [3:0] write_data;
    reg [3:0] acc_in;
    reg [1:0] read_addr1;
    reg [1:0] read_addr2;

    wire [3:0] read_data1;
    wire [3:0] read_data2;
    wire [3:0] acc_out;

    RegisterFile uut (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .acc_write_enable(acc_write_enable),
        .write_addr(write_addr),
        .write_data(write_data),
        .acc_in(acc_in),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .acc_out(acc_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize
        reset = 1;
        write_enable = 0;
        acc_write_enable = 0;
        write_addr = 0;
        write_data = 0;
        acc_in = 0;
        read_addr1 = 0;
        read_addr2 = 0;
        #10;
        
        // Release reset
        reset = 0;
        #10;
        
        // === Test 1: Register Writes ===
        $display("Testing register writes...");
        write_enable = 1;
        write_addr = 2'b01;  // Write to R1
        write_data = 4'b1010;
        #10;
        read_addr1 = 2'b01;  // Read R1
        #1;
        if (read_data1 !== 4'b1010) $error("R1 write failed!");
        
        // === Test 2: Accumulator Writes ===
        $display("Testing accumulator writes...");
        write_enable = 0;
        acc_write_enable = 1;
        acc_in = 4'b1100;
        #10;
        if (acc_out !== 4'b1100) $error("Acc write failed!");
        
        // === Test 3: Read-During-Write (Bypass) ===
        $display("Testing read-during-write bypass...");
        write_enable = 1;
        acc_write_enable = 0;
        write_addr = 2'b10;  // Write to R2
        write_data = 4'b0011;
        read_addr1 = 2'b10;  // Simultaneous read R2
        #1;
        if (read_data1 !== 4'b0011) $error("Bypass failed!");
        
        // === Test 4: Reset ===
        $display("Testing reset...");
        reset = 1;
        #10;
        read_addr1 = 2'b01;  // Check R1
        read_addr2 = 2'b10;  // Check R2
        #1;
        if (read_data1 !== 0 || read_data2 !== 0 || acc_out !== 0) 
            $error("Reset failed!");
        
        // === Test 5: Multi-Port Reads ===
        $display("Testing multi-port reads...");
        reset = 0;
        write_enable = 1;
        write_addr = 2'b00;  // R0 = 0101
        write_data = 4'b0101;
        #10;
        write_addr = 2'b11;  // R3 = 1111
        write_data = 4'b1111;
        #10;
        read_addr1 = 2'b00;  // Read R0
        read_addr2 = 2'b11;  // Read R3
        #1;
        if (read_data1 !== 4'b0101 || read_data2 !== 4'b1111) 
            $error("Multi-read failed!");
        
        $display("All tests passed!");
        $finish;
    end
endmodule