`include "packet.sv"
`include "interface.sv"
`include "driver.sv"
`include "environment.sv"
`include "assertion.sv"

//`include "TEST42.sv"


`ifdef  TEST11
    `include "TEST11.sv"
`elsif  TEST12
    `include "TEST12.sv"
`elsif  TEST13
    `include "TEST13.sv"
`elsif  TEST21
    `include "TEST21.sv"
`elsif  TEST41
    `include "TEST41.sv"
`elsif  TEST42
    `include "TEST42.sv"
`elsif  TESTMIX
    `include "TESTMIX.sv"
`elsif  TESTREAD
    `include "TESTREAD.sv"
`elsif  TEST44
    `include "TEST44.sv"
`elsif  TEST
    `include "TESTREAD.sv"
`elsif  TEST43
    `include "TEST43.sv"
`endif   

module top();
    	reg PCLK = 1;
    	reg clk = 1;
	
    	initial begin
      		forever #1 PCLK = ~PCLK;
 	end

	initial begin
      		forever #3 clk = ~clk;
 	end  


    	APB_I2C_IO apb_i2c_io(PCLK, clk);
    
    	dut_top DUT
    	(
        	.i2c_core_clock_i(apb_i2c_io.clk),
    		.pclk_i(apb_i2c_io.PCLK),
    		.preset_n_i(apb_i2c_io.PRESETn),
    		.penable_i(apb_i2c_io.PENABLE),        
    		.psel_i(apb_i2c_io.PSELx),                                                         
   	 	.paddr_i(apb_i2c_io.PADDR),                                                         
   	 	.pwdata_i(apb_i2c_io.PWDATA),                                                       
    		.pwrite_i(apb_i2c_io.PWRITE),                                                       
    		.prdata_o(apb_i2c_io.PRDATA),                                                        
    		.pready_o(apb_i2c_io.PREADY),                                                        
    		.sda_io(apb_i2c_io.i2c_sda),                                                         
    		.scl_io(apb_i2c_io.i2c_scl),
		.start(apb_i2c_io.start),
		.stop(apb_i2c_io.stop),
		.data_out(apb_i2c_io.data_out),
		.valid(apb_i2c_io.valid)
    	);
   	testcase test(apb_i2c_io);

    	assertion_cov acov(apb_i2c_io);
    	
endmodule
