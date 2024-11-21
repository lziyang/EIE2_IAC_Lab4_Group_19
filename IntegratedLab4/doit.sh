rm -rf obj_dir
rm -f FULLCPUTOP.vcd

verilator -Wall --cc --trace FULLCPUTOP.sv --exe FULLCPUTOP_tb.cpp

make -j -C obj_dir/ -f VFULLCPUTOP.mk VFULLCPUTOP

obj_dir/VFULLCPUTOP