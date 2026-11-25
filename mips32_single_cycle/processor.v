module processor (
  input clk, reset,
  input [31:0] instr, readData,
  output [31:0] ALUresult, writedata, pc,
  output memwrite
);

  wire regwrite, regdst, ALUsrc, branch, memtoreg, jump;
  wire [2:0] ALUcontrol;
  wire [5:0] opcode, funct;
  assign opcode = instr[31:26];
  assign funct = instr[5:0];

  control_unit cu (.opcode(opcode), .funct(funct), .regwrite(regwrite), .regdst(regdst),
    .ALUsrc(ALUsrc), .branch(branch), .memwrite(memwrite), .memtoreg(memtoreg), .jump(jump), .ALUcontrol(ALUcontrol) );

  datapath dp ( .clk(clk), .reset(reset), .instr(instr), .memtoreg(memtoreg), .branch(branch),
    .ALUsrc(ALUsrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .ALUcontrol(ALUcontrol), .readData(readData),
   .ALUresult(ALUresult), .writedata(writedata), .pc(pc) 
  );


endmodule
