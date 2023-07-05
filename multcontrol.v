module multcontrol(
	input clk , reset_a, start,
	input [1:0] count,
	output reg [1:0] input_sel , shift_sel,
	output [2:0] state_out,
	output reg done , clk_ena, sclr_n);
parameter IDLE  = 3'b000,LSB = 3'b001,MID = 3'b010,MSB=3'b011,CALC_DONE=3'b100,ERR=3'b101;
reg [2:0] state, nxt_state;
always@(posedge clk, negedge reset_a) begin
if(!reset_a)
	state=IDLE;
else 
	state =nxt_state;
end
assign state_out = state;
always@(*) begin
if(!reset_a)
	nxt_state=IDLE;
else begin
	case(state)
		IDLE: begin
			if(!start) begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				nxt_state=IDLE;
			end
			else begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=1;
				sclr_n=0;
				nxt_state = LSB;
			end
		end
		LSB: begin
			if((!start) && (count==0)) begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=1;
				sclr_n=1;
				nxt_state=MID;
			end
			else begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				nxt_state=ERR;
			end
		end
		MID: begin
			if((!start)&&(count==2'b01)) begin
				input_sel=2'b01;
				shift_sel=2'b01;
				done=0;
				clk_ena=1;
				sclr_n=1;
				nxt_state= MID;
			end
			else if((!start) && (count==2'b10)) begin
				input_sel=2'b10;
				shift_sel=2'b01;
				done=0;
				clk_ena=1;
				sclr_n=1;
				nxt_state=MSB;
			end
			else begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				nxt_state=ERR;
			end
		end
		MSB: begin
			if((!start) && (count==2'b11)) begin
				input_sel=2'b11;
				shift_sel=2'b10;
				done=0;
				clk_ena=1;
				sclr_n=1;
				nxt_state=CALC_DONE;
			end
			else begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				nxt_state=ERR;
			end
		end
		CALC_DONE: begin
			if(!start) begin
				input_sel=0;
				shift_sel=0;
				done=1;
				clk_ena=0;
				sclr_n=1;
				nxt_state=IDLE;
			end
			else begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				nxt_state=ERR;
			end
		end
		ERR: begin
			if(!start) begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				nxt_state=ERR;
			end
			else begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=1;
				sclr_n=0;
				nxt_state=LSB;
			end
		end
	endcase
end
end
endmodule
module tst();
reg clk , reset_a, start;
reg [1:0] count;
wire [1:0] input_sel , shift_sel;
wire [2:0] state_out;
wire done , clk_ena, sclr_n;
multcontrol m(clk,reset_a,start,count,input_sel,shift_sel,state_out,done,clk_ena,sclr_n);
initial 
	$monitor("start=%b reset_a=%b count=%b state_out=%b input_sel=%b shift_sel=%b done=%b sclr_n=%b clk_ena=%b",start,reset_a,count,state_out,input_sel,shift_sel,done,sclr_n,clk_ena);
always
	#5 clk=~clk;
initial begin
count=0; clk=1; start=0; reset_a=0;
#10 reset_a=1; start=1;
#10 start=0;
#10 count=1;
#10 count=2;
#10 count=3;
#20;
end
endmodule