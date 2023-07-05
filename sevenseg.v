module sevenseg(
	input [2:0] inp,
	output a,b,c,d,e,f,g);
assign a= (inp ==3'b001)? 0 : 1;
assign b= (inp ==3'b000)? 1 :
		  (inp ==3'b001)? 1 :
		  (inp ==3'b010)? 1 :
		  (inp ==3'b011)? 1 : 0;
assign c= (inp ==3'b000)? 1 :
		  (inp ==3'b001)? 1 :
		  (inp ==3'b010)? 0 :
		  (inp ==3'b011)? 1 : 0;
assign d= (inp ==3'b001)? 0 : 1;
assign e= (inp ==3'b000)? 1 :
		  (inp ==3'b001)? 0 :
		  (inp ==3'b010)? 1 :
		  (inp ==3'b011)? 0 : 1;
assign f= (inp ==3'b000)? 1 :
		  (inp ==3'b001)? 0 :
		  (inp ==3'b010)? 0 :
		  (inp ==3'b011)? 0 : 1;
assign g= (inp ==3'b000)? 0 :
		  (inp ==3'b001)? 0 :
		  (inp ==3'b010)? 1 :
		  (inp ==3'b011)? 1 : 1;
endmodule

module tst();
reg [2:0] inp;
wire a,b,c,d,e,f,g;
sevenseg s(inp,a,b,c,d,e,f,g);
initial 
	$monitor("inp=%0d abcdefg=%b%b%b%b%b%b%b",inp ,a,b,c,d,e,f,g);
initial begin 
inp =0;
#10 
inp =1;
#10
inp =2;
#10
inp =3;
#10
inp=4;
#10
inp =7;
end
endmodule




