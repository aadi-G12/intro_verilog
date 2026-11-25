module reg_file (
  input clk, regwrite,
  input [4:0] a1, a2, a3,
  input [31:0] wd3, 
  output [31:0] rd1, rd2
);

  reg [31:0] registers [0:31];

  //combinational read
  assign rd1 = (a1 != 0) ? registers[a1] : 32'b0;
  assign rd2 = (a2 != 0) ? registers[a2] : 32'b0;

  //synchronous write
  always @ (posedge clk) begin
    if (regwrite) begin
      registers[a3] <= wd3;
    end
  end

endmodule
