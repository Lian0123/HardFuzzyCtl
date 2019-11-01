module ReLuUnit(clk,InMatrix,OutMatrix); 
	parameter Row_Limit  = 10;
	
	input  bit  clk;
	input  [5*Row_Limit*Row_Limit-1:0]  InMatrix;
	output [5*Row_Limit*Row_Limit-1:0]  OutMatrix;
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int i          = 0 ; // Define The IndexOf Value i
	
	always@(posedge clk) begin
		OutMatrix = InMatrix;
		for (i=0; i<Row_Limit*Row_Limit; i=i+1) begin
			if(InMatrix[(5-1)*Row_Limit*Row_Limit+i] == 1'b1) begin
				OutMatrix[4*Row_Limit*Row_Limit+i] = 1'b0;
				OutMatrix[3*Row_Limit*Row_Limit+i] = 1'b0;
				OutMatrix[2*Row_Limit*Row_Limit+i] = 1'b0;
				OutMatrix[1*Row_Limit*Row_Limit+i] = 1'b0;
				OutMatrix[0*Row_Limit*Row_Limit+i] = 1'b0;
			end
		end
	end
	
endmodule 