module adder(
	input [15:0] dataa, datab,
	output [15:0] sum);
assign sum = dataa + datab;
endmodule

module tst();
reg [15:0] dataa, datab;
wire [15:0] sum;
adder a1(dataa , datab, sum);
initial 
$monitor("dataa = %0d  datab = %0d   Sum= %0d", dataa , datab , sum);
initial begin
	dataa = 0; datab =0;
	#10
	dataa = 20;
	#10
	datab = 19;
	#10
	dataa =65535; datab = 65535;
	end
endmodule
