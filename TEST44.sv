`include "environment.sv"
`timescale 1ns/1ns


// 

program testcase(APB_I2C_IO apb_i2c_io);
    environment env = new(apb_i2c_io);
    initial begin
        fork begin
        env.drv.reset();
        env.drv.write_reg(8'h00, 8'b00000100);    //prescale
	env.drv.write_reg(8'h01, 8'b00100100);		//reset
        env.drv.write_reg(8'h04, 8'h20);  	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);	//data
	env.drv.write_reg(8'h02, 8'h02);	//data
	env.drv.write_reg(8'h02, 8'h03);	//data
	env.drv.write_reg(8'h02, 8'h04);	//data
	env.drv.write_reg(8'h02, 8'h05);	//data
	env.drv.write_reg(8'h02, 8'h06);	//data
	env.drv.write_reg(8'h02, 8'h07);	//data
	env.drv.write_reg(8'h01, 8'b01100100);
	#250;
	env.drv.write_reg(8'h01, 8'b11100100);
	env.drv.write_reg(8'h04, 8'h20);
	end
	env.rcv.run();
	env.scb.check();
	join_any  	
        #10000;
   $finish;
    end
endprogram     











