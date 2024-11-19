#!/bin/sh

# Cleanup
rm -rf obj_dir
rm -f TopCPU.vcd

# Compile
verilator -Wall --cc --trace TopCPU.sv PCModule.sv InstructionMemory.sv ControlUnit.sv SignExtender.sv RGALU.sv RegisterFile.sv ALU.sv --exe TopCPU_tb.cpp --top-module TopCPU


# Build
make -j -C obj_dir/ -f VTopCPU.mk VTopCPU

# Run
obj_dir/VTopCPU
