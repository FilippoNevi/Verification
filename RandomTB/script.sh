export MGLS_LICENSE_FILE=1717@157.27.6.46
export PATH=$PATH:/home/paolo/Scrivania/modeltech/bin/
rm -rf work 

vlib work
vlog +incdir+tb/ -sv tb/testbench.sv rtl/fsm.sv -cuname assertions -mfcu assertions/*.sv
vsim -voptargs=+acc -c work.tbench_top -do "run -all; exit"
gtkwave fsm.vcd fsm.gtkw
