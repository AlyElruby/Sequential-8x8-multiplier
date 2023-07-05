module reg16(
	input clk,sclr,clk_en,
	input [15:0] datain,
	output reg [15:0] reg_out);
always@(posedge clk) begin
	if(clk_en) begin
		if(!sclr)
			reg_out <= 0;
		else
			reg_out <= datain;
	end
end
endmodule
module tst();
reg clk ,sclr,clk_en;
reg [15:0] datain;
wire [15:0] reg_out;
reg16 r(clk,sclr,clk_en,datain,reg_out);
always
	#5 clk=~clk;
initial
	$monitor("sclr=%b clk_en=%b datain=%0d reg_out=%0d",sclr,clk_en,datain,reg_out);
initial begin
clk = 0; clk_en=0; sclr=1; datain=19;
#11
clk_en=1;
#13
sclr=0;
#11
sclr=1 ;
#12
datain =12;
#11
clk_en=0;
#12
datain=29;
#80;
end
endmodule

