 module PoolUnit(clk,InMatrix,OutMatrix); 
 
	parameter Row_Limit   = 10;
	parameter WindowsSize = 3;
	parameter ComputRow   = 3;
	
	//==========================================================
	// Prot Define
	//==========================================================
	input  bit                                   clk;
	input  [5*Row_Limit*Row_Limit-1:0]           InMatrix;
   output [5*Row_Limit*Row_Limit-1:0]           OutMatrix;
	
	//==========================================================================================================
	// Value
	//==========================================================================================================
	int i          = 0 ; // Define The IndexOf Value i
	int j          = 0 ; // Define The IndexOf Value j
	int m          = 0 ; // Define The IndexOf Value m
	int n          = 0 ; // Define The IndexOf Value n
	int Tmp        = 0 ; // Define The Input To Int32 Type Tmp Value
	
	
	//==========================================================================================================
	// Init Event
	//==========================================================================================================
	initial begin
		i   = 0;
		j   = 0;
		m   = 0;
		n   = 0;
		Tmp = 0;
	end
		
	//==========================================================================================================
	// Event
	//==========================================================================================================
	always@(posedge clk) begin
		for(i=0;i<ComputRow;i=i+1) begin
			for(j=0;j<ComputRow;j=j+1) begin
				Tmp = 0;
				for(m=0;m<WindowsSize;m=m+1) begin //Computing By Row 
					for(n=0;n<WindowsSize;n=n+1) begin //Computing By Col
						if({InMatrix[4*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[3*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[2*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[1*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[0*Row_Limit*Row_Limit+m*Row_Limit+n]} > Tmp)
							Tmp = {InMatrix[4*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[3*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[2*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[1*Row_Limit*Row_Limit+(i+m)*Row_Limit+(j+n)],InMatrix[0*Row_Limit*Row_Limit+m*Row_Limit+n]};
					end
				end
				OutMatrix[4*Row_Limit*Row_Limit+i*Row_Limit+j] = Tmp[4];
				OutMatrix[3*Row_Limit*Row_Limit+i*Row_Limit+j] = Tmp[3];
				OutMatrix[2*Row_Limit*Row_Limit+i*Row_Limit+j] = Tmp[2];
				OutMatrix[1*Row_Limit*Row_Limit+i*Row_Limit+j] = Tmp[1];
				OutMatrix[0*Row_Limit*Row_Limit+i*Row_Limit+j] = Tmp[0];
			end
		end
		
	end
	
 endmodule 