module imem (
  input [31:0] pc,
  output [31:0] instr
);
  
  wire [31:0] instr_mem [0:31];

  assign instr = instr_mem[pc];

endmodule
