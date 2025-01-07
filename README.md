# Matrix-multiplier

Overview
The matrix_multiplier module is a Verilog implementation of a finite state machine (FSM) designed to perform 3x3 matrix multiplication. The module accepts two 3x3 matrices as input, computes their product, and outputs the resulting matrix row by row.

## Features
## FSM Implementation:
A four-state FSM (IDLE, LOAD, CALC, DONE) controls the matrix multiplication process.
## Sequential Input:
The matrix elements are loaded sequentially through an 8-bit input.
## Matrix Multiplication:
Computes the resulting matrix using nested loops to handle the multiplication and accumulation.
## Result Output: 
Outputs the elements of the resulting 3x3 matrix sequentially via a 16-bit output port.
## Completion Signal:
A done signal indicates when the computation is complete.
## I/O Ports
## Inputs
## Signal Name	Width	Description
1. clk	1-bit	Clock signal for synchronizing operations.
2. reset	1-bit	Asynchronous reset signal to initialize or reset the module.
3. start	1-bit	Start signal to initiate matrix multiplication.
4. in	8-bit	Input port to load matrix elements sequentially.
## Outputs
Signal Name	Width	Description
1. o	16-bit	Output port for the computed matrix elements (row by row).
2. done	1-bit	Indicates the computation has completed.

## Module States

1. IDLE: Waits for the start signal. Resets internal variables and counters.
2. LOAD: Sequentially loads elements of the two input matrices a and b into internal registers.
3. CALC: Performs the 3x3 matrix multiplication using nested loops.
4. DONE: Outputs the elements of the resulting matrix sequentially and raises the done signal.

## Output Results:

The module transitions to the DONE state and outputs the elements of matrix c row by row through the 16-bit o port.
