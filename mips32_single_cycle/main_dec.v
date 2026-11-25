module main_dec (
  input [5:0] opcode,
  output memtoreg, memwrite, branch, ALUsrc, regdst, regwrite, jump,
  output reg [1:0] ALUop
);

  reg [6:0] controls;

  always @ (*) begin
    case (opcode)
      6'b0 : controls = 7'b1100000;
      6'b100011 : controls = 7'b1010010;
      6'b101011 : controls = 7'b0010100;
      6'd4 : controls = 7'b0001000;
      6'd8 : controls = 7'b1010000;
      6'd2 : controls = 7'b0000001;
      default : controls = 7'b0;
    endcase
  end

  always @ (*) begin
    case (opcode)
      6'b0 : ALUop = 2'b10; 
      6'b100011 : ALUop = 2'b0; 
      6'b101011 : ALUop = 2'b0;
      6'd4 : ALUop = 2'b01; 
      6'd8 : ALUop = 2'b0;
      6'd2 : ALUop = 2'b0;
      default : ALUop = 2'b0;
    endcase
  end

  assign {regwrite, regdst, ALUsrc, branch, memwrite, memtoreg, jump} = controls;


endmodule 
