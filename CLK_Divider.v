module CLK_Divider (input CLK,				//the board's oscillator clock, 50 MHz
						  input RST,				//system reset
						  output reg T_CLK);		//the trigger clock, 100 KHz
						  
reg [11:0] Counter;

always@(posedge CLK)
	if(!RST)
		begin
			T_CLK <= 0;
			Counter <= 0;
		end
	else
		if(Counter == 499)
			begin
				T_CLK <= !T_CLK;
				Counter <= 0;
			end
		else
			Counter <= Counter + 1;

endmodule 