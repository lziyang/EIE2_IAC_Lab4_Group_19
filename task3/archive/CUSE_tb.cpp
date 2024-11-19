#include "VCUSE.h" // Change this to match the generated top module
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env)
{
    Verilated::commandArgs(argc, argv); // Initialize Verilator
    VCUSE *top = new VCUSE;             // Create instance of the CUSE top module
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("CUSE.vcd");

    // Test ADDI instruction
    top->opcode = 0b0010011; // ADDI opcode
    top->imm12 = 0x7FF;      // Example immediate value for sign-extension
    top->eval();
    tfp->dump(0);

    // Check that reg_write is set, alu_src is set, and alu_control is for ADD
    assert(top->reg_write == 1);
    assert(top->alu_src == 1);
    assert(top->alu_control == 0);    // Expected ALU control for ADD
    assert(top->imm32 == 0x000007FF); // Expected sign-extended value of 12'h7FF, which is positive

    // Test BNE instruction
    top->opcode = 0b1100011; // BNE opcode
    top->imm12 = 0x0004;     // Example immediate value for sign-extension
    top->eval();
    tfp->dump(1);

    // Check that pc_src is set, and alu_control is for SUB
    assert(top->pc_src == 1);
    assert(top->alu_control == 1);    // Expected ALU control for SUB
    assert(top->imm32 == 0x00000004); // Expected sign-extended value of 12'h004, which is positive

    // Clean up and finish
    tfp->close();
    delete top;
    exit(0);
}
