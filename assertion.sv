`ifndef ASSERT
`define ASSERT

module assertion_cov(APB_I2C_IO apb_i2c_io);
    // PREADY CHECK
    	PREADY_CHECK: cover property (@(posedge apb_i2c_io.PCLK) (apb_i2c_io.PSELx && !apb_i2c_io.PENABLE) |=> (apb_i2c_io.PENABLE) |-> (apb_i2c_io.PREADY));
 
    	WRITE_CHECK: cover property (@(posedge apb_i2c_io.PCLK) ((apb_i2c_io.PWRITE) |-> (apb_i2c_io.PADDR ==  8'h00 || apb_i2c_io.PADDR ==  8'h01 || apb_i2c_io.PADDR ==  8'h02 || apb_i2c_io.PADDR ==  8'h04 )));
	 
	READ_CHECK: cover property (@(posedge apb_i2c_io.PCLK) ((!apb_i2c_io.PWRITE) |-> (apb_i2c_io.PADDR)));
	 
	PRESETn_CHECK: cover property (@(posedge apb_i2c_io.PCLK) (!apb_i2c_io.PRESETn) |-> apb_i2c_io.PREADY && !apb_i2c_io.PRDATA);
	
    
endmodule
`endif 