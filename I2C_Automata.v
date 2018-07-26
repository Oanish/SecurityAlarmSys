module I2C_Automata (input CLK,
							input RST,
							inout Data,
							output Clock);
							
reg [2:0] State;
reg [3:0] Counter;

//state space
always@(posedge CLK)
	if(!RST)
		begin
			State <= 0; //idle state
			Data <= 1;
			Clock <= 1;
			Counter <= 8;
		end
	else
		case(State)
			0: //idle state
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
	case(State)
		0: Data = 1;
			Clock = 1;
		1: Data = 0;
			Clock = 1;
		2: Data = Address;
			Clock = CLK;
		3: Data = 1;
			Clock = 0;
		4: Data = Data;
			Clock = CLK;
		5: #10 Data = 1;
			Clock = 1;
	endcase

endmodule 