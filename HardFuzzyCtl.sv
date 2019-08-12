module HardFuzzyCtl(/*UsrDefineMF1D1,UsrDefineMF2D1,UsrDefineMF3D1,UsrDefineMF3D2*/,TriggerPin,TestOut,ErrorList);
	//==========================================================================================================
	// Base Value
	//==========================================================================================================
	localparam integer SensorGet_LimitBit     = 10;  //感測器資料上限

   localparam integer VerticalSet_LimitBit   = 10;  //垂直軸資訊
										
	localparam integer HorizontalSet_LimitBit = 10;  //水平軸單位值

	//==========================================================================================================
	// PinData
	//==========================================================================================================
   input TriggerPin;  //Enable Pin
 
   output TestOut;    //Test Use Out Pin [UnProject]
 
   output [11 : 0]ErrorList; //錯誤資訊列表
	  

   //==========================================================================================================
	// Usr Define Value
	//==========================================================================================================

   //Parameter Of Mumbership Function 1 
   int MF1Sum   = 4;
   int MF1Dim   = 1;
   int UsrDefineMF1FN1D1Range [3 : 0];
   int UsrDefineMF1FN2D1Range [3 : 0];
   int UsrDefineMF1FN3D1Range [3 : 0];
   int UsrDefineMF1FN4D1Range [3 : 0];
	
   localparam MF1ShiftD1           = 1'b0;
   localparam MF1D1BaseBound_limit = 10;
   localparam MF1D1BaseUpBound     = 10'b1111111111;
   localparam MF1D1BaseDownBound   = 10'b0000000000;
   localparam MF1D1ShiftVlaue      = 10'b0000000000;
   localparam OutMF1D1FN           = 4'b0000;
   
   //Parameter Of Mumbership Function 2
   int MF2Sum   = 3;
   int MF2Dim   = 1;
   int UsrDefineMF2FN1D1Range [3 : 0];
   int UsrDefineMF2FN2D1Range [3 : 0];
   int UsrDefineMF2FN3D1Range [3 : 0];
	
   localparam MF2ShiftD1           = 1'b0;
   localparam MF2D1BaseBound_limit = 10;
   localparam MF2D1BaseUpBound     = 10'b1111111111;
   localparam MF2D1BaseDownBound   = 10'b0000000000;
   localparam MF2D1ShiftVlaue      = 10'b0000000000;
   localparam OutMF2D1FN           = 3'b000;

   //Parameter Of Mumbership Function 3
   int MF3Sum = 2;
   int MF3Dim = 2;
   int UsrDefineMF3FN1D1Range [3 : 0];
   int UsrDefineMF3FN1D2Range [3 : 0];
   int UsrDefineMF3FN2D1Range [3 : 0];
   int UsrDefineMF3FN2D2Range [3 : 0];
	
   localparam MF3ShiftD1           = 1'b0;
   localparam MF3ShiftD2           = 1'b0;
   localparam MF3D1BaseBound_limit = 10;
   localparam MF3D2BaseBound_limit = 10;
   localparam MF3D1BaseUpBound     = 10'b1111111111;
   localparam MF3D1BaseDownBound   = 10'b0000000000;
   localparam MF3D2BaseUpBound     = 10'b1111111111;
   localparam MF3D2BaseDownBound   = 10'b0000000000;
   localparam MF3D1ShiftVlaue      = 10'b0000000000;
   localparam MF3D2ShiftVlaue      = 10'b0000000000;
   localparam OutMF3D1FN           = 2'b00;
   localparam OutMF3D2FN           = 2'b00;
	
   //==========================================================================================================
	// Usr Define PinData
	//==========================================================================================================
	/*
	input [SensorGet_LimitBit-1:0]UsrDefineMF1D1; //FN1D1輸入資料值
   input [SensorGet_LimitBit-1:0]UsrDefineMF2D1; //FN2D1輸入資料值
   input [SensorGet_LimitBit-1:0]UsrDefineMF3D1; //FN3D1輸入資料值
   input [SensorGet_LimitBit-1:0]UsrDefineMF3D2; //FN3D2輸入資料值
	*/
	//==========================================================================================================
	// Methods Define
	//==========================================================================================================
   
   //SensorGet #(SensorGet_LimitBit, MF1D1BaseBound_limit, MF1D1BaseUpBound,MF1D1BaseDownBound,MF1D1ShiftVlaue) SensorGetInMF1D1(UsrDefineMF1___D1, FixedMF1___D1, ErrorReturn); //(UsrDefineMF1FN1D1, FixedMF1FN1D1, ErrorList[10:9])
   
	//==========================================================================================================
	// Event
	//==========================================================================================================
   
	initial begin
      UsrDefineMF1FN1D1Range[0]  =  0; UsrDefineMF1FN1D1Range[1]  =  1; UsrDefineMF1FN1D1Range[2]  =  2; UsrDefineMF1FN1D1Range[3]  =  3;
      UsrDefineMF1FN2D1Range[0]  =  2; UsrDefineMF1FN2D1Range[1]  =  3; UsrDefineMF1FN2D1Range[2]  =  5; UsrDefineMF1FN2D1Range[3]  =  7;
      UsrDefineMF1FN3D1Range[0]  =  6; UsrDefineMF1FN3D1Range[1]  =  8; UsrDefineMF1FN3D1Range[2]  = 10; UsrDefineMF1FN3D1Range[3]  = 12;
		UsrDefineMF1FN4D1Range[0]  = 11; UsrDefineMF1FN4D1Range[1]  = 14; UsrDefineMF1FN4D1Range[2]  = 16; UsrDefineMF1FN4D1Range[3]  = 20;

      UsrDefineMF2FN1D1Range[0]  =  2; UsrDefineMF2FN1D1Range[1]  =  3; UsrDefineMF2FN1D1Range[2]  =  5; UsrDefineMF2FN1D1Range[3]  =  7;
      UsrDefineMF2FN2D1Range[0]  =  3; UsrDefineMF2FN2D1Range[1]  =  7; UsrDefineMF2FN2D1Range[2]  =  9; UsrDefineMF2FN2D1Range[3]  = 11;
      UsrDefineMF2FN3D1Range[0]  =  6; UsrDefineMF2FN3D1Range[1]  =  8; UsrDefineMF2FN3D1Range[2]  = 10; UsrDefineMF2FN3D1Range[3]  = 12;
	
      UsrDefineMF3FN1D1Range[0]  =  0; UsrDefineMF3FN1D1Range[1]  =  2; UsrDefineMF3FN1D1Range[2]  =  2; UsrDefineMF3FN1D1Range[3]  =  4;
      UsrDefineMF3FN2D1Range[0]  =  3; UsrDefineMF3FN2D1Range[1]  =  8; UsrDefineMF3FN2D1Range[2]  = 10; UsrDefineMF3FN2D1Range[3]  = 12;
      UsrDefineMF3FN1D2Range[0]  =  1; UsrDefineMF3FN1D2Range[1]  =  2; UsrDefineMF3FN1D2Range[2]  =  3; UsrDefineMF3FN1D2Range[3]  =  7;
      UsrDefineMF3FN2D2Range[0]  =  6; UsrDefineMF3FN2D2Range[1]  =  8; UsrDefineMF3FN2D2Range[2]  =  9; UsrDefineMF3FN2D2Range[3]  = 13;
		
		TestOut = 1'b0;
    end
	 
	always@(posedge TriggerPin) begin
		TestOut = 1'b1;
		//SensorGetInMF1D1()
	end
endmodule
