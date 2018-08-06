module Sound_Generator (input CLK,					//trigger clock, used in all modules and by the DAC decoder
								input RST,					//system reset
								input [7:0] Distance,	//distance from object, bits
								output Sound_Data,		//alarm data stream to be converted to analog audio
								output XCLK,				//chip clock used by the audio codec
								output BCLK,				//bit clock used by the audio codec
								output DACLRCK);			//clock used by the audio codec to align left and right channels
								
reg [11:0] Counter;

always@(posedge CLK)
	if(!RST)
		Counter <= 0;
	else
		Counter <= Counter + 1;
			
assign Sound_Data = (Distance < 100) ? Counter[11] : 1'bz;

assign XCLK = Counter[1];
assign BCLK = Counter[3];
assign DACLRCK = Counter[8];

endmodule 