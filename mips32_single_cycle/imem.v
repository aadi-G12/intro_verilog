module imem (
  input [31:0] pc,
  output [31:0] instr
);

  reg [31:0] instr_mem [0:63];

  initial
  begin
    $readmemh ("memfile.dat", instr_mem);
  end

  assign instr = instr_mem[pc[7:2]];

endmodule
