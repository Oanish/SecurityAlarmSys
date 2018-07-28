module Sound_Generator (input CLK,					//trigger clock, used in all modules and by the DAC decoder
								input RST,					//system reset
								input [7:0] Distance,	//distance from object, bits
								output reg Data,			//alarm data stream to be converted to analog audio
								output reg Trig);			//alarm trigger impulse

always@(posedge CLK)
	if(!RST)
		begin
			Data <= 0;
			Trig <= 0;
		end
	else
		if(Distance < 100)
			begin
				Trig <= 1;
				Data <= 1;
				if(Trig == 1)
					Trig <= 0;
			end
		else
			begin
				Trig <= 0;
				Data <= 0;
			end

endmodule 