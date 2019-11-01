//`include "BaseCutline.sv"

module DownDim(CutLine,Dim1Flag,Dim2Flag,Dim1,Dim2,OutDownFlag,OutDownDim);
	parameter Offset        = 0;
	parameter InData_limit  = 10;
	
	input  [InData_limit-1:0] CutLine;
	input  [3:0]    			  Dim1Flag;
	input  [3:0]    			  Dim2Flag;
	input  [InData_limit-1:0] Dim1;
	input  [InData_limit-1:0] Dim2;
	output [3:0] 				  OutDownFlag;
	output [InData_limit-1:0] OutDownDim;
	
	BaseCutLine #(.LongBits_limit(InData_limit)) DownDimBaseCutLine(.cut_line(CutLine),.x(Dim1),.y(Dim2),.z(OutDownDim));

	always@(*) begin
		if((Dim1Flag[0] == 1'b1 && Dim2Flag[2] == 1'b1)||(Dim1Flag[2] == 1'b1 && Dim2Flag[0] == 1'b1))
			OutDownFlag = 3'b010;
		else
			OutDownFlag = Dim1Flag | Dim2Flag;
		
		
		if(Dim1Flag[1] == 1'b0)
			if (Offset > 0)
				OutDownDim = OutDownDim <<< Offset;
			else
				OutDownDim = OutDownDim >> Offset;
	end
endmodule
