`ifndef ENV
`define ENV

`include "driver.sv"
`include "packet.sv"
`include "interface.sv"
`include "scoreboard.sv"
`include "receiver.sv"
class environment;
    	driver drv;
	Packet pkt;
	receiver rcv;
	Scoreboard scb;
    	virtual APB_I2C_IO apb_i2c_io;

    	function new(virtual APB_I2C_IO apb_i2c_io);
       	 	scb = new();
		drv = new(pkt,apb_i2c_io, scb.driver_mbox);
		rcv = new(apb_i2c_io,scb.receiver_mbox);
    	endfunction
endclass

`endif 