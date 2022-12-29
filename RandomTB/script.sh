vlib work && vlog -sv rtl/*.sv tb/*.sv
vsim -c -voptargs=+acc work.test -do "run -all; exit"
gtkwave fsm.vcd fsm.gtkw
