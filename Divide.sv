module Divide(clk,subclk);
	//==========================================================================================================
	// Usr Define Parameter
	//==========================================================================================================
	parameter subclk_limit  = 4 ;
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int State = 0;
	
	//==========================================================================================================
	// PinData
	//==========================================================================================================
	input  bit clk;
	output [subclk_limit-1:0] subclk;
	
	//==========================================================================================================
	// Init Event
	//==========================================================================================================
	initial begin
		//Defult Setting Not Error Return
		State = 0;
	end
	
	//==========================================================================================================
	// Alway Comb Event
	//==========================================================================================================
	always@(posedge clk) begin
	/*
		case(State)
			4'b0000:subclk1 = 1b'1,subclk2 = 1b'1,subclk3 = 1b'1,subclk4 = 1b'1;
			4'b0001:subclk1 = 1b'1,subclk2 = 1b'1,subclk3 = 1b'1,subclk4 = 1b'0;
			4'b0010:subclk1 = 1b'1,subclk2 = 1b'1,subclk3 = 1b'0,subclk4 = 1b'1;
			4'b0011:subclk1 = 1b'1,subclk2 = 1b'1,subclk3 = 1b'0,subclk4 = 1b'0;
			4'b0100:subclk1 = 1b'1,subclk2 = 1b'0,subclk3 = 1b'1,subclk4 = 1b'1;
			4'b0101:subclk1 = 1b'1,subclk2 = 1b'0,subclk3 = 1b'1,subclk4 = 1b'0;
			4'b0110:subclk1 = 1b'1,subclk2 = 1b'0,subclk3 = 1b'0,subclk4 = 1b'1;
			4'b0111:subclk1 = 1b'1,subclk2 = 1b'0,subclk3 = 1b'0,subclk4 = 1b'0;
			4'b1000:subclk1 = 1b'0,subclk2 = 1b'1,subclk3 = 1b'1,subclk4 = 1b'1;
			4'b1001:subclk1 = 1b'0,subclk2 = 1b'1,subclk3 = 1b'1,subclk4 = 1b'0;
			4'b1010:subclk1 = 1b'0,subclk2 = 1b'1,subclk3 = 1b'0,subclk4 = 1b'1;
			4'b1011:subclk1 = 1b'0,subclk2 = 1b'1,subclk3 = 1b'0,subclk4 = 1b'0;
			4'b1100:subclk1 = 1b'0,subclk2 = 1b'0,subclk3 = 1b'1,subclk4 = 1b'1;
			4'b1101:subclk1 = 1b'0,subclk2 = 1b'0,subclk3 = 1b'1,subclk4 = 1b'0;
			4'b1110:subclk1 = 1b'0,subclk2 = 1b'0,subclk3 = 1b'0,subclk4 = 1b'1;
			4'b1111:subclk1 = 1b'0,subclk2 = 1b'0,subclk3 = 1b'0,subclk4 = 1b'0;
		endcase
		*/
		
		subclk = {~State[0],~State[1],~State[2],~State[3]};
		
		State = State + 1;
		
		if(State == 5'b10000)
			State = 0;
	end 
endmodule 