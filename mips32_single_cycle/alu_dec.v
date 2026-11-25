module alu_dec (
  input [1:0] ALUop,
  input [5:0] funct,
  output reg [2:0] ALUcontrol
);

  always @ (*) begin
    if (ALUop == 2'b0) begin
      ALUcontrol = 3'b010;
    end else if (ALUop[0] == 1'b1) begin
      ALUcontrol = 3'b110;
    end else begin
      case (funct)
        6'b100000 : ALUcontrol = 3'b010;
        6'b100010 : ALUcontrol = 3'b110;
        6'b100100 : ALUcontrol = 3'b000;
        6'b100101 : ALUcontrol = 3'b001;
        6'b101010 : ALUcontrol = 3'b111;
        default : ALUcontrol = 3'b0;
      endcase
    end
  end

endmodule
