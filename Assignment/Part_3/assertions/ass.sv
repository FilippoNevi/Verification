`define FSM tbench_top.DUT

checker Ch1(clk, coin_in, button_in, state, c, change_out, beverage_out);

    assert property (ch1_clocking.p0);
    assert property (ch1_clocking.p1);
    assert property (ch1_clocking.p2);
    assert property (ch1_clocking.p3);
    assert property (ch1_clocking.p4);

    clocking ch1_clocking @(posedge clk);
            property p0;													// p0ATCT
				always(state==3'b001)|->(nexttime[1](beverage_out==2'b01));
            endproperty
            property p0N_;													// p0AFCT
				always(state!=3'b001)|->(nexttime[1](beverage_out==2'b01));
            endproperty
            property p0_N;													// p0ATCF
				always(state==3'b001)|->(nexttime[1](beverage_out!=2'b01));
            endproperty
            property p0NN;													// p0AFCF
				always(state!=3'b001)|->(nexttime[1](beverage_out!=2'b01));
            endproperty
            
            property p1;													// p1ATCT
				always(state==3'b010)|->nexttime[1](beverage_out==2'b11);          	
            endproperty
            property p1N_;													// p1AFCT
				always(state!=3'b010)|->nexttime[1](beverage_out==2'b11);          	
            endproperty
            property p1_N;													// p1ATCF
				always(state==3'b010)|->nexttime[1](beverage_out!=2'b11);          	
            endproperty
            property p1NN;													// p1AFCF
				always(state!=3'b010)|->nexttime[1](beverage_out!=2'b11);          	
            endproperty
            
            property p2;													// p2ATCT
				always(state==3'b000 && c<16'd30)|->nexttime[1](state==3'b000);         	
            endproperty
            property p2N_;													// p2AFCT
				always(state!=3'b000 || c>=16'd30)|->nexttime[1](state==3'b000);    	
            endproperty
            property p2_N;													// p2ATCF
				always(state==3'b000 && c<16'd30)|->nexttime[1](state!=3'b000);    	
            endproperty
            property p2NN;													// p2AFCF
				always(state!=3'b000 || c>=16'd30)|->nexttime[1](state!=3'b000);    	
            endproperty
            
            property p3;													// p3ATCT
				always(state == 3'b100)|->(change_out < 16'd30 && change_out > 16'd0);
            endproperty
            property p3N_;													// p3AFCT
				always(state != 3'b100)|->(change_out < 16'd30 && change_out > 16'd0);
            endproperty
            property p3_N;													// p3ATCF
				always(state == 3'b100)|->(change_out >= 16'd30 || change_out == 16'd0);
            endproperty
             property p3NN;													// p3AFCF
				always(state != 3'b100)|->(change_out >= 16'd30 || change_out == 16'd0);
            endproperty
            
            property p4;													// p4ATCT
				always(c >= 16'd30 && state == 3'b011)|->nexttime[1](change_out == 16'd0);      	
            endproperty
            property p4N_;													// p4AFCT
				always((c >= 16'd0 && c < 16'd30) || state != 3'b011)|->nexttime[1](change_out == 16'd0);          	
            endproperty
            property p4_N;													// p4ATCF
				always(c >= 16'd30 && state == 3'b011)|->nexttime[1](change_out > 16'd0);         	
            endproperty
            property p4NN;													// p4AFCF
				always((c >= 16'd0 && c < 16'd30) || state != 3'b011)|->nexttime[1](change_out > 16'd0);          	
            endproperty
    endclocking
    
    // --------------------- ATCT --------------------------------------------------------------------------
    
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

	// --------------------- AFCT --------------------------------------------------------------------------

	int p0AFCT=0; // AntecedentFalse ConsequentTrue
    cover property (ch1_clocking.p0N_) begin
        p0AFCT++;
    end
    int p1AFCT=0; // AntecedentFalse ConsequentTrue
    cover property (ch1_clocking.p1N_) begin
        p1AFCT++;
    end
    int p2AFCT=0; // AntecedentFalse ConsequentTrue
    cover property (ch1_clocking.p2N_) begin
        p2AFCT++;
    end
    int p3AFCT=0; // AntecedentFalse ConsequentTrue
    cover property (ch1_clocking.p3N_) begin
        p3AFCT++;
    end
    int p4AFCT=0; // AntecedentFalse ConsequentTrue
    cover property (ch1_clocking.p4N_) begin
        p4AFCT++;
    end
	
	// --------------------- ATCF --------------------------------------------------------------------------
	
	int p0ATCF=0; // AntecedentTrue ConsequentFalse
    cover property (ch1_clocking.p0_N) begin
        p0ATCF++;
    end
    int p1ATCF=0; // AntecedentTrue ConsequentFalse
    cover property (ch1_clocking.p1_N) begin
        p1ATCF++;
    end
    int p2ATCF=0; // AntecedentTrue ConsequentFalse
    cover property (ch1_clocking.p2_N) begin
        p2ATCF++;
    end
    int p3ATCF=0; // AntecedentTrue ConsequentFalse
    cover property (ch1_clocking.p3_N) begin
        p3ATCF++;
    end
    int p4ATCF=0; // AntecedentTrue ConsequentFalse
    cover property (ch1_clocking.p4_N) begin
        p4ATCF++;
    end
    
	// --------------------- AFCF --------------------------------------------------------------------------

	int p0AFCF=0; // AntecedentFalse ConsequentFalse
    cover property (ch1_clocking.p0NN) begin
        p0AFCF++;
    end
    int p1AFCF=0; // AntecedentFalse ConsequentFalse
    cover property (ch1_clocking.p1NN) begin
        p1AFCF++;
    end
    int p2AFCF=0; // AntecedentFalse ConsequentFalse
    cover property (ch1_clocking.p2NN) begin
        p2AFCF++;
    end
    int p3AFCF=0; // AntecedentFalse ConsequentFalse
    cover property (ch1_clocking.p3NN) begin
        p3AFCF++;
    end
    int p4AFCF=0; // AntecedentFalse ConsequentFalse
    cover property (ch1_clocking.p4NN) begin
        p4AFCF++;
    end
	
    final begin
        $display("p0ATCT: %d", p0ATCT);
        $display("p1ATCT: %d", p1ATCT);
        $display("p2ATCT: %d", p2ATCT);
        $display("p3ATCT: %d", p3ATCT);
        $display("p4ATCT: %d\n", p4ATCT);
        
        $display("p0AFCT: %d", p0AFCT);
        $display("p1AFCT: %d", p1AFCT);
        $display("p2AFCT: %d", p2AFCT);
        $display("p3AFCT: %d", p3AFCT);
        $display("p4AFCT: %d\n", p4AFCT);
        
        $display("p0ATCF: %d", p0ATCF);
        $display("p1ATCF: %d", p1ATCF);
        $display("p2ATCF: %d", p2ATCF);
        $display("p3ATCF: %d", p3ATCF);
        $display("p4ATCF: %d\n", p4ATCF);
        
        $display("p0AFCF: %d", p0AFCF);
        $display("p1AFCF: %d", p1AFCF);
        $display("p2AFCF: %d", p2AFCF);
        $display("p3AFCF: %d", p3AFCF);
        $display("p4AFCF: %d\n", p4AFCF);
        
        $display("p0tot: %d", p0ATCT+p0AFCT+p0ATCF+p0AFCF);
        $display("p1tot: %d", p1ATCT+p1AFCT+p1ATCF+p1AFCF);
        $display("p2tot: %d", p2ATCT+p2AFCT+p2ATCF+p2AFCF);
        $display("p3tot: %d", p3ATCT+p3AFCT+p3ATCF+p3AFCF);
        $display("p4tot: %d\n", p4ATCT+p4AFCT+p4ATCF+p4AFCF);
	end

endchecker: Ch1

bind `FSM
Ch1 ch1_instance(`FSM.intf.clk,`FSM.intf.coin_in,`FSM.intf.button_in,`FSM.intf.state,`FSM.intf.c,`FSM.intf.change_out,`FSM.intf.beverage_out);
