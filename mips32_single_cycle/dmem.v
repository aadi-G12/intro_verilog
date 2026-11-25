module dmem (
  input clk, memwrite,
  input [31:0] ALUresult, writedata,
  output [31:0] readData
);

  reg [31:0] data_mem [0:63];

  assign readData = data_mem[ALUresult[7:2]];

  always @ (posedge clk) begin
    if (memwrite) begin
      data_mem[ALUresult[7:2]] <= writedata;
    end
  end

endmodule
