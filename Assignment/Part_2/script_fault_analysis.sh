rm -rf work 
vlib work
vlog +incdir+tb/ -sv tb/testbench.sv rtl/fsm.sv -cuname assertions -mfcu assertions/*.sv

# coin_in is stuck at 50
vsim -voptargs=+acc -c work.tbench_top -do "force tbench_top.intf.coin_in[15:0] 16'd50; run -all; exit"

# button_in is stuck at 00
#vsim -voptargs=+acc -c work.tbench_top -do "force tbench_top.intf.button_in[1:0] 2'b00; run -all; exit"
gtkwave fsm.vcd fsm.gtkw
