module datapath (input logic clk,
		 input logic reset,
		 input logic pc_src,
		 input logic [1:0] result_src,
		 input logic [2:0] alu_control,
		 input logic alu_src,
		 input logic [1:0] imm_src,
		 input logic reg_write,
		 input logic [31:0] instr,
		 input logic [31:0] read_data,
		 output logic zero,
		 output logic [31:0] pc,
		 output logic [31:0] alu_result,
		 output logic [31:0] write_data);


//la forma de escribir un codigo complejo como esto es ir por partes asi como
//esta en el esquematico 
logic [31:0] pc_next;
logic [31:0] pc_plus4;
logic [31:0] imm_ext;
logic [31:0] pc_target;
logic [31:0] src_a;
logic [31:0] src_b;
logic [31:0] result;
//empezamos por el program counter
//program counter = pc
flop #(32) flop_pc(clk,reset,pc_next,pc);
adder adder_pc(pc,32'b100,pc_plus4);
adder pcadd_branch(pc, imm_ext, pc_target);
mux2 #(32) pc_mux(pc_plus4, pc_target, pc_src, pc_next);

//logica para el archivo de registros
regfile regfile_instance(clk,reg_write,instr[19:15],instr[24:20],instr[11:7],result,src_a,write_data);
extend ext_inst(instr[31:7], imm_src, imm_ext);
//logica de alu 
mux2 #(32) srcb_mux(write_data, imm_ext, alu_src,src_b);
alu        alu_inst(src_a, src_b, alu_control,alu_result,zero);
mux3 #(32) result_mux(alu_result,read_data,pc_plus4,result_src, result);


endmodule






