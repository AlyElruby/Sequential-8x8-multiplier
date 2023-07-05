module top(
	input [7:0] dataa, datab,
	input start , reset_a,clk,
	output [15:0] product8x8,
	output done_flag,a,b,c,d,e,f,g);
	wire [3:0] aout,bout;
	wire [7:0] product;
	wire [15:0] shift_out , sum;
	wire [2:0] state_out;
	wire [1:0] sel ,shift,count;
	wire clk_ena,sclr_n;
	mux4 x1(dataa[3:0],dataa[7:4],sel[1],aout);
	mux4 x2(datab[3:0],datab[7:4],sel[0],bout);
	mult4x4 m1(aout,bout,product);
	shifter s1(product, shift,shift_out);
	adder a1(shift_out,product8x8,sum);
	reg16 r1(clk ,sclr_n,clk_ena,sum,product8x8);
	multcontrol mc1(clk,reset_a,start,count,sel,shift,state_out,done_flag,clk_ena,sclr_n);
	counter c1(clk,(!start),count);
	sevenseg ss1(state_out,a,b,c,d,e,f,g);
endmodule

module tst();
reg [7:0] dataa, datab;
reg start , reset_a,clk;
wire [15:0] product8x8;
wire done_flag,a,b,c,d,e,f,g;
top t1(dataa,datab,start,reset_a,clk,product8x8,done_flag,a,b,c,d,e,f,g);
initial 
	$monitor("time=%0t clk=%b dataa=%0d datab=%0d reset_a=%b start=%b product8x8=%0d done_flag=%b abcdefg=%b%b%b%b%b%b%b",$time(),clk,dataa,datab,reset_a,start,product8x8,done_flag,a,b,c,d,e,f,g);
always
	#5 clk=~clk;
initial begin
clk=0; reset_a=1; start=0; dataa=12; datab=4;
#10
reset_a=0;
#5
reset_a=1; start=1;
#15
start=0;
#40;
$stop();
end
endmodule