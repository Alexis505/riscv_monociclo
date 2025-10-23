module controller (input logic [6:0] op_code,
		   input logic [2:0] funct_3,
		   input logic funct_7,
		   input logic zero,
		   output logic pc_src,
	           output logic [1:0] result_src,
		   output logic mem_write,
		   output logic [2:0] alu_control,
		   output logic alu_src,
		   output logic [1:0] imm_src,
		   output logic reg_write);

logic [1:0] alu_op;
logic branch;
logic jump;

//zero no entra a main decoder porque se usa aqui mismo dentro de controller
maindec md(op_code, result_src, mem_write, branch, alu_src, reg_write, jump, imm_src, alu_op);

aludec ad(op_code[5], funct_3, funct_7, alu_op, alu_control);

assign pc_src = branch & zero | jump;

endmodule





