module control_unit (
  input [5:0] opcode, funct,
  output regwrite, regdst, ALUsrc, branch, memwrite, memtoreg, jump,
  output [2:0] ALUcontrol
);

  wire [1:0] ALUop;
  main_dec main_decoder ( .opcode(opcode), .regwrite(regwrite), .regdst(regdst), .ALUsrc(ALUsrc), .branch(branch), .memwrite(memwrite), .memtoreg(memtoreg), .jump(jump), .ALUop(ALUop) );
  alu_dec alu_decoder ( .ALUop(ALUop), .funct(funct), .ALUcontrol(ALUcontrol) );

endmodule
