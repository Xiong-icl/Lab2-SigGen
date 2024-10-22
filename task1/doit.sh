#!/bin/sh

#open file for vbuddy
~/Documents/iac/lab0-devtools/tools/attach_usb.sh

# cleanup
rm -rf obj_dir
rm -f sinegen.vcd

#run Verilator to translate Verilog into C++ including the testbench
verilator -Wall --cc --trace sinegen.sv --exe sinegen.cpp

#build C++ project through 'make' automatically generated by Verilator
make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

# run the executable file
obj_dir/Vsinegen
