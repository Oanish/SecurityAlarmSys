module Alarm_Controller (input CLK,					//trigger clock, used in all modules and by the DAC decoder
								 input RST,					//system reset
								 input [7:0] Distance,	//distance from object, bits
								 output reg Sound,		//alarm data stream to be converted to analog audio
								 inout Data);				//i2c data for address, r/w operation
								
I2C_Automata DUT(.CLK(CLK),
					  .RST(RST),
					  .Data(Data));

endmodule 