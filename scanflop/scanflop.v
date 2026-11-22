module scanflop (
  input clk, test, Sin,
  input [3:0] d,
  output reg [3:0] q,
  output Sout
);

  always @ (posedge clk) begin
    if (test) begin
      q <= {q[2:0], Sin};
    end else begin
      q <= d;
    end
  end

  assign Sout = q[3];

endmodule
