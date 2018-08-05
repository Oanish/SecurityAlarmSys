module Sound_Generator (input CLK,					//trigger clock, used in all modules and by the DAC decoder
								input RST,					//system reset
								input [7:0] Distance,	//distance from object, bits
								output Data,				//alarm data stream to be converted to analog audio
								inout reg Trig);			//alarm trigger impulse
								
reg [7:0] Counter;

always@(posedge CLK)
	if(!RST)
		begin
			Trig <= 0;
			Counter <= 0;
		end
	else
		begin
			Counter <= Counter + 1;
			if(Distance < 100)
				Trig <= 0;
			else
				Trig <= 1;
		end
			
assign Data = Counter[7];		

endmodule 