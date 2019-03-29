module rd(Clock, Enable);
  reg [18:0] Q;
  output Enable;
  reg out;
  input Clock;
	initial begin
		Q = 19'b1100101101110011010;
		out = 1'b0;
	end
	
	assign Enable = out;

  always @(posedge Clock)
  begin
	if(Q == 19'b0)
      begin
        out <= 1'b1;
        Q <= 19'b1100101101110011010;
      end
    else
      begin
			out <= 1'b0;
        Q <= Q - 1'b1;
      end
end
endmodule
