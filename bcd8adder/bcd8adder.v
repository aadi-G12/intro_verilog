module bcd8adder (
  input cin,
  input [7:0] a, b,
  output [7:0] s,
  output cout
);

  wire [4:0] s0raw, s1raw;
  wire s0cout;

  assign s0raw = a[3:0] + b[3:0] + cin;
  assign s0cout = s0raw[4] | (s0raw[3]&(s0raw[2] | s0raw[1]));
  assign s[3:0] = s0cout ? s0raw[3:0] + 4'd6 : s0raw[3:0];

  assign s1raw = a[7:4] + b[7:4] + s0cout;
  assign cout = s1raw[4] | (s1raw[3]&(s1raw[2] | s1raw[1]));
  assign s[7:4] = cout ? s1raw[3:0] + 4'd6 : s1raw[3:0];

endmodule
