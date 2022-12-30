`timescale 1ns/1ns
`define N 10 // delay of beverages delivering
`define M 20 // delay of change delivering

module Fsm (fsm_intf intf);
//module Fsm (clk, rst, coin_in, button_in, change_out, beverage_out);
//input clk, rst, coin_in, button_in;
//output change_out, beverage_out;

//logic [2:0] state;
//reg[15:0] c;							// Money counter
/*
reg[15:0] coin_in;						// ASSUMPTION: At the beginnning coin_in = X
//reg[15:0] coin;
reg[1:0] button_in;						
reg[15:0] change_out;					// ASSUMPTION: At the beginning change_out = X
reg[1:0] beverage_out;
*/

reg[15:0] count_water = 16'd0;
reg[15:0] count_soda = 16'd0;
reg[15:0] count_no_money = 16'd0;
reg[15:0] count_change = 16'd0;
reg[15:0] count_no_change = 16'd0;

localparam add_coin = 3'b000; 			// Initial state
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
    end else begin
    	case (intf.state)
			add_coin: begin
        	// ASSUMPTION: Once the coin is in, there is no going back.
				if(intf.c >= 16'd30 && intf.button_in==2'b01) begin 					// User has chosen WATER
					//#`N intf.state <= water;
					intf.state <= wait_water;
				end else if(intf.c >= 16'd50 && intf.button_in==2'b11) begin			// User has chosen SODA
					//#`N intf.state <= soda;
					intf.state <= wait_soda;
				end else if(intf.button_in == 2'b00 &&							// User is accumulating MONEY
					(intf.coin_in == 16'd10 ||intf.coin_in == 16'd20 ||intf.coin_in == 16'd50 ||intf.coin_in == 16'd100 ||intf.coin_in == 16'd200))begin
					intf.c <= intf.c + intf.coin_in;
					intf.state <= add_coin;
					if (intf.c < 16'd30) begin
						count_no_money <= count_no_money + 1;
					end
				end else begin
					intf.state <= add_coin; // Machine ignores every non-admissible input.
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
					#`M intf.change_out <= intf.c;
					intf.state <= credit0;
				end else begin
					intf.state <= add_coin;
					count_no_change = count_no_change + 1;
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
