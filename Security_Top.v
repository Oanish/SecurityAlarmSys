module Security_Top (input CLK,						//the board's oscillator clock
							input RST,						//system reset
							input Echo_Sig,				//echo signal from HC-SR04
							output Trigger_Sig);			//trigger signal to HC-SR04
							//output [13:0] Distance,	//distance from object, digits
							//output T_CLK,				//trigger clock, used in all modules and by the DAC decoder
							//output Sound_Sig);			//alarm data stream to be converted to analog audio
							
wire T_CLK;						//trigger clock, used in all modules
wire [7:0] Distance_Raw;	//distance from object, bits
							
CLK_Divider DUT1(.CLK(CLK),
					  .RST(RST),
					  .T_CLK(T_CLK));
					  
Sensor_Controller DUT2(.CLK(T_CLK),
							  .RST(RST),
							  .Trigger(Trigger_Sig),
							  .Echo(Echo_Sig),
							  .Distance(Distance_Raw));
						 
//Digit_Converter DUT3(.Distance_Raw(Distance_Raw),
//							.Distance(Distance));

//Alarm_Controller DUT4(.CLK(T_CLK),					//Not working. Sending noise
//							 .RST(RST),
//							 .Distance(Distance_Raw),
//							 .Sound(Sound_Sig));
							
//IoT module
							
endmodule 