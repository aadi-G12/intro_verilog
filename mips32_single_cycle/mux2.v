module mux2 #(parameter N = 32) (
  input sel,
  input [N-1:0] a, b,
  output [N-1:0] y
);

  assign y = sel ? a : b;

endmodule
