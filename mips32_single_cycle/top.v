module top (
  input clk, reset,
  output [31:0] pc, writedata, data_addr,
  output memwrite
);

  wire [31:0] instr, readData;

  processor proc ( .clk(clk), .reset(reset), .instr(instr), .readData(readData), .writedata(writedata), 
    .ALUresult(data_addr), .pc(pc), .memwrite(memwrite) );

  dmem datamem ( .clk(clk), .memwrite(memwrite), .ALUresult(data_addr), .writedata(writedata), 
    .readData(readData) );

  imem instrmem ( .pc(pc), .instr(instr) );

endmodule
