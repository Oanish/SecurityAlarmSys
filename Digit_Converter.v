module Digit_Converter (input [6:0] Distance_Raw,		//distance from object, bits
								output [13:0] Distance);		//distance from object, digits
								
wire [3:0] Distance_Tens, Distance_Units;

assign Distance_Units = (Distance_Raw < 100) ? (Distance_Raw % 10) : 9;
assign Distance_Tens = (Distance_Raw < 100) ? ((Distance_Raw - Distance_Units) / 10) : 9;

BCD DUT1(.BINARY(Distance_Tens),
			.SEGMENTS(Distance[13:7]));
			
BCD DUT2(.BINARY(Distance_Units),
			.SEGMENTS(Distance[6:0]));
			
endmodule 