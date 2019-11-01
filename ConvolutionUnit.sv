 module ConvolutionUnit(clk,InMatrix,EigenMatrix,OutMatrix); 
	parameter Row_Limit   = 10;
	parameter WindowsSize =  3;
	//==========================================================
	// Prot Define
	//==========================================================
	input  bit                                   clk;
	input  [5*Row_Limit*Row_Limit-1:0]           InMatrix;
	input  [5*WindowsSize*WindowsSize-1:0]       EigenMatrix;
   output [5*Row_Limit*Row_Limit-1:0]           OutMatrix;
	
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int i          = 0 ; // Define The IndexOf Value i
	int j          = 0 ; // Define The IndexOf Value j
	int m          = 0 ; // Define The IndexOf Value m
	int n          = 0 ; // Define The IndexOf Value n
	
	//==========================================================================================================
	// Init Event
	//==========================================================================================================
	initial begin
		i   = 0;
		j   = 0;
		m   = 0;
		n   = 0;
	end
	
	//==========================================================================================================
	// Event
	//==========================================================================================================
	always@(posedge clk) begin
		for(i=0;i<Row_Limit-WindowsSize+1;i=i+1) begin
			for(j=0;j<Row_Limit-WindowsSize+1;j=j+1) begin
				for(m=0;m<WindowsSize;m=m+1) begin
					for(n=0;n<WindowsSize;n=n+1) begin
						 {OutMatrix[4*WindowsSize*WindowsSize+i*WindowsSize+j],OutMatrix[3*WindowsSize*WindowsSize+i*WindowsSize+j],OutMatrix[2*WindowsSize*WindowsSize+i*WindowsSize+j],OutMatrix[1*WindowsSize*WindowsSize+i*WindowsSize+j],OutMatrix[0*WindowsSize*WindowsSize+i*WindowsSize+j]} = {InMatrix[4*Row_Limit*Row_Limit+i*Row_Limit+j],InMatrix[3*Row_Limit*Row_Limit+i*Row_Limit+j],InMatrix[2*Row_Limit*Row_Limit+i*Row_Limit+j],InMatrix[1*Row_Limit*Row_Limit+i*Row_Limit+j],InMatrix[0*Row_Limit*Row_Limit+i*Row_Limit+j]} & EigenMatrix[m*WindowsSize+n];
					end
				end
			end
		end
	end
 endmodule 