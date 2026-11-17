module clk_div5 (
  input clk,
  input reset,
  output clk5);

  reg [2:0] count5;
  reg negflop;
  wire poscondition;

  //counter flop
  always @ (posedge clk) begin
    if (reset | count5 == 3'd4) begin
      count5 <= 3'd0;
    end else begin
      count5 <= count5 + 3'd1;
    end
  end

  //send low on negedge
  always @ (negedge clk) begin
    if (reset) begin
      negflop <= 1'b0;
    end else begin
      negflop <= poscondition;
    end 
  end

  assign poscondition = count5 == 3'd0 | count5 == 3'd1;

  assign clk5 = poscondition | negflop; 

endmodule
