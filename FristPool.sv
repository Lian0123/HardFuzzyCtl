
module FristPool(clk,InData,TmpNN);
	parameter Row_Limit   = 10;
	parameter WindowsSize =  3;
	parameter ComputRow   =  2;
	
	//==========================================================
	// Prot Define
	//==========================================================
	input  bit      clk;
	input  [Row_Limit*Row_Limit-1:0]    InData;
	output [5*Row_Limit*Row_Limit-1:0]  TmpNN;
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int i          = 0 ; // Define The IndexOf Value i
	int j          = 0 ; // Define The IndexOf Value j
	
	//==========================================================================================================
	// Init Event
	//==========================================================================================================
	initial begin
		//Defult Setting Not Error Return
		TmpNN = 0;
	end
	
	//==========================================================================================================
	// Alway Comb Event
	//==========================================================================================================
	always@(posedge clk) begin
		for(i=0;i<ComputRow;i=i+1) begin
			for(j=0;j<ComputRow;j=j+1) begin						
				// AND
				if(InData[(i+0)*Row_Limit+(j+0)] == 1'b1 & InData[(i+0)*Row_Limit+(j+1)] == 1'b1 & InData[(i+0)*Row_Limit+(j+2)] == 1'b1 & InData[(i+1)*Row_Limit+(j+0)] == 1'b1 & InData[(i+1)*Row_Limit+(j+1)] == 1'b1 & InData[(i+1)*Row_Limit+(j+2)] == 1'b1 & InData[(i+2)*Row_Limit+(j+0)] == 1'b1 & InData[(i+2)*Row_Limit+(j+1)] == 1'b1 & InData[(i+2)*Row_Limit+(j+2)] == 1'b1)
					TmpNN[2*Row_Limit*Row_Limit+ i] = 1'b1;
					
				// XOR or XNOR
				if(WindowsSize[0] == 1'b1)
					if(InData[(i+0)*Row_Limit+(j+0)] == 1'b1 ^ InData[(i+0)*Row_Limit+(j+1)] == 1'b1 ^ InData[(i+0)*Row_Limit+(j+2)] == 1'b1 ^ InData[(i+1)*Row_Limit+(j+0)] == 1'b1 ^ InData[(i+1)*Row_Limit+(j+1)] == 1'b1 ^ InData[(i+1)*Row_Limit+(j+2)] == 1'b1 ^ InData[(i+2)*Row_Limit+(j+0)] == 1'b1 ^ InData[(i+2)*Row_Limit+(j+1)] == 1'b1 ^ InData[(i+2)*Row_Limit+(j+2)] == 1'b1)
						TmpNN[1*Row_Limit*Row_Limit+ i] = 1'b1;
				else
					if(~(InData[(i+0)*Row_Limit+(j+0)] == 1'b1 ^ InData[(i+0)*Row_Limit+(j+1)] == 1'b1 ^ InData[(i+0)*Row_Limit+(j+2)] == 1'b1 ^ InData[(i+1)*Row_Limit+(j+0)] == 1'b1 ^ InData[(i+1)*Row_Limit+(j+1)] == 1'b1 ^ InData[(i+1)*Row_Limit+(j+2)] == 1'b1 ^ InData[(i+2)*Row_Limit+(j+0)] == 1'b1 ^ InData[(i+2)*Row_Limit+(j+1)] == 1'b1 ^ InData[(i+2)*Row_Limit+(j+2)] == 1'b1))
						TmpNN[1*Row_Limit*Row_Limit+ i] = 1'b1;
					
				// OR
				if(InData[(i+0)*Row_Limit+(j+0)] == 1'b1 | InData[(i+0)*Row_Limit+(j+1)] == 1'b1 | InData[(i+0)*Row_Limit+(j+2)] == 1'b1 | InData[(i+1)*Row_Limit+(j+0)] == 1'b1 | InData[(i+1)*Row_Limit+(j+1)] == 1'b1 | InData[(i+1)*Row_Limit+(j+2)] == 1'b1 | InData[(i+2)*Row_Limit+(j+0)] == 1'b1 | InData[(i+2)*Row_Limit+(j+1)] == 1'b1 | InData[(i+2)*Row_Limit+(j+2)] == 1'b1)
					TmpNN[0*Row_Limit*Row_Limit+ i] = 1'b1;
			end
		end
	end
endmodule 