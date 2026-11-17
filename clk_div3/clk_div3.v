module clk_div3 (
  input clk,
  input reset,
  output clk3);

  reg [1:0] count3;
  reg negflop;


  //counter flop
  always @ (posedge clk) begin
    if (reset | count3 == 2) begin
      count3 <= 2'b0;
    end else begin
      count3 <= count3 + 2'd1;
    end
  end

  //send low on negedge
  always @ (negedge clk) begin
    if (reset) begin
      negflop <= 1'b0;
    end else if (count3 == 2'd1) begin
      negflop <= 1'b1;
    end else begin
      negflop <= 1'b0;
    end
  end

  assign clk3 = (count3 == 2'd0 | count3 == 2'd1) & ~negflop;

endmodule
