`timescale 1ns/1ns
`define N 10 // Delay of beverages delivery in terms of clk cycles: 1*10
`define M 20 // Delay of change delivery in terms of clk cycles: 2*10

module Fsm (clk, rst, coin_in, button_in, change_out, beverage_out);
input clk, rst, coin_in, button_in;
output change_out, beverage_out;

logic [2:0] state;
reg[15:0] c;

reg[15:0] coin_in;
reg[1:0] button_in;						
reg[15:0] change_out;
reg[1:0] beverage_out;

localparam add_coin = 3'b000;
localparam water = 3'b001;
localparam soda = 3'b010;
localparam change = 3'b011;
localparam credit0 = 3'b100;
localparam wait_water = 3'b101;
localparam wait_soda = 3'b110;

always_ff @(posedge clk or rst) begin
    if(rst)begin
    	c <= 16'd0;
    	beverage_out <= 2'b00;
    	state <= add_coin;
    end
	else begin
    	case (state)
			add_coin: begin
				// The user has chosen water
				if(c >= 16'd30 && button_in==2'b01) begin
					state <= wait_water;
				end
				// The user has chosen soda
				else if(c >= 16'd50 && button_in==2'b11) begin
					state <= wait_soda;
				end
				// The user is accumulating credit
				else if(coin_in == 16'd10 ||coin_in == 16'd20 ||coin_in == 16'd50 ||coin_in == 16'd100 ||coin_in == 16'd200) begin
					c <= c + coin_in;
					state <= add_coin;
				end
				// The machine ignores every inadmissible input
				else begin
					state <= add_coin;
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
			wait_water: begin
				#`N state <= water;
			end
			wait_soda: begin
				#`N state <= soda;
			end
    	endcase
    end
end 
endmodule
