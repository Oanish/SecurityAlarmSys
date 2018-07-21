module Sensor_Controller (input CLK,							//the trigger clock
								  input RST,							//system reset
								  input Echo,							//the echo signal from HC-SR04
								  output reg Trigger,				//the trigger signal to HC-SR04
								  output reg [7:0] Distance);		//distance from object, bits

reg [19:0] Counter;

//trigger impulse generator
always@(posedge CLK)
	if(!RST)
		begin
			Counter <= 0;
			Trigger <= 0;
			Distance <= 0;
		end
	else
		begin
			if(Counter == 99999)		//impulse generated ever second
				begin
					Counter <= 0;
					Trigger <= 1;
				end
			else
				begin
					Trigger <= 0;
					Counter <= Counter + 1;
				end
			
			if(Echo)						//distance calculator
				Distance <= Counter * 10 / 58;
		end

endmodule 