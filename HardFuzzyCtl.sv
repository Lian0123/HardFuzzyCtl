`define Quartus_Module "ON" 

`ifndef Quartus_Module 
    `include "Divide.sv" 

    `include "SensorGet.sv" 
    `include "BaseCutLine.sv" 
    `include "DownDim.sv" 
    `include "FuzzyMapping.sv" 

    `include "FristPool.sv" 
    `include "ConvolutionUnit.sv" 
    `include "PoolUnit.sv" 
    `include "ReLuUnit.sv" 

    $display("Is Include Module\n"); 
`endif 


    /*
     *  Out Error Bus
     * |----------------------------------------------------------------
     * | [0] | Sensor Get Out Range Error
     * | --- + ---------------------------------------------------------
     * | [1] | Sensor Get Overflow Error
     * | --- + ---------------------------------------------------------
     * | [2] | 
     * |  ~  | Fuzzy Mapping Error (For MF0 to MFn)
     * | [k] |
     * |----------------------------------------------------------------
     */
    module HardFuzzyCtl(clk,clearError,ctlSave,dev1,dev2,dev3,dev4,dev5,OutBus,OutErrorBus);
        parameter FixValue    = 2;
        parameter RateValue   = 11;
        parameter DevValue    = 10;
        
        //==========================================================
        // Prot Define
        //==========================================================
        input  bit      clk;
        input  bit      clearError;
        input  [1:0]    ctlSave;
        
		input  [DevValue-1:0] dev1;
		input  [DevValue-1:0] dev2;
		input  [DevValue-1:0] dev3;
		input  [DevValue-1:0] dev4;
		input  [DevValue-1:0] dev5;

        output [6:0]    OutBus;
        output [6:0]    OutErrorBus;
	
        //==========================================================
        // SensorGet Wire
        //==========================================================
		wire      [1:0] SensorGetMF1Tester;
		wire      [RateValue-1:0] MF1FixValue;
		wire      [1:0] SensorGetMF2Tester;
		wire      [RateValue-1:0] MF2FixValue;
		wire      [1:0] SensorGetMF3Tester;
		wire      [RateValue-1:0] MF3FixValue;
		wire      [1:0] SensorGetMF4Tester;
		wire      [RateValue-1:0] MF4FixValue;
		wire      [1:0] SensorGetMF5Tester;
		wire      [RateValue-1:0] MF5FixValue;

        
        
        //==========================================================
        // FuzzyMapping Wire
        //==========================================================
		wire      [0:1+3+2+RateValue-1] MF1FN1Mapping;
		wire      [0:1+3+2+RateValue-1] MF1FN2Mapping;
		wire      [0:1+3+2+RateValue-1] MF1FN3Mapping;
		wire      [0:1+3+2+RateValue-1] MF1FN4Mapping;
		wire      [0:1+3+2+RateValue-1] MF2FN1Mapping;
		wire      [0:1+3+2+RateValue-1] MF2FN2Mapping;
		wire      [0:1+3+2+RateValue-1] MF2FN3Mapping;
		wire      [0:1+3+2+RateValue-1] MF3FN1Mapping;
		wire      [0:1+3+2+RateValue-1] MF3FN2Mapping;
		wire      [0:1+3+2+RateValue-1] MF4FN1Mapping;
		wire      [0:1+3+2+RateValue-1] MF4FN2Mapping;
		wire      [0:1+3+2+RateValue-1] MF4FN3Mapping;
		wire      [0:1+3+2+RateValue-1] MF5FN1Mapping;

        
        
        //==========================================================
        // SensorGet Layer
        //==========================================================
		SensorGet #(.SensorGet_LimitBit(DevValue),.BaseUpBound(1025),.BaseDownBound(0),.ShiftVlaue(FixValue)) SensorGetLayerForMF1(.SensorGetValue(dev1),.FixedValue(MF1FixValue),.ErrorReturn(SensorGetMF1Tester)); 
		SensorGet #(.SensorGet_LimitBit(DevValue),.BaseUpBound(1025),.BaseDownBound(0),.ShiftVlaue(FixValue)) SensorGetLayerForMF2(.SensorGetValue(dev2),.FixedValue(MF2FixValue),.ErrorReturn(SensorGetMF2Tester)); 
		SensorGet #(.SensorGet_LimitBit(DevValue),.BaseUpBound(1025),.BaseDownBound(0),.ShiftVlaue(FixValue)) SensorGetLayerForMF3(.SensorGetValue(dev3),.FixedValue(MF3FixValue),.ErrorReturn(SensorGetMF3Tester)); 
		SensorGet #(.SensorGet_LimitBit(DevValue),.BaseUpBound(1025),.BaseDownBound(0),.ShiftVlaue(FixValue)) SensorGetLayerForMF4(.SensorGetValue(dev4),.FixedValue(MF4FixValue),.ErrorReturn(SensorGetMF4Tester)); 
		SensorGet #(.SensorGet_LimitBit(DevValue),.BaseUpBound(1025),.BaseDownBound(0),.ShiftVlaue(FixValue)) SensorGetLayerForMF5(.SensorGetValue(dev5),.FixedValue(MF5FixValue),.ErrorReturn(SensorGetMF5Tester)); 

        
        //==========================================================
        // FuzzyMapping Layer
        //==========================================================
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(0),.Node1(1),.Node2(2),.Node3(4)) FuzzyMappingLayerForMF1FN1(.InFixed(MF1FixValue),.IsHit(MF1FN1Mapping[0]),.LoaclFlag(MF1FN1Mapping[1:3]),.LongBitData(MF1FN1Mapping[5:10+5-1]),.ErrorReturn(MF1FN1Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(3),.Node1(5),.Node2(6),.Node3(8)) FuzzyMappingLayerForMF1FN2(.InFixed(MF1FixValue),.IsHit(MF1FN2Mapping[0]),.LoaclFlag(MF1FN2Mapping[1:3]),.LongBitData(MF1FN2Mapping[5:10+5-1]),.ErrorReturn(MF1FN2Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(7),.Node1(9),.Node2(12),.Node3(15)) FuzzyMappingLayerForMF1FN3(.InFixed(MF1FixValue),.IsHit(MF1FN3Mapping[0]),.LoaclFlag(MF1FN3Mapping[1:3]),.LongBitData(MF1FN3Mapping[5:10+5-1]),.ErrorReturn(MF1FN3Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(12),.Node1(18),.Node2(22),.Node3(30)) FuzzyMappingLayerForMF1FN4(.InFixed(MF1FixValue),.IsHit(MF1FN4Mapping[0]),.LoaclFlag(MF1FN4Mapping[1:3]),.LongBitData(MF1FN4Mapping[5:10+5-1]),.ErrorReturn(MF1FN4Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(4),.Node1(6),.Node2(8),.Node3(10)) FuzzyMappingLayerForMF2FN1(.InFixed(MF2FixValue),.IsHit(MF2FN1Mapping[0]),.LoaclFlag(MF2FN1Mapping[1:3]),.LongBitData(MF2FN1Mapping[5:10+5-1]),.ErrorReturn(MF2FN1Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(8),.Node1(20),.Node2(80),.Node3(100)) FuzzyMappingLayerForMF2FN2(.InFixed(MF2FixValue),.IsHit(MF2FN2Mapping[0]),.LoaclFlag(MF2FN2Mapping[1:3]),.LongBitData(MF2FN2Mapping[5:10+5-1]),.ErrorReturn(MF2FN2Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(99),.Node1(102),.Node2(104),.Node3(106)) FuzzyMappingLayerForMF2FN3(.InFixed(MF2FixValue),.IsHit(MF2FN3Mapping[0]),.LoaclFlag(MF2FN3Mapping[1:3]),.LongBitData(MF2FN3Mapping[5:10+5-1]),.ErrorReturn(MF2FN3Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(0),.Node1(2),.Node2(4),.Node3(6)) FuzzyMappingLayerForMF3FN1(.InFixed(MF3FixValue),.IsHit(MF3FN1Mapping[0]),.LoaclFlag(MF3FN1Mapping[1:3]),.LongBitData(MF3FN1Mapping[5:10+5-1]),.ErrorReturn(MF3FN1Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(5),.Node1(8),.Node2(9),.Node3(11)) FuzzyMappingLayerForMF3FN2(.InFixed(MF3FixValue),.IsHit(MF3FN2Mapping[0]),.LoaclFlag(MF3FN2Mapping[1:3]),.LongBitData(MF3FN2Mapping[5:10+5-1]),.ErrorReturn(MF3FN2Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(0),.Node1(1),.Node2(2),.Node3(3)) FuzzyMappingLayerForMF4FN1(.InFixed(MF4FixValue),.IsHit(MF4FN1Mapping[0]),.LoaclFlag(MF4FN1Mapping[1:3]),.LongBitData(MF4FN1Mapping[5:10+5-1]),.ErrorReturn(MF4FN1Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(2),.Node1(3),.Node2(5),.Node3(7)) FuzzyMappingLayerForMF4FN2(.InFixed(MF4FixValue),.IsHit(MF4FN2Mapping[0]),.LoaclFlag(MF4FN2Mapping[1:3]),.LongBitData(MF4FN2Mapping[5:10+5-1]),.ErrorReturn(MF4FN2Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(4),.Node1(8),.Node2(9),.Node3(12)) FuzzyMappingLayerForMF4FN3(.InFixed(MF4FixValue),.IsHit(MF4FN3Mapping[0]),.LoaclFlag(MF4FN3Mapping[1:3]),.LongBitData(MF4FN3Mapping[5:10+5-1]),.ErrorReturn(MF4FN3Mapping[4])); 
		FuzzyMapping #(.InData_limit(DevValue),.LongBit_limit(RateValue),.Node0(0),.Node1(4),.Node2(8),.Node3(12)) FuzzyMappingLayerForMF5FN1(.InFixed(MF5FixValue),.IsHit(MF5FN1Mapping[0]),.LoaclFlag(MF5FN1Mapping[1:3]),.LongBitData(MF5FN1Mapping[5:10+5-1]),.ErrorReturn(MF5FN1Mapping[4])); 

        
        //==========================================================================================================
        // Init Event
        //==========================================================================================================
        initial begin
            OutBus = 0;
            OutErrorBus = 0;
        end

        //==========================================================================================================
        // Clk Event
        //==========================================================================================================
        always@(posedge clk) begin

			OutErrorBus[0] = (SensorGetMF1Tester[0] | SensorGetMF2Tester[0] | SensorGetMF3Tester[0] | SensorGetMF4Tester[0] | SensorGetMF5Tester[0]) & ~(clearError);
			OutErrorBus[1] = (SensorGetMF1Tester[1] | SensorGetMF2Tester[1] | SensorGetMF3Tester[1] | SensorGetMF4Tester[1] | SensorGetMF5Tester[1]) & ~(clearError);
			OutErrorBus[2] = (MF1FN1Mapping[4] | MF1FN2Mapping[4] | MF1FN3Mapping[4] | MF1FN4Mapping[4]) & ~(clearError);
			OutErrorBus[3] = (MF2FN1Mapping[4] | MF2FN2Mapping[4] | MF2FN3Mapping[4]) & ~(clearError);
			OutErrorBus[4] = (MF3FN1Mapping[4] | MF3FN2Mapping[4]) & ~(clearError);
			OutErrorBus[5] = (MF4FN1Mapping[4] | MF4FN2Mapping[4] | MF4FN3Mapping[4]) & ~(clearError);
			OutErrorBus[6] = (MF5FN1Mapping[4]) & ~(clearError);


        //Rule Connect

			//IF MF1_FN4 > 0.8 && MF2_FN3 == 0.5 && MF3_FN2 < 0.7 && MF4_FN2 == 0 && MF4_FN0 > 0.8 THEN 1
			if((MF1FN4Mapping[5+8+1] == 1'b1) && ( MF2FN3Mapping[5+5] == 1'b1 && MF2FN3Mapping[5+5+1] == 1'b0) && (MF3FN2Mapping[5+7] == 1'b0) && (MF4FN2Mapping[5+0] == 1'b1 && MF4FN2Mapping[5+1] == 1'b0) && (MF5FN1Mapping[5+8+1] == 1'b1) )
                OutBus[0] = 1'b1;
            else
                OutBus[0] = 1'b0;
            
			//IF MF1_FN3 > 0.5 || MF2_FN2 > 0.5 || MF3_FN1 > 0.8 || MF3_FN2 > 0.9 THEN 1
			if((MF1FN3Mapping[5+5+1] == 1'b1) || (MF2FN2Mapping[5+5+1] == 1'b1) || (MF3FN1Mapping[5+8+1] == 1'b1) || (MF3FN2Mapping[5+9+1] == 1'b1) )
                OutBus[1] = 1'b1;
            else
                OutBus[1] = 1'b0;
            
			//IF MF1_FN2 < 0.4 ^ MF1_FN3 < 0.7 ^ MF1_FN4 < 0.9 THEN 1
			if((MF1FN2Mapping[5+4] == 1'b0) ^ (MF1FN3Mapping[5+7] == 1'b0) ^ (MF1FN4Mapping[5+9] == 1'b0) )
                OutBus[2] = 1'b1;
            else
                OutBus[2] = 1'b0;
            
			//IF MF5_FN1 == 0.4 || MF3_FN2 == 0.9 THEN 1
			if( (MF5FN1Mapping[5+4] == 1'b1 && MF5FN1Mapping[5+4+1] == 1'b0) ||  (MF3FN2Mapping[5+9] == 1'b1 && MF3FN2Mapping[5+9+1] == 1'b0) )
                OutBus[3] = 1'b1;
            else
                OutBus[3] = 1'b0;
            
			//IF MF3_FN1 == 0.4 THEN 1
			if( (MF3FN1Mapping[5+4] == 1'b1 && MF3FN1Mapping[5+4+1] == 1'b0) )
                OutBus[4] = 1'b1;
            else
                OutBus[4] = 1'b0;
            
			//IF MF3_FN1 > 0.4 THEN 1
			if((MF3FN1Mapping[5+4+1] == 1'b1) )
                OutBus[5] = 1'b1;
            else
                OutBus[5] = 1'b0;
            
			//IF MF3_FN1 < 0.4 THEN 0
			if((MF3FN1Mapping[5+4] == 1'b0) )
                OutBus[6] = 1'b0;
            else
                OutBus[6] = 1'b1;
            
        
        end

    endmodule