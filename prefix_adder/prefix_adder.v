module prefix_adder (
  input [15:0] a, b,
  input cin,
  output [15:0] s,
  output cout
);

  //colwise generate and propagate 
  wire [15:0] g, p;
  assign g = a & b; assign p = a | b;

  //pairwise (recursion step 1)
  wire [7:0] g1, p1;
  assign g1 = {
    g[14] | p[14]&g[13],
    g[12] | p[12]&g[11],
    g[10] | p[10]&g[9],
    g[8] | p[8]&g[7],
    g[6] | p[6]&g[5],
    g[4] | p[4]&g[3],
    g[2] | p[2]&g[1],
    g[0] | p[0]&cin
  };
  assign p1 = {
    p[14]&p[13],
    p[12]&p[11],
    p[10]&p[9],
    p[8]&p[7],
    p[6]&p[5],
    p[4]&p[3],
    p[2]&p[1],
    p[0]
  };

  //recursion level 2
  wire [7:0] g2, p2;
  assign g2 = {
    g1[7] | p1[7]&g1[6],
    g[13] | p[13]&g1[6],
    g1[5] | p1[5]&g1[4],
    g[9] | p[9]&g1[4],
    g1[3] | p1[3]&g1[2],
    g[5] | p[5]&g1[2],
    g1[1] | p1[1]&g1[0],
    g[1] | p[1]&g1[0]
  };
  assign p2 = {
    p1[7]&p1[6],
    p[13]&p1[6],
    p1[5]&p1[4],
    p[9]&p1[4],
    p1[3]&p1[2],
    p[5]&p1[2],
    p1[1]&p1[0],
    p[1]&p1[0]
  };

  //recursion level 3
  // {14:7, 13:7, 12:7, 11:7, 6:-1, 5:-1, 4:-1, 3:-1}
  wire [7:0] g3;
  wire [7:4] p3; //only the 14:7..11:7 group Ps are needed anymore
  assign g3 = {
    g2[7] | p2[7]&g2[5],
    g2[6] | p2[6]&g2[5],
    g1[6] | p1[6]&g2[5],
    g[11] | p[11]&g2[5],
    g2[3] | p2[3]&g2[1],
    g2[2] | p2[2]&g2[1],
    g1[2] | p1[2]&g2[1],
    g[3] | p[3]&g2[1]
  };
  assign p3 = {
    p2[7]&p2[5],
    p2[6]&p2[5],
    p1[6]&p2[5],
    p[11]&p2[5]
  };

  //recursion level 4
  // {14:-1, 13:-1, ...., 8:-1, 7:-1}
  wire [7:0] g4;
  assign g4 = {
    g3[7] | p3[7]&g3[3],
    g3[6] | p3[6]&g3[3],
    g3[5] | p3[5]&g3[3],
    g3[4] | p3[4]&g3[3],
    g2[5] | p2[5]&g3[3],
    g2[4] | p2[4]&g3[3],
    g1[4] | p1[4]&g3[3],
    g[7] | p[7]&g3[3]
  };

  //all the G(i-1:-1)s
  wire [15:0] c;
  assign c = {
    g4[7:0],   
    g3[3:0],  
    g2[1],   
    g2[0],  
    g1[0], 
    cin   
  };

  //sum and cout 
  assign s = a ^ b ^ c;
  assign cout = g[15] | p[15]&g4[7];

endmodule
