module I2C_Automata (input CLK,				//trigger clock, used in all modules and by the DAC decoder
							input RST,				//system reset
							inout reg Data,		//i2c data for address, r/w operation
							output reg Clock);	//i2c clock
							
reg [2:0] State;
reg [3:0] Counter;

//state space
always@(posedge CLK)
	if(!RST)
		begin
			State <= 0; //idle state
			Counter <= 8;
		end
	else
		case(State)
			0: //idle state
				State <= 1;
			1: //start state
				State <= 2;
			2: //address communication state
				if(Counter == 0 & Data == 0)
					begin
						State <= 3;
						Counter <= 8;
					end
				else
					Counter <= Counter - 1;
			3: //intermediary state
				State <= 4;
			4: //data communication state
				if (Counter == 0 & Data == 0)
					State <= 5;
				else
					Counter <= Counter - 1;
			5: //stop state
				State <= 0;
			default: State <= 0;
		endcase

//output space
always@(*)
	if(!RST)
		begin
			Data = 1;
			Clock = 1;
		end
	else
		case(State)
			0: begin
					Data = 1;
					Clock = 1;
				end
			1: begin
					Data = 0;
					Clock = 1;
				end
			2: begin
					case(Counter)
						8: Data = 0;	//left headphone out
						7: Data = 0;	//left headphone out
						6: Data = 0;	//left headphone out
						5: Data = 0;	//left headphone out
						4: Data = 0;	//left headphone out
						3: Data = 1;	//left headphone out
						2:	Data = 0;	//left headphone out
						1: Data = 0;	//write bit
					endcase
					Clock = CLK;
				end
			3: begin
					Data = 1;
					Clock = 0;
				end
			4: begin
					case(Counter)
						8: Data = 1;	//LR are identical
						7: Data = 0;	//left channel zero detect disabled
						6: Data = 1;	//0dB
						5: Data = 1;	//0dB
						4: Data = 1;	//0dB
						3: Data = 1;	//0dB
						2:	Data = 0;	//0dB
						1: Data = 0;	//0dB
						0: Data = 1;	//0dB
					endcase
					Clock = CLK;
				end
			5: begin
					Data = 0;
					Clock = 1;
				end
		endcase

endmodule 