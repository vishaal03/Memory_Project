# Memory_Project
Basic Memory Project

# Parameterized Synchronous SRAM with Handshake Protocol

This repository contains a synthesizable, parameterized **Static RAM (SRAM)** design in Verilog. Unlike a basic memory array, this implementation uses a `valid_i` / `ready_o` handshake protocol to ensure synchronized data transfers between a master controller and the memory block.



## Features
- **Parameterized Architecture:** Easily configure `WIDTH` and `DEPTH` via module parameters.
- **Handshake Logic:** Integrated `valid_i` (input valid) and `ready_o` (output ready) signals for flow control.
- **Synchronous Reset:** Includes a synchronous reset (`rst_i`) that clears the entire memory array.
- **Automated Testbench:** Includes a comprehensive testbench (`memory_tb.v`) with:
  - Randomized data generation using `$urandom`.
  - Automated `write_mem` and `read_mem` tasks.
  - Runtime command support via plusargs (`+command`).

---

##  Hardware Interface

### Port Descriptions
| Signal | Width | Direction | Description |
| :--- | :--- | :--- | :--- |
| `clk_i` | 1 | Input | System Clock |
| `rst_i` | 1 | Input | Synchronous Reset (Active High) |
| `wr_rd` | 1 | Input | Operation Mode: 1 for Write, 0 for Read |
| `valid_i`| 1 | Input | Asserted by Master when data/address is valid |
| `ready_o`| 1 | Output | Asserted by Memory when it accepts the operation |
| `addr_i` | `ADDR` | Input | Address bus (Default: 6 bits for 64 locations) |
| `write_i`| `WIDTH`| Input | Data input bus (Default: 16 bits) |
| `read_o` | `WIDTH`| Output | Data output bus (Default: 16 bits) |



---

## File Structure
- `memory_design.v`: The core memory logic with parameterized array and control logic.
- `memory_tb.v`: The top-level testbench containing verification logic and simulation tasks.

---

##  Simulation Guide

### Prerequisites
You will need a Verilog simulator like **Icarus Verilog**, **ModelSim**, or **Vivado**.

### Running Simulation (MODEL SIM OR QUESTA SIM)
To compile and run the testbench with a specific command (e.g., WRITE):


