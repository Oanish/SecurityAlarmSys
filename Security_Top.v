module Security_Top (input CLK,						//the board's oscillator clock
							input RST,						//system reset
							input Echo_Sig,				//echo signal from HC-SR04
							output Trigger_Sig,			//trigger signal to HC-SR04
							output [13:0] Distance);	//distance from object, digits
							
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
						 
Digit_Converter DUT3(.Distance_Raw(Distance_Raw),
							.Distance(Distance));
							
endmodule 