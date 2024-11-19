#include "VTopCPU.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>

int main(int argc, char **argv, char **env)
{
    Verilated::commandArgs(argc, argv);
    VTopCPU *top = new VTopCPU;
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("TopCPU.vcd");

    top->clk = 0;
    top->rst = 1;

    for (int i = 0; i < 10000; i++)
    {
        top->clk = !top->clk; // Toggle clock
        top->eval();
        tfp->dump(2 * i);

        if (i == 2)
            top->rst = 0;
    }

    tfp->close(); // Ensure waveform file is closed
    delete top;
    return 0;
}
