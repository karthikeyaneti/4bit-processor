module ControlUnit (
    input clk,
    input reset,
    input [3:0] opcode,
    output reg imm,
    output reg pc_enable,
    output reg acc_load,
    output reg rf_write,
    output reg [2:0] alu_op
);

    // FSM States
    reg [1:0] state;
    parameter FETCH = 2'b00,
              EXECUTE = 2'b01;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= FETCH;
        else begin
            case (state)
                FETCH: state <= EXECUTE;
                EXECUTE: state <= FETCH;
                default: state <= FETCH;
            endcase
        end
    end

    always @(*) begin
        // Default signal values
        pc_enable = 0;
        acc_load = 0;
        rf_write = 0;
        imm = 0;
        alu_op = 3'b000;

        case (state)
            FETCH: begin
                // Hold PC, wait for instruction to load from ROM
                pc_enable = 0;
            end

            EXECUTE: begin
                // Execute current instruction based on opcode
                pc_enable = 1; // Now allow PC to increment

                case (opcode)
                    4'b0000: begin // ADD
                        alu_op = 3'b000;
                        acc_load = 1;
                    end
                    4'b0001: begin // SUB
                        alu_op = 3'b001;
                        acc_load = 1;
                    end
                    4'b0010: begin // AND
                        alu_op = 3'b010;
                        acc_load = 1;
                    end
                    4'b0011: begin // OR
                        alu_op = 3'b011;
                        acc_load = 1;
                    end
                    4'b0100: begin // MOV immediate to register
                        alu_op = 3'b101;
                        imm = 1;
                        rf_write = 1;
                        acc_load = 1;
                    end
                    default: begin
                        alu_op = 3'b000;
                    end
                endcase
            end
        endcase
    end

endmodule
