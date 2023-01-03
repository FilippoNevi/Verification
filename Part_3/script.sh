rm -rf work 
vlib work
vlog +incdir+tb/ -sv tb/testbench.sv rtl/fsm.sv -cuname assertions -mfcu assertions/*.sv
vsim -voptargs=+acc -c work.tbench_top -do "run -all; exit"
gtkwave fsm.vcd fsm.gtkw
