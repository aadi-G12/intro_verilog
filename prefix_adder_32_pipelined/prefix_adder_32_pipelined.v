module prefix_adder_32_pipelined ( 
  input clk,
  input [31:0] a, b,
  input cin,
  output [31:0] s
);

  wire [31:0] g, p;
  assign g = a&b;
  assign p = a|b;

  reg [31:0] G [0:10];
  reg [31:0] P [0:10]; 
  reg [31:0] axorbpipe [0:10];
  reg [31:0] s_out;

  reg [31:0] Gcarry [0:10];


  always @ (posedge clk) begin
    G[0] <= {g[30:0], cin};
    P[0] <= {p[30:0], 1'b0};
    axorbpipe[0] <= a^b;
  end

  genvar cut;
  generate
    for (cut = 1; cut < 11; cut = cut + 1) begin : cutgen
      always @ (posedge clk) begin
        axorbpipe[cut] <= axorbpipe[cut-1];
      end
    end
  endgenerate

  genvar r, i;
  generate
    for (r=0; r < 5; r = r+1) begin : level
      for (i=0; i < 32; i = i+1) begin : col
        if (((i >> r) & 1) == 1) begin : box
          always @ (posedge clk) begin
            G[2*r+1][i] <= G[2*r][(({5{1'b1}} << r) & i) - 1] & P[2*r][i];
            P[2*r+1][i] <= P[2*r][i] & P[2*r][(({5{1'b1}} << r) & i) - 1];
            Gcarry[2*r+1][i] <= G[2*r][i];

            G[2*r+2][i] <= Gcarry[2*r+1][i] | G[2*r+1][i];
            P[2*r+2][i] <= P[2*r+1][i];
          end
        end else begin
          always @ (posedge clk) begin
            G[2*r+1][i] <= G[2*r][i];
            G[2*r+2][i] <= G[2*r+1][i];
            P[2*r+1][i] <= P[2*r][i];
            P[2*r+2][i] <= P[2*r+1][i];
          end
        end
      end
    end
  endgenerate  

  always @ (posedge clk) begin
    s_out <= axorbpipe[10] ^ G[10];
  end

  assign s = s_out;

  

endmodule
