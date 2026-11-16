/* verilator lint_off BLKSEQ */

module serial_2scomp_tb ();
  reg a;
  reg start;
  reg q_expected;
  wire q;
  reg clk;
  integer vectornum, errors;
  reg [2:0] testvectors [31:0];

  serial_2scomp dutt (clk, a, start, q);

  initial begin
    clk = 0;
    $dumpfile("serial_2scomp.vcd");
    $dumpvars;
  end

  always begin
    #5 clk = ~clk;
  end

  initial begin
    $readmemb("serial_2scomp.tv", testvectors);
    vectornum = 0; errors = 0;
  end

  always @ (posedge clk) begin
    #1
    {start, a, q_expected} = testvectors[vectornum];
  end

  always @ (negedge clk) begin
    if (~start) begin
      if (q !== q_expected) begin
        $display ("Error: inputs = %b", {a});
        $display (" outputs  = %b (%b expected)",
          q, q_expected);
        errors = errors + 1;
      end
    end
    vectornum = vectornum + 1;
    if (vectornum == 32) begin
      $display ("%d tests completed with %d errors", vectornum, errors);
      $finish;
    end
  end
endmodule
