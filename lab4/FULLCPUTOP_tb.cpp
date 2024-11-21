#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VFULLCPUTOP.h"
#include <iostream>
#include <cstdio>

#define MAX_SIM_CYC 10000 // Maximum simulation cycles

int main(int argc, char **argv, char **env)
{
    int simcyc; // Simulation clock count
    int tick;   // Each clk cycle has two ticks (rising and falling edges)

    // Initialize Verilator command line arguments
    Verilated::commandArgs(argc, argv);

    // Create an instance of the VTOPcountercpu module
    VFULLCPUTOP *top = new VFULLCPUTOP;

    // Enable waveform tracing
    VerilatedVcdC *tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    top->trace(tfp, 99);
    tfp->open("lab4group.vcd");

    // Initialize simulation inputs
    top->clk = 0;
    top->rst = 0; // Reset initially asserted

    // Simulation loop
    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // Toggle clock for two ticks per cycle (rising and falling edges)
        for (tick = 0; tick < 2; tick++)
        {
            tfp->dump(2 * simcyc + tick); // Dump waveform
            top->clk = !top->clk;         // Toggle clock signal
            top->eval();                  // Evaluate the design
        }

        // Monitor outputs with formatted printf
        printf("Cycle %3d: clk = %d | rst = %d | Counter Value (a0) = 0x%08X\n",
               simcyc,
               top->clk,
               top->rst,
               static_cast<uint32_t>(top->a0));

        // Stop simulation if Verilated signals a finish
        if (Verilated::gotFinish())
            break;
    }

    // Close the waveform file and clean up
    tfp->close();
    delete top;
    delete tfp;

    return 0;
}
