module top (input logic  clk, reset,
	    output logic [31:0] write_data,
	    output logic [31:0] data_adr,
	    output logic mem_write);


logic [31:0] pc, instr, read_data;

//instanciamos processor and memories
//data_adr = alu_result en el modulo principal de riscv
riscv rv_monociclo(clk, reset, instr, read_data, mem_write, pc,data_adr, write_data);

imem imem_inst(pc,instr);

dmem dmem_inst (clk, mem_write, data_adr, write_data, read_data);

endmodule



