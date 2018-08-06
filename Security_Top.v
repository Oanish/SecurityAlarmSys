module Security_Top (input CLK,						//the board's oscillator clock
							input RST,						//system reset
							output XCLK,					//chip clock used by the audio codec
							output BCLK,					//bit clock used by the audio codec
							output DACLRCK,				//clock used by the audio codec to align left and right channels
							input Echo_Sig,				//echo signal from HC-SR04
							output Trigger_Sig,			//trigger signal to HC-SR04
							output [13:0] Distance,		//distance from object, digits
							output Sound_Data,			//alarm data stream to be converted to analog audio
							inout I2C_Data,				//i2c data for address, r/w operation
							inout I2C_Clock);				//i2c clock

wire T_CLK;						//trigger clock, used in most modules and by the DAC decoder		
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
							 
Sound_Generator DUT5(.CLK(CLK),
							.RST(RST),
							.Distance(Distance_Raw),
							.Sound_Data(Sound_Data),
							.XCLK(XCLK),
							.BCLK(BCLK),
							.DACLRCK(DACLRCK));
							
CodecConfigurator DUT6(.reset(RST),
							  .inClock((Distance_Raw < 100) ? T_CLK : 1'b0),
							  .sda(I2C_Data),
							  .scl(I2C_Clock),
							  .ready(),
							  .ackNum());
							
endmodule 