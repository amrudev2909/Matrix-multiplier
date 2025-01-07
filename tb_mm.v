`timescale 1ns / 1ps
module tb_matrix_multiplier;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] in;
    wire [15:0] out;
    wire done;

    // Instantiate the matrix_multiplier module
    matrix_multiplier K (
        .clk(clk),
        .reset(reset),
        .start(start),
        .in(in),
        .o(out),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        start = 0;
        in = 0;
        
        #20;
        reset = 0;
        start = 1;
        
        // Feed matrix A
        in = 8'h01; #10;
        in = 8'h02; #10;
        in = 8'h03; #10;
        in = 8'h04; #10;
        in = 8'h05; #10;
        in = 8'h06; #10;
        in = 8'h07; #10;
        in = 8'h08; #10;
        in = 8'h09; #10;
        
        // Feed matrix B
        in = 8'h09; #10;
        in = 8'h08; #10;
        in = 8'h07; #10;
        in = 8'h06; #10;
        in = 8'h05; #10;
        in = 8'h04; #10;
        in = 8'h03; #10;
        in = 8'h02; #10;
        in = 8'h01; #10;

        start = 0;

        // Wait for done signal
        wait(done);

        // Display results
        for (integer i = 0; i < 9; i = i + 1) begin
            $display("c[%0d] = %0d", i, out);
            #10; // Assuming it takes 10 time units to output each result
        end
        
        $finish;
    end
endmodule
