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
	env.drv.write_reg(8'h01, 8'b01100100);
	
	#30; // start -> idle
	env.drv.write_reg(8'h01, 8'b00000100);
	
	env.drv.write_reg(8'h01, 8'b00100100);	//reset
        env.drv.write_reg(8'h04, 8'h20);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b01100100);
	#200; // add_ack -> idle
	env.drv.write_reg(8'h01, 8'b00000100);

	env.drv.write_reg(8'h01, 8'b00100100);	//reset
        env.drv.write_reg(8'h04, 8'h20);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b01100100);
	#435; // 3 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);

	env.drv.write_reg(8'h01, 8'b00100100);	//reset
        env.drv.write_reg(8'h04, 8'h20);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b01100100);
	#1000; // 4 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);

	env.drv.write_reg(8'h01, 8'b00100100);	//reset
        env.drv.write_reg(8'h04, 8'h20);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b01100100);
	#877; // 4 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);

	env.drv.write_reg(8'h01, 8'b10100100);	//reset
        env.drv.write_reg(8'h04, 8'h20);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b11100100);
	#5880; // 4 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);

	env.drv.write_reg(8'h01, 8'b10100100);	//reset
        env.drv.write_reg(8'h04, 8'h24);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b11100100);
	#600; // 4 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);

	env.drv.write_reg(8'h01, 8'b10100100);	//reset
        env.drv.write_reg(8'h04, 8'h24);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b01100100);
	#600; // 4 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);
	
	env.drv.write_reg(8'h01, 8'b10100100);	//reset
        env.drv.write_reg(8'h04, 8'h21);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b11100100);
	#600; // 4 -> idle
	env.drv.write_reg(8'h01, 8'b00000100);
	
	env.drv.write_reg(8'h01, 8'b10100100);	//reset
        env.drv.write_reg(8'h04, 8'h21);   	//addresss
        env.drv.write_reg(8'h02, 8'h00);	//data
	env.drv.write_reg(8'h02, 8'h01);
	env.drv.write_reg(8'h01, 8'b11100100);
	//#600; // 4 -> idle
	//env.drv.write_reg(8'h01, 8'b00000100);
        #10000;
      $finish;
    end
endprogram     













