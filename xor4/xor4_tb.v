/* verilator lint_off BLKSEQ */

module xor4_tb ();
	reg [3:0] a;
	reg y_expected;
	wire y;
	reg clk;
	integer vectornum, errors;
	reg [4:0] testvectors [15:0];

	xor4 dutt (a, y);
	
	initial begin
		clk = 0;
		$dumpfile("xor4.vcd");
		$dumpvars;
	end
	
	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		$readmemb("xor4.tv", testvectors);
		vectornum = 0; errors = 0;
	end

	always @ (posedge clk) begin
		#1
		{a, y_expected} = testvectors[vectornum];
	end

	always @ (negedge clk) begin
		if (y !== y_expected) begin
			$display ("Error: inputs = %b", {a});
			$display (" outputs  = %b (%b expected)",
				y, y_expected);
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (vectornum == 16) begin
			$display ("%d tests completed with %d errors", vectornum, errors);
			$finish;
		end
	end
endmodule
