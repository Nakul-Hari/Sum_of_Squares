# Sum of Squares Verilog Implementation

## Overview

This repository hosts a Verilog implementation of a digital system to compute the sum of squares of the first N natural numbers. The implementation utilizes hierarchical modeling, featuring a control path managed by a finite state machine (FSM) and a data path constructed from basic hardware components. This project aims to achieve an efficient and optimized sum of squares calculation while conserving hardware resources, suitable for FPGA and ASIC environments.

## Theory

### Sum of Squares Algorithm

The sum of squares of the first N natural numbers is given by the formula:

\[ \text{Sum of squares} = 1^2 + 2^2 + 3^2 + \ldots + N^2 \]

The algorithm iteratively computes the sum of squares by adding each squared natural number from 1 to N. This process involves nested loops: the outer loop manages the current number to be squared, and the inner loop accumulates the sum of the current number squared.

## Implementation

### Verilog Code

The Verilog code provided in this repository includes a hierarchical implementation of the sum of squares algorithm, divided into the following modules:

- **Top Module (`top_module`)**: Integrates the data path and control path modules.
- **Data Path Module (`datapath`)**: Performs the arithmetic operations required to compute the sum of squares.
- **Control Path Module (`controlpath`)**: Manages the state transitions and control signals using a finite state machine (FSM).
- **Testbench Module (`testbench`)**: Provides stimuli to verify the correctness of the design.

### Data Path

The data path module is responsible for the arithmetic computations. It includes registers for storing the current number (`i`), the sum (`sum`), and the loop variable (`j`). Multiplexers (MUXes) select the appropriate inputs for these registers based on control signals from the control path.

### Control Path

The control path module manages the state transitions using a finite state machine (FSM). The FSM includes the following states:

- **IDLE**: The initial state, waiting for a valid input.
- **BUSY**: Actively computing the sum of squares.
- **DONE**: The computation is complete, and the result is ready.

### Hierarchical Modeling

The design employs a hierarchical modeling approach, where the top module integrates the data path and control path modules. This modular approach enhances flexibility, making it easier to manage, test, and modify the design.

## Experimental Procedure

A testbench is used to verify the design by providing random inputs and checking the corresponding outputs. The testbench simulates the system's operation and generates output waveforms to validate the correctness of the implementation.

### Testbench

The testbench provides input stimuli to the top module and captures the output results. It verifies the functionality by comparing the computed sum of squares against the expected results.

## Conclusion

This Verilog-based digital system efficiently computes the sum of squares of the first N natural numbers using hierarchical modeling. The modular design approach enhances usability and ensures a robust implementation that can be easily tested and modified.

## Files in the Repository

- `EE5516_Assignment1_LabReport.pdf`: Lab Report Submitted for the following Code.
- `NSquareSum.v`: Verilog code for the Data path and Control path module.
- `NSquareSum_Testbench.v`: Verilog code for the testbench module.
- `README.md`: This readme file.

## Getting Started

1. Clone the repository
2. Open the Verilog files in your preferred Verilog simulator or FPGA development environment.
3. Run the testbench to verify the design.

## License

This project is licensed under the  Apache License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

This implementation is part of the lab work for the EE5516 VLSI Architectures for Signal Processing and Machine Learning course.
