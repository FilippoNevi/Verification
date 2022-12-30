`define FSM tbench_top.DUT
`define N 10 // delay of beverages delivering
`define M 20 // delay of change delivering
`define CLK 10
`define K `N/`CLK
`define L `M/`CLK


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
				always(state==3'b101)|->nexttime[`K+2](beverage_out==2'b01);
				//always(state==3'b101 && c>=16'd30)|->nexttime[`K+2](beverage_out==2'b01); logically eq.
            endproperty
            property p1;
            	//(1) -> (1);
				always(state==3'b110)|->nexttime[`K+2](beverage_out==2'b11);          	
            endproperty
            property p2;
            	//(1) -> (1);
				always(state==3'b000 && c<16'd30)|->nexttime[1](state==3'b000);          	
            endproperty
            property p3;
            	//(1) -> (1);
            	// change && resto < 30 -> change_out < 30 && change_out > 0
				//always(c < 16'd30)|->nexttime[`L+2](change_out < 16'd30 && change_out > 16'd0);       	
            	//always(state == 3'b100)|->nexttime[1](change_out < 16'd30 && change_out > 16'd0);
				always(state == 3'b011)|->nexttime[1](change_out < 16'd30 && change_out > 16'd0);
            endproperty
            property p4;
				//always(state==2'b00)|->nexttime[1](out1); Resto diverso da zero
				always(c >= 16'd30 && state == 3'b011)|->nexttime[1](change_out == 16'd0);          	
            endproperty
    endclocking

	// STOPPED HERE.
	
    int p0ATCT=0; // AntecedentTrue ConsequentTrue
    cover property (ch1_clocking.p0) begin
        p0ATCT++;
    end
    int p1ATCT=0; // AntecedentTrue ConsequentTrue
    cover property (ch1_clocking.p1) begin
        p1ATCT++;
    end
    int p2ATCT=0; // AntecedentTrue ConsequentTrue
    cover property (ch1_clocking.p2) begin
        p2ATCT++;
    end
    int p3ATCT=0; // AntecedentTrue ConsequentTrue
    cover property (ch1_clocking.p3) begin
        p3ATCT++;
    end
    int p4ATCT=0; // AntecedentTrue ConsequentTrue
    cover property (ch1_clocking.p4) begin
        p4ATCT++;
    end

    final begin
        $display("p0ATCT: %d", p0ATCT);
        $display("p1ATCT: %d", p1ATCT);
        $display("p2ATCT: %d", p2ATCT);
        $display("p3ATCT: %d", p3ATCT);
        $display("p4ATCT: %d", p4ATCT);
	end

endchecker: Ch1
// Ch1(clk, coin_in, button_in, state, c, change_out, beverage_out);
bind `FSM
Ch1 ch1_instance(`FSM.intf.clk,`FSM.intf.coin_in,`FSM.intf.button_in,`FSM.intf.state,`FSM.intf.c,`FSM.intf.change_out,`FSM.intf.beverage_out);

