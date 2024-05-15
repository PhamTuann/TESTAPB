`include "environment.sv"
`timescale 1ns/1ns


// 

program testcase(APB_I2C_IO apb_i2c_io);
    environment env = new(apb_i2c_io);
    initial begin
       	env.drv.reset();
        env.drv.write_reg(8'h00, 8'b00000100);    //prescale
	env.drv.write_reg(8'h01, 8'b00100100);	//reset
        env.drv.write_reg(8'h04, 8'h20);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h02, 8'h02);
	env.drv.write_reg(8'h02, 8'h03);
	env.drv.write_reg(8'h02, 8'h04);
	env.drv.write_reg(8'h02, 8'h05);
	env.drv.write_reg(8'h02, 8'h06);
	env.drv.write_reg(8'h02, 8'h07);
	env.drv.write_reg(8'h02, 8'h08);
	env.drv.write_reg(8'h02, 8'h09);
	env.drv.write_reg(8'h02, 8'h10);
	env.drv.write_reg(8'h01, 8'b01100100);  	//addresss
	#4260;
	env.drv.write_reg(8'h04, 8'h21);
	env.drv.write_reg(8'h01, 8'b01100100);
        #2650;
	env.drv.write_reg(8'h01, 8'b00000100);
	#50;
	env.drv.write_reg(8'h01, 8'b00100100);
	env.drv.write_reg(8'h04, 8'h21);
	env.drv.write_reg(8'h01, 8'b01100100);
	#1000
	env.drv.read_reg(8'h00);
	env.drv.read_reg(8'h03);
	#100
	env.drv.read_reg(8'h03);
	#100
	env.drv.read_reg(8'h03);
	#100
	env.drv.read_reg(8'h03);
	#100
	env.drv.read_reg(8'h03);
	#100
	env.drv.read_reg(8'h03);
	#100
	env.drv.read_reg(8'h03);
	#100
	#10000;
      $finish;
    end
endprogram     












