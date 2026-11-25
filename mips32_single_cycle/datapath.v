module datapath (
  input clk, reset,
  input [31:0] instr, 
  input memtoreg, branch, ALUsrc, regdst, regwrite, jump,
  input [2:0] ALUcontrol,
  input [31:0] readData,
  output [31:0] ALUresult, writedata,
  output [31:0] pc
);

  wire [31:0] pcnext;

  pc program_counter ( .reset(reset), .clk(clk), .pcnext(pcnext), .pc(pc) );

  wire [4:0] writereg;
  assign writereg = regdst ? instr[15:11] : instr[20:16]; 

  wire [31:0] srcA, srcB;
  wire [31:0] wd3;
  wire [31:0] rd2out;

  assign wd3 = memtoreg ? readData : ALUresult;

  reg_file register_file ( .clk(clk), .regwrite(regwrite), .a1(instr[25:21]), .a2(instr[20:16]), .a3(writereg), .wd3(wd3), .rd1(srcA), .rd2(rd2out) );

  assign writedata = rd2out;

  wire [31:0] signImm;
  wire [31:0] signImmx4;
  assign signImm = { {16{instr[15]}}, instr[15:0] };
  assign signImmx4 = signImm << 2;

  assign srcB = ALUsrc ? signImm : rd2out;
  
  wire [31:0] pcbranch;
  wire [31:0] pcplus4;

  adder advancepc (pc, 32'd4, pcplus4);
  adder pcbranchadder (signImmx4, pcplus4, pcbranch);

  wire [3:0] aluflags;

  ALU alu ( .f(ALUcontrol), .a(srcA), .b(srcB), .y(ALUresult), .ALUflags(aluflags) );
  
  wire pcSrc;
  assign pcSrc = aluflags[2] & branch;
  
  wire [31:0] jumppc;
  assign jumppc = {pcplus4[31:28], instr[25:0], 2'b0}; 

  assign pcnext = jump ? jumppc : pcSrc ? pcbranch : pcplus4;


endmodule
