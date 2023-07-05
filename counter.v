module counter(
	input clk ,aclr,
	output reg [1:0] count_out);
always@(posedge clk , negedge aclr) begin
	if(!aclr)
		count_out <= 0;
	else
		count_out <= count_out+1;
end
endmodule
module tst();
wire [1:0] count_out;
reg clk,aclr;
counter c(clk,aclr,count_out);
initial 
	$monitor("aclr=%b  count=%0d",aclr,count_out);
always
	#5 clk=~clk;
initial begin
clk=0; aclr=1;
#11
aclr=0;
#10
aclr=1;
#30;
$stop();
end
endmodule
