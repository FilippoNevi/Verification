`timescale 1ns/1ns
`define N 10 // delay of beverages delivering
`define M 20 // delay of change delivering

module Fsm (clk, rst, coin_in, button_in, change_out, beverage_out);
input clk, rst, coin_in, button_in;
output change_out, beverage_out;

logic [2:0] state;
reg[15:0] c;							// Money counter

reg[15:0] coin_in;						// ASSUMPTION: At the beginnning coin_in = X
//reg[15:0] coin;
reg[1:0] button_in;						
reg[15:0] change_out;					// ASSUMPTION: At the beginning change_out = X
reg[1:0] beverage_out;

localparam add_coin = 3'b000; 			// Initial state
localparam water = 3'b001;
localparam soda = 3'b010;
localparam change = 3'b011;
localparam credit0 = 3'b100;

parameter N = 10;
parameter M = 20;

always_ff @(posedge clk or rst) begin
    if(rst)begin
    	c <= 16'd0;
    	beverage_out <= 2'b00;
    	state <= add_coin;
    end else begin
    	case (state)
			add_coin: begin
        	// ASSUMPTION: Once the coin is in, there is no going back.
				if(c >= 16'd30 && button_in==2'b01) begin 					// User has chosen WATER
					#`N state <= water;
				end else if(c >= 16'd50 && button_in==2'b11) begin			// User has chosen SODA
					#`N state <= soda;
				end else if(button_in == 2'b00 &&							// User is accumulating MONEY
					(coin_in == 16'd10 ||coin_in == 16'd20 ||coin_in == 16'd50 ||coin_in == 16'd100 ||coin_in == 16'd200))begin
					c <= c + coin_in;
					state <= add_coin;
				end else begin
					state <= add_coin; // Machine ignores every non-admissible input.
				end
			end
        	water: begin
        		c <= c - 16'd30;
        		beverage_out <= 2'b01;
        		state <= change;
        	end
        	soda: begin
        		c <= c - 16'd50;
        		beverage_out <= 2'b11;
        		state <= change;
        	end
			change: begin
				beverage_out <= 2'b00;
				if(c < 16'd30) begin
					#`M change_out <= c;
					state <= credit0;
				end else begin
					state <= add_coin;
				end
			end
			credit0: begin
				c <= 16'd0;
				state <= add_coin;
				change_out <= 16'd0;
			end
    	endcase
    end
end 
endmodule	
