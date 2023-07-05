module shifter(
	input [7:0] inp,
	input [1:0] shift_cntr,
	output reg [15:0] shift_out);
always@(*) begin
	case(shift_cntr)
		2'b01: shift_out = inp << 4;
		2'b10: shift_out = inp << 8;
		default: shift_out = inp;
	endcase
end
endmodule

module tst();
reg [7:0] inp;
reg [1:0] shift_cntr;
wire [15:0] shift_out;
shifter s(inp,shift_cntr,shift_out);
initial 
	$monitor("inp=%b shift_cntr=%0d shift_out=%b",inp,shift_cntr,shift_out);
initial begin 
inp = 7; shift_cntr = 0;
#10
shift_cntr = 1;
#10
shift_cntr = 2;
#10
shift_cntr = 3;
#10 
inp = 255; 
#10
shift_cntr=1;
end
endmodule


		