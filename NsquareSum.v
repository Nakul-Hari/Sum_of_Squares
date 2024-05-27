
module top_module(
  input [2:0] N,
  input Clk, Rst, ack, N_valid,
  output [7:0] sum_out,
  output sum_valid
);
  wire j_MUX_sel, i_MUX_sel, sum_MUX_sel, j_en, i_en, sum_en, i_eq_1, j_eq_1;

  Datapath datapath_inst(
    .N(N),
    .Clk(Clk),
    .i_en(i_en),
    .j_en(j_en),
    .i_MUX_sel(i_MUX_sel),
    .j_MUX_sel(j_MUX_sel),
    .sum_en(sum_en),
    .sum_MUX_sel(sum_MUX_sel),
    .sum_out(sum_out),
    .i_eq_1(i_eq_1),
    .j_eq_1(j_eq_1)
  );

  FSM fsm_inst(
    .ack(ack),
    .Rst(Rst),
    .Clk(Clk),
    .N_valid(N_valid),
    .i_eq_1(i_eq_1),
    .j_eq_1(j_eq_1),
    .i_en(i_en),
    .j_en(j_en),
    .i_MUX_sel(i_MUX_sel),
    .j_MUX_sel(j_MUX_sel),
    .sum_MUX_sel(sum_MUX_sel),
    .sum_en(sum_en),
    .sum_valid(sum_valid)
  );

endmodule


// Datapath
module Datapath(
  input [2:0] N,
  input Clk,
  input i_en, j_en, i_MUX_sel, j_MUX_sel, sum_en, sum_MUX_sel,
  output reg [7:0] sum_out,
  output i_eq_1, j_eq_1
);

  reg [2:0] i, j; 
  wire [2:0] i_MUX_out, j_MUX_out, i_new, j_new;
  wire [7:0] sum_add_out, sum_MUX_out;
	
	always @(posedge Clk)
		begin
			if (i_en)
				i <= i_MUX_out;
			if (j_en)
				j <= j_MUX_out;
			if (sum_en)
				sum_out <= sum_MUX_out;
		end
		
	assign i_MUX_out = i_MUX_sel ? i_new : N;
	assign j_MUX_out = j_MUX_sel ? j_new : i_MUX_out;
	assign sum_MUX_out = sum_MUX_sel ? sum_add_out : 8'b0;
	assign i_new = i - 1;
	assign j_new = j - 1;
	assign i_eq_1 = ( i==1 );
	assign j_eq_1 = ( j==1 );
	assign sum_add_out = sum_out + i;
	 
endmodule



module FSM(
  input ack, Rst, Clk, N_valid, i_eq_1, j_eq_1,
  output reg i_en, j_en, i_MUX_sel, j_MUX_sel, sum_en, sum_MUX_sel,
  output sum_valid
);


	reg[1:0] state;
	reg[1:0] state_next;	
	
	parameter idle = 2'b00;
	parameter busy = 2'b01;
	parameter done = 2'b10;

//finding current state

 	always@(posedge Clk)   // Idle = 0 , Busy = 1 , Done = 2
 	begin
		if (Rst) 
			state <= idle;
			
		else 
			state <= state_next;
	end

//combinational logic to find next state

always @(*)
	case(state)
		idle: begin
			sum_en = 1'b1;
			sum_MUX_sel = 1'b0;
			i_MUX_sel = 1'b0;
			j_MUX_sel=1'b0;
			i_en=1'b1;
			j_en=1'b1;
			
			if (N_valid ==1) state_next = busy;
			else state_next = idle;
		end
		
		busy: begin
			sum_en = 1'b1;
			sum_MUX_sel = 1'b1;
			if (j_eq_1) begin
				i_MUX_sel=1'b1;
				j_MUX_sel=1'b0;
				i_en = 1'b1;
				j_en=1'b1;
			end
		
			else begin
				i_MUX_sel = 1'b1;
				j_MUX_sel =1'b1;
				i_en=1'b0;
				j_en=1'b1;
			end
			
			if (i_eq_1 == 1) state_next =done; 
			else state_next = busy;
		end

		done: begin
			i_en= 1'b0;
			j_en= 1'b0;
			sum_en = 1'b0;
			if (ack==1) state_next = idle;
			else state_next = done;

			end
	endcase

//assigning the output

assign sum_valid = (state == done);

endmodule
