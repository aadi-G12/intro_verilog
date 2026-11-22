module updowncounter32 (
  input clk, reset, up,
  output reg [31:0] count
);

  always @ (posedge clk) begin
    if (reset) begin
      count <= 32'd0;
    end else if (up) begin
      count <= count + 1;
    end else begin
      count <= count - 1;
    end
  end

endmodule
