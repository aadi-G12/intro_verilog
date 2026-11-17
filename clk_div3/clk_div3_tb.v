/* verilator lint_off BLKSEQ */

module clk_div3_tb ();
  reg reset;
  reg clk3_expected;
  reg check;
  wire clk3;
  reg clk;
  integer vectornum, errors;
  reg [2:0] testvectors [999:0];

  clk_div3 dutt (clk, reset, clk3);

  initial begin
    clk = 0;
    $dumpfile("clk_div3.vcd");
    $dumpvars;
  end

  always begin
    #5 clk = ~clk;
  end

  initial begin
    $readmemb("clk_div3.tv", testvectors);
    vectornum = 0; errors = 0;
  end

  always @ (posedge clk or negedge clk) begin
    #1
    {check, reset, clk3_expected} = testvectors[vectornum];
    #3
    if (check !== 1'b1) begin
      $display ("%d tests completed with %d errors", vectornum, errors);
      $finish;
    end else begin
      if (~reset && clk3 !== clk3_expected) begin
        $display ("Error at t=%0t: clk3 = %b (%b expected)", $time, clk3, clk3_expected);
        errors = errors + 1;
      end
      vectornum = vectornum + 1;
    end

  end

endmodule 
