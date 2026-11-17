/* verilator lint_off BLKSEQ */

module clk_div5_tb ();
  reg reset;
  reg clk5_expected;
  reg check;
  wire clk5;
  reg clk;
  integer vectornum, errors;
  reg [2:0] testvectors [999:0];

  clk_div5 dutt (clk, reset, clk5);

  initial begin
    clk = 0;
    $dumpfile("clk_div5.vcd");
    $dumpvars;
  end

  always begin
    #5 clk = ~clk;
  end

  initial begin
    $readmemb("clk_div5.tv", testvectors);
    vectornum = 0; errors = 0;
  end

  always @ (posedge clk or negedge clk) begin
    #1
    {check, reset, clk5_expected} = testvectors[vectornum];
    #3
    if (check !== 1'b1) begin
      $display ("%d tests completed with %d errors", vectornum, errors);
      $finish;
    end else begin
      if (~reset && clk5 !== clk5_expected) begin
        $display ("Error at t=%0t: clk5 = %b (%b expected)", $time, clk5, clk5_expected);
        errors = errors + 1;
      end
      vectornum = vectornum + 1;
    end

  end

endmodule 
