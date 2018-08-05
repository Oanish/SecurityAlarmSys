module Security_Top (input CLK,						//the board's oscillator clock
							input RST,						//system reset
							output T_CLK,					//trigger clock, used in all modules and by the DAC decoder
							input Echo_Sig,				//echo signal from HC-SR04
							output Trigger_Sig,			//trigger signal to HC-SR04
							output [13:0] Distance,		//distance from object, digits
							output Sound_Data,			//alarm data stream to be converted to analog audio
							inout Sound_Trig,				//alarm trigger impulse
							inout I2C_Data,				//i2c data for address, r/w operation
							inout I2C_Clock);				//i2c clock
							
wire [7:0] Distance_Raw;	//distance from object, bits
							
CLK_Divider DUT1(.CLK(CLK),
					  .RST(RST),
					  .T_CLK(T_CLK));
					  
Sensor_Controller DUT2(.CLK(T_CLK),
							  .RST(RST),
							  .Trigger(Trigger_Sig),
							  .Echo(Echo_Sig),
							  .Distance(Distance_Raw));
						 
Digit_Converter DUT3(.Distance_Raw(Distance_Raw),
							.Distance(Distance));

//Alarm_Controller DUT4(.CLK(T_CLK),					
//							 .RST(RST),
//							 .Distance(Distance_Raw),
//							 .Sound_Data(Sound_Data),
//							 .Sound_Trig(Sound_Trig),
//							 .I2C_Data(I2C_Data),
//							 .I2C_Clock(I2C_Clock));
							 
CodecConfigurator DUT5(.reset(RST),
							  .inClock((Distance_Raw < 100) ? T_CLK : 1'b0),
							  .sda(I2C_Data),
							  .scl(I2C_Clock),
							  .ready(),
							  .ackNum());
							
Sound_Generator DUT6(.CLK(T_CLK),
							.RST(RST),
							.Distance(Distance_Raw),
							.Data(Sound_Data),
							.Trig(Sound_Trig));
							
endmodule 