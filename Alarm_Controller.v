module Alarm_Controller(input CLK,					//trigger clock, used in all modules and by the DAC decoder
								input RST,					//system reset
								input [7:0] Distance,	//distance from object, bits
								output reg Sound);		//alarm data stream to be converted to analog audio
								
always@(posedge CLK)
	if(!RST)
		Sound <= 0;
	else
		if(Distance < 100)
			Sound <= 1;
		else
			Sound <= 0;

endmodule 