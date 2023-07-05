module mux4(
	input [3:0] a ,b,
	input sel,
	output [3:0] out);
assign out = (sel==1'b0)? a:b;
endmodule
module tst();
wire [3:0] out;
reg [3:0] a,b;
reg sel;
mux4 m(a,b,sel,out);
initial 
	$monitor("a=%0d  b=%0d  sel=%0d  out=%0d",a,b,sel,out);
initial begin
a=7; b=2; sel=0;
#10
sel=1;
#10
a=9;
#10
b=0;
#10
sel=0;
end
endmodule