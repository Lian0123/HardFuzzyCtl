module FuzzyMapping(InFixed,IsHit,LoaclFlag,LongBitData,ErrorReturn);

	//==========================================================================================================
	// Usr Define Parameter
	//==========================================================================================================
	parameter InData_limit  = 4  ; // Sum Of In Data Bit Limit
	parameter LongBit_limit = 10 ; // Sum Of Encode Long Bit Data Bit Limit
	parameter Node0			= 0  ; // Setting Input Fuzzy Number Of Node[0]
	parameter Node1			= 1  ; // Setting Input Fuzzy Number Of Node[1]
	parameter Node2			= 2  ; // Setting Input Fuzzy Number Of Node[2]
	parameter Node3			= 3  ; // Setting Input Fuzzy Number Of Node[3]
	
   //==========================================================================================================
	// Define Type
	//==========================================================================================================
	typedef bit [InData_limit-1:0]  _InputBitSum ; // The Type Of Input Data Struct Define
	typedef bit [LongBit_limit-1:0] _LongBitsSum ; // The Type Of Input Data Struct Define
	typedef bit [2:0]               _3BitsSum    ; // The Type Of Input Data Struct Define
	typedef bit                     _1BitsSum    ; // The Type Of Input Data Struct Define
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int i          = 0 ; // Define The IndexOf Value i
	int j          = 0 ; // Define The IndexOf Value j
	int Tmp        = 0 ; // Define The Input To Int32 Type Tmp Value
	int FN [3 : 0]     ; // Define The Int32 Type Fuzzy Number Array
	
	//==========================================================================================================
	// PinData
	//==========================================================================================================
	input  _InputBitSum InFixed     ; // Input Data Of Before SensorGet Layer
	output _1BitsSum    IsHit       ; // Output Data Of Test Out Range
	output _3BitsSum    LoaclFlag   ; // Output Data Of Encode LongBitData Local Flag
	output _LongBitsSum LongBitData ; // Output Data Of Encode LongBitData
	output _1BitsSum    ErrorReturn ; // Output Data Of Error Info Data
		
	//==========================================================================================================
	// Usr Define Function
	//==========================================================================================================
	
	/*
	 * |---------------------------------------------------------------------------------
	 * | [function] GetLongBitData
	 * |---------------------------------------------------------------------------------
	 * | Argument :
	 * |  [int32] DataSum  : The Base Of InData
	 * | 	[int32] RangeSum : The Base Of One Range
	 * |
	 * | Return :
	 * |	[LongBitsSum] GetLongBitData: Encode LongBit Data
	 * |
	 * | About :
	 * |	The Function Of Encode LongBit Data
	 * |
	 * 
	 */
	function _LongBitsSum GetLongBitData(int DataSum,int RangeSum);
			for(i = 0,j = 0; i < LongBit_limit; i = i + 1, j = j + 1) begin
				if(DataSum-RangeSum>=0)
					GetLongBitData[j] = 1;
				else
					GetLongBitData[j] = 0;
					
				DataSum = DataSum - RangeSum;
			end
			
		return GetLongBitData;
	endfunction
	
	//==========================================================================================================
	// Event
	//==========================================================================================================
	always@(*) begin
		/* Init Output Data */
		LoaclFlag   = 0;
		LongBitData = 0;
		ErrorReturn = 0;
		
		/* Let Data Mapping Data*LongBit_limit Range */
		Tmp = InFixed * LongBit_limit;
		FN[0] = Node0 * LongBit_limit;
		FN[1] = Node1 * LongBit_limit;
		FN[2] = Node2 * LongBit_limit;
		FN[3] = Node3 * LongBit_limit;
		
		/* Test InFix*/
		if(InFixed < 0)
			ErrorReturn = 1;
			
		/* OutRange Test */
		if(Tmp > FN[0] || Tmp < FN[3])
			IsHit = 1;
		
		/* UpPart Mapping Test */
		if(FN[0] <= Tmp && Tmp <= FN[1]) begin
			LoaclFlag[2] = 1;
			LongBitData = GetLongBitData(Tmp-FN[0],(FN[1]-FN[0])/LongBit_limit);
		end
		
		/* CorePart Mapping Test */
		if(FN[1] <= Tmp && Tmp <= FN[2]) begin
			LoaclFlag[1] = 1;
			LongBitData = GetLongBitData(LongBit_limit,1);
		end
		
		/* DownPart Mapping Test */
		if(FN[2] <= Tmp && Tmp <= FN[3]) begin
			LoaclFlag[0] = 1;
			LongBitData = GetLongBitData(FN[3]-Tmp,(FN[3]-FN[2])/LongBit_limit);
		end
		
	end
endmodule 