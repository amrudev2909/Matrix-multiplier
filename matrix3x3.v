`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2024 05:02:40
// Design Name: 
// Module Name: matrix3x3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module matrix_multiplier (
    input clk,
    input reset,
    input start,
    input [7:0] in,
   
    output reg [15:0] o, 
    output reg done
);
 localparam
        IDLE = 2'b00,
        LOAD = 2'b01,
        CALC = 2'b10,
        DONE = 2'b11;
        
    reg [1:0] state, next_state;
    reg [4:0] count;
    
    
    reg [7:0] a[8:0];
    reg [7:0] b[8:0];
    reg [15:0] c[8:0]; 
    
    integer i, j, k;
    
    // FSM state 
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end
    always @* begin
        case (state)
            IDLE: begin
                if (start == 0)
                    next_state = IDLE;
                else
                    next_state = LOAD;
            end
            
            LOAD: begin
                if (count < 18)
                    next_state = LOAD;
                else
                    next_state = CALC;
            end
            
            CALC: begin
                next_state = DONE;
            end
            
            DONE: begin
                if (count < 9)
                    next_state = DONE;
                else
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
            count <= 0;
            o <= 0;
            for (i = 0; i < 9; i = i + 1) begin
                a[i] <= 0;
                b[i] <= 0;
                c[i] <= 0;
            end
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    count <= 0;
                    o <= 0;
                end
                
                LOAD: begin
                    if (count < 9) begin
                        a[count] <= in;
                    end else begin
                        b[count - 9] <= in;
                    end
                    count <= count + 1;
                end
                
                CALC: begin
                    for (i = 0; i < 3; i = i + 1) begin
                        for (j = 0; j < 3; j = j + 1) begin
                            c[i * 3 + j] = 0;
                            for (k = 0; k < 3; k = k + 1) begin
                                c[i * 3 + j] = c[i * 3 + j] + (a[i * 3 + k] * b[k * 3 + j]);
                            end
                        end
                    end
                    count <= 0;
                end
                
                DONE: begin
                    o <= c[count];
                    count <= count + 1;
                    if (count >= 8) begin
                        done <= 1;
                    end
                end
                
                default: begin
                    done <= 0;
                end
            endcase
        end
    end
    
endmodule