`timescale 1ns/1ns
`define N 10 // Delay of beverages delivery ->	assumed to be 1*10 (1 clk cycle = 10 time units)
`define M 20 // Delay of change delivery 	->	assumed to be 2*10 (2 clk cycle = 20 time units)

module Fsm (fsm_intf intf);

reg[15:0] count_water = 16'd0;
reg[15:0] count_soda = 16'd0;
reg[15:0] count_no_money = 16'd0;
reg[15:0] count_change = 16'd0;
reg[15:0] count_no_change = 16'd0;

localparam add_coin = 3'b000;
localparam water = 3'b001;
localparam soda = 3'b010;
localparam change = 3'b011;
localparam credit0 = 3'b100;
localparam wait_water = 3'b101;
localparam wait_soda = 3'b110;

always_ff @(posedge intf.clk or intf.rst) begin
    if(intf.rst)begin
    	intf.c <= 16'd0;
    	intf.beverage_out <= 2'b00;
    	intf.state <= add_coin;
    	intf.change_out <= 16'd0;
    end else begin
    	case (intf.state)
			add_coin: begin
				// The user has chosen water
				if(intf.c >= 16'd30 && intf.button_in==2'b01) begin
					intf.state <= wait_water;
				end
				// The user has chosen soda
				else if(intf.c >= 16'd50 && intf.button_in==2'b11) begin
					intf.state <= wait_soda;
				end
				// The user is accumulating credit
				else if(intf.coin_in == 16'd10 ||intf.coin_in == 16'd20 ||intf.coin_in == 16'd50 ||intf.coin_in == 16'd100 ||intf.coin_in == 16'd200)begin
					intf.c <= intf.c + intf.coin_in;
					intf.state <= add_coin;
					if (intf.c < 16'd30) begin
						count_no_money <= count_no_money + 1;
					end
				end
				// The machine ignores every inadmissible input
				else begin
					intf.state <= add_coin;
					if (intf.c < 16'd30) begin
						count_no_money <= count_no_money + 1;
					end
				end
			end
        	water: begin
        		count_water <= count_water + 1;
        		intf.c <= intf.c - 16'd30;
        		intf.beverage_out <= 2'b01;
        		intf.state <= change;
        	end
        	soda: begin
        		count_soda <= count_soda + 1;
        		intf.c <= intf.c - 16'd50;
        		intf.beverage_out <= 2'b11;
        		intf.state <= change;
        	end
			change: begin
				intf.beverage_out <= 2'b00;
				if(intf.c < 16'd30 && intf.c > 16'd0) begin
					#`M intf.change_out <= intf.c; // *
					intf.state <= credit0;
				end else begin
					intf.state <= add_coin;
					if(intf.c >= 16'd30) begin
						count_no_change = count_no_change + 1;
					end
				end
			end
			credit0: begin
				count_change <= count_change + 1;
				intf.c <= 16'd0;
				intf.state <= add_coin;
				intf.change_out <= 16'd0;
			end
			wait_water: begin
				#`N intf.state <= water;
			end
			wait_soda: begin
				#`N intf.state <= soda;
			end
    	endcase
    end
end 
endmodule	
