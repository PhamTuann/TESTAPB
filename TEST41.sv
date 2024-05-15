`include "environment.sv"
`timescale 1ns/1ns


// 

program testcase(APB_I2C_IO apb_i2c_io);
    environment env = new(apb_i2c_io);
    initial begin
        env.drv.reset();
        env.drv.write_reg(8'h00, 8'b00000100);    //prescale
	env.drv.write_reg(8'h01, 8'b00100100);	//reset
	env.drv.write_reg(8'h04, 8'h10);   	//addresss
        #10000;
       $finish;
    end
endprogram     













