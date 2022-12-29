`define FSM tbench_top.DUT

// module Fsm (clk, rst, coin_in, button_in, change_out, beverage_out); 
checker Ch1(clk, coin_in, button_in, state, c, change_out, beverage_out);

    assert property (ch1_clocking.p0);
    assert property (ch1_clocking.p1);
    assert property (ch1_clocking.p2);
    assert property (ch1_clocking.p3);
    assert property (ch1_clocking.p4);

    clocking ch1_clocking @(posedge clk);
            property p0;
            	//(1) -> (1);
				always(state==3'b000 && c>=16'd30 && button_in==2'b01)|->nexttime[3](beverage_out==01);    	
            endproperty
            property p1;
            	//(1) -> (1);
				always(state==3'b000 && c>=16'd50 && button_in==2'b11)|->nexttime[3](beverage_out==11);            	
            endproperty
            property p2;
            	//(1) -> (1);
				always(state==3'b000 && c<16'd30 && button_in==2'b00)|->nexttime[2](state==3'b000);           	
            endproperty
            property p3;
            	//(1) -> (1);
				//always(state==2'b00)|->nexttime[1](out1); Resto nullo           	
            endproperty
            property p4;
            	//(1) -> (1);
				//always(state==2'b00)|->nexttime[1](out1); Resto diverso da zero          	
            endproperty
    endclocking

	// STOPPED HERE.
	
    int p0ATCT=0; // AntecedentTrue ConsequentTrue
    cover property (ch1_clocking.p0) begin
        p0ATCT++;
    end

    final
        $display("p0ATCT: %d", p0ATCT);


endchecker: Ch1

bind `FSM Ch1 ch1_instance(`FSM.intf.clk,`FSM.intf.a,`FSM.intf.reset,`FSM.intf.out1,`FSM.intf.out2,`FSM.out3);
