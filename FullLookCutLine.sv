module FullLookCutLine(cut_line,x,y,z);

	parameter LongBits_limit = 10               ; // Sum Of The Data Bit

   //==========================================================================================================
	// Define Type
	//==========================================================================================================	
	typedef bit [LongBits_limit-1:0] LongBitSum ; // Make The LongBitSum Type
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int i = 0;
	
	//==========================================================================================================
	// PinData
	//==========================================================================================================
	input  LongBitSum cut_line ; // The Cut Line Ctl Data
	input  LongBitSum x        ; // The Input  X Data
	input  LongBitSum y        ; // The Input  Y Data
	output LongBitSum z        ; // The Output Z Data
	
	//==========================================================================================================
	// Alway Comb Event
	//==========================================================================================================
	always@(*) begin
		if(x<y) 
			for (i=0; i<LongBits_limit; i=i+1) begin
				if(i == 0)
					z[i] = (!cut_line[i] & (x[i] | ( y[i+1] & y[i] & 0) )) |  (cut_line[i] & (x[i] | y[i]));
				else if(i == LongBits_limit - 1)
					z[i] = (!cut_line[i] & (x[i] | ( 0 & y[i] & z[i-1] ) )) |  (cut_line[i] & (x[i] | y[i]));
				else
					z[i] = (!cut_line[i] & (x[i] | ( y[i+1] & y[i] & z[i-1] ) )) |  (cut_line[i] & (x[i] | y[i]));
			end
		else
			for (i=0; i<LongBits_limit; i=i+1) begin
				if(i == 0)
					z[i] = (!cut_line[i] & (y[i] | ( x[i+1] & x[i] & 0) )) |  (cut_line[i] & (x[i] | y[i]));
				else if(i == LongBits_limit - 1)
					z[i] = (!cut_line[i] & (y[i] | ( 0 & x[i] & z[i-1] ) )) |  (cut_line[i] & (x[i] | y[i]));
				else
					z[i] = (!cut_line[i] & (y[i] | ( x[i+1] & x[i] & z[i-1] ) )) |  (cut_line[i] & (x[i] | y[i]));
			end
	end
endmodule
