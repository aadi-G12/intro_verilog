module ALU #(parameter N = 32) (
  input [2:0] f,
  input [N-1:0] a, b,
  output reg [N-1:0] y,
  output [3:0] ALUflags 
);


  wire [N-1:0] bb, s_zeroext, s;
  wire cout;

  //b or -b mux
  assign bb = f[2] ? ~b : b;

  //4:1 mux
  always @ (*) begin
    case (f[1:0])
      2'b00 : y = a & bb; 
      2'b01 : y = a | bb;
      2'b10 : y = s;
      2'b11 : y = s_zeroext; 
    endcase
  end

  //intermediate wires
  assign {cout, s} = a + bb + f[2];
  assign s_zeroext = {{(N-1){1'b0}}, s[N-1]};

  //ALU flags (N, Z, C, V)
  assign ALUflags[3] = y[N-1] == 1; 
  assign ALUflags[2] = y == 0;
  assign ALUflags[1] = cout;
  assign ALUflags[0] = ~(a[N-1] ^ bb[N-1]) & (a[N-1] != s[N-1]);

endmodule
