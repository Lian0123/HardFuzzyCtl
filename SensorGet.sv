module SensorGet(SensorGetValue, FixedValue, ErrorReturn);
	//==========================================================================================================
	// Base Value
	//==========================================================================================================
	parameter SensorGet_LimitBit =  10   ; // Limit     Bit
	parameter BaseUpBound        =  1024 ; // UpBound   Number
	parameter BaseDownBound      =  0    ; // DownBound Number
	parameter ShiftVlaue         =  10   ; // Offset    Number
	
	//==========================================================================================================
	// PinData
	//==========================================================================================================
   input     [SensorGet_LimitBit - 1 : 0]SensorGetValue; // The Sensor Get 
	
	wire      [SensorGet_LimitBit             : 0]Tester; //
	
	output    [SensorGet_LimitBit     - 1 : 0]FixedValue; //
	
	output    [1:0]ErrorReturn                          ; //
	
	//==========================================================================================================
	// Init Event
	//==========================================================================================================
	initial begin
		//Defult Setting Not Error Return
		ErrorReturn = 2'b00;
	end
	
	//==========================================================================================================
	// Alway Comb Event
	//==========================================================================================================
	always@(*) begin
		Tester = SensorGetValue - 0;
		
		//Out Max/Min Range Error		
		if(BaseUpBound > Tester || BaseDownBound < Tester )
			ErrorReturn[0] = 1'b1;
			
		//Out Overflow Error
		
		if(Tester[SensorGet_LimitBit] == 1'b1 || Tester < 0) 
			ErrorReturn[1] = 1'b1;
		
		//Out The Fix FixedValue
		FixedValue = Tester[SensorGet_LimitBit - 1 : 0];
		
	end
endmodule