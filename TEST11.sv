`include "environment.sv"
`timescale 1ns/1ns


// 

program testcase(APB_I2C_IO apb_i2c_io);
    environment env = new(apb_i2c_io);
    initial begin
        env.drv.reset();
	env.drv.read_reg(8'h00);
	@(posedge apb_i2c_io.PCLK);
	env.drv.read_reg(8'h01);
	@(posedge apb_i2c_io.PCLK);
	env.drv.read_reg(8'h02);
	@(posedge apb_i2c_io.PCLK);
	env.drv.read_reg(8'h03);
	@(posedge apb_i2c_io.PCLK);
	env.drv.read_reg(8'h04);
	@(posedge apb_i2c_io.PCLK);
	env.drv.read_reg(8'h05);
        #10000;
       $finish;
    end
endprogram     













