module Alarm_Controller (input CLK,					//trigger clock, used in all modules and by the DAC decoder
								 input RST,					//system reset
								 input [7:0] Distance,	//distance from object, bits
								 output Sound_Data,		//alarm data stream to be converted to analog audio
								 output Sound_Trig,		//alarm trigger impulse
								 inout I2C_Data,			//i2c data for address, r/w operation
								 output I2C_Clock);		//i2c clock
								 
I2C_Automata DUT1(.CLK(CLK),
					  .RST(RST),
					  .Data(I2C_Data),
					  .Clock(I2C_Clock));
					  
Sound_Generator DUT2(.CLK(CLK),
							.RST(RST),
							.Distance(Distance),
							.Data(Sound_Data),
							.Trig(Sound_Trig));

endmodule 