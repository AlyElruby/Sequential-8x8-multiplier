module mult4x4(
	input [3:0] dataa , datab,
	output [7:0] product);
	assign product = dataa * datab;
endmodule
module tst();
reg [3:0] dataa , datab;
wire [7:0] product;
mult4x4 m(dataa,datab,product);
initial 
	$monitor("dataa =%0d  datab=%0d product=%0d", dataa ,datab ,product);
initial begin
dataa= 0;	datab=10;
#10
dataa= 5;	datab=10;
#10
dataa= 5;	datab=0;
#10
dataa= 5;	datab=5;
#10
dataa= 15;	datab=15;
#10
dataa= -5;	datab=10;
end
endmodule