`ifndef RCV
`define RCV
`include"packet.sv"
`include "interface.sv"
class receiver;
	Packet pktcmp = new;
	
	typedef mailbox #(Packet) rx_box_type;
       	rx_box_type receiver_mbox = new;

    	virtual APB_I2C_IO apb_i2c_io;
	
    	function new (virtual APB_I2C_IO apb_i2c_io, rx_box_type receiver_mbox);

		this.apb_i2c_io = apb_i2c_io;	
		this.receiver_mbox = receiver_mbox;
    	endfunction
  
	task run();
        forever begin
        // @(posedge intf.clk)
        @(posedge apb_i2c_io.valid) begin
            pktcmp.PWDATA = apb_i2c_io.data_out;
			receiver_mbox.put(pktcmp);
		end
		
        end
	endtask
endclass
`endif 