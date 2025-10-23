module riscv (input logic clk,
	      input logic reset,
	      input logic [31:0] instr,
	      input logic [31:0] read_data,
	      output logic mem_write,
	      output logic [31:0] pc, 
	      //la senal alu_result es salida cuando esta establece
	      //la direccion en memoria de un dato data_address
	      output logic [31:0] alu_result,
	      output logic [31:0] write_data);

//la senal de pc o program counter va a la memoria de instrucciones
// las senales de data_adr y write_data van hacia la memoria de datos
//el controlador debe recibir solo como entrada la instrucciones para 
//decodificarla

logic reg_write;
logic [1:0] imm_src;
logic alu_src;
logic [2:0] alu_control;
logic [1:0] result_src;
logic [1:0] pc_src; //no aparece en el libro en modulo principal
//logic reg_src; // no aparece en el libro en modulo principal
//reg_src aparece en un esquematico, pero en las explicaciones nunca se usa
//se agregara si se necesita.
logic zero;
logic jump;

controller controller_1 (instr[6:0], instr[14:12], instr[30], zero, pc_src, result_src, mem_write, alu_control, alu_src, imm_src, reg_write);

datapath dp(clk, reset, pc_src, result_src, alu_control, alu_src, imm_src, reg_write , instr, read_data, zero, pc, alu_result, write_data);

endmodule

