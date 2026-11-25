module mips32_single_cycle_tb ();

  reg clk, reset;

  wire [31:0] writedata, data_addr, pc;
  wire memwrite;

  top dutt (clk, reset, pc, writedata, data_addr, memwrite);

  //initial reset
  initial begin
    $dumpfile("mips32_single_cycle_proc.vcd");
    $dumpvars;
    clk = 0;
    reset = 1; #15 reset = 0;
  end

  //clockgen
  always begin
    #5 clk = ~clk;
  end

  always @ (negedge clk) begin
    if (memwrite) begin
      if (data_addr === 84 & writedata === 7) begin
        $display ("Success");
        $finish;
      end else if (data_addr !== 80) begin
        $display ("Simulation failed");
        $finish;
      end
    end
  end

endmodule 
