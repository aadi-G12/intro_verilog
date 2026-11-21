module mult_2scomp (
  input [3:0] a, b,
  output [7:0] y
);

  rowmult rm (a, b, y); 

endmodule

module rowmult (
  input [3:0] a, b,
  output [7:0] y
);

  wire [7:0] a_ext; 
  msb_extend mbex_a (a, a_ext);

  wire [7:0] row0, row1, row2, row3;
  assign row0 = b[0] ? a_ext : 8'b0;
  assign row1 = b[1] ? {a_ext[6:0], 1'b0} : 8'b0;
  assign row2 = b[2] ? {a_ext[5:0], 2'b0} : 8'b0;
  assign row3 = b[3] ? ~{a_ext[4:0], 3'b0} + 8'd1 : 8'b0; 

  assign y = row0 + row1 + row2 + row3; 

endmodule

module msb_extend (
  input [3:0] a,
  output [7:0] y
);

  assign y = a[3] ? { {4{1'b1}}, a } : { {4{1'b0}}, a };

endmodule
