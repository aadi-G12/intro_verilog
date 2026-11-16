module serial_2scomp (
  input clk,
  input a,
  input start,
  output q
);

  parameter zeroes = 1'b0, invert = 1'b1;
  reg state;
  wire next_state;

  //next state combo block
  assign next_state = state ? invert : (a ? invert : zeroes);

  //seq block
  always @ (posedge clk) begin
    if (start) begin
      state <= zeroes;
    end else begin
      state <= next_state;
    end
  end

  //output combo block
  assign q = state ? ~a : a;

endmodule
