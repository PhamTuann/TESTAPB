`ifndef DRIVER
`define DRIVER
`include"packet.sv"
`include "interface.sv"
class driver;
	Packet pkt;
	
	typedef mailbox #(Packet) out_box_type;
       	out_box_type driver_mbox = new;

    	virtual APB_I2C_IO apb_i2c_io;
	
	covergroup COVER@(posedge apb_i2c_io.PCLK);
	REG_COV: coverpoint apb_i2c_io.PADDR {
			bins prescaler = {8'h00};
			bins cmd = {8'h01};
			bins trasnmit = {8'h02};
			bins receive = {8'h03};
			bins address = {8'h04};
			bins status = {8'h05};
			
		}
	PWRITE_COV: coverpoint apb_i2c_io.PWRITE;

	RW_REG_COV: cross REG_COV, PWRITE_COV {
		option.cross_auto_bin_max = 0;
		bins read_prescaler = binsof(REG_COV.prescaler) && binsof(PWRITE_COV) intersect{0};
		bins read_cmd = binsof(REG_COV.cmd) && binsof(PWRITE_COV) intersect{0};
		bins read_trasnmit = binsof(REG_COV.trasnmit) && binsof(PWRITE_COV) intersect{0};
		bins read_receive = binsof(REG_COV.receive) && binsof(PWRITE_COV) intersect{0};
		bins read_address = binsof(REG_COV.address) && binsof(PWRITE_COV) intersect{0};
		bins read_status = binsof(REG_COV.status) && binsof(PWRITE_COV) intersect{0};

		bins write_prescaler = binsof(REG_COV.prescaler) && binsof(PWRITE_COV) intersect{1};
		bins write_cmd = binsof(REG_COV.cmd) && binsof(PWRITE_COV) intersect{1};
		bins write_trasnmit = binsof(REG_COV.trasnmit) && binsof(PWRITE_COV) intersect{1};
		bins write_address = binsof(REG_COV.address) && binsof(PWRITE_COV) intersect{1};
	}
 
	PWDATA_COV: coverpoint apb_i2c_io.PWDATA {
		bins data = {[0:7]};
		bins address_w = {8'h20};
		bins address_r = {8'h21};
	}

	I2C_RW: cross PWDATA_COV, REG_COV, PWRITE_COV {
		option.cross_auto_bin_max = 0;
		bins i2c_r = binsof(REG_COV.address) && binsof(PWRITE_COV) intersect{1} && binsof(PWDATA_COV.address_r);
		bins i2c_w = binsof(REG_COV.address) && binsof(PWRITE_COV) intersect{1} && binsof(PWDATA_COV.address_w);
	}
	
	endgroup

    	function new (Packet pkt, virtual APB_I2C_IO apb_i2c_io, out_box_type driver_mbox);
       	 	this.pkt = pkt;	
		this.apb_i2c_io = apb_i2c_io;	
		this.driver_mbox = driver_mbox;
		COVER = new ();
    	endfunction
	real cov1;
	task reset();
		$display ($time, "ns:  [RESET] Reset Start");
		apb_i2c_io.PRESETn = 0; 
		repeat(10) @(apb_i2c_io.PCLK);
		apb_i2c_io.PRESETn = 1;
		$display ($time, "ns:  [RESET] Reset End");
	endtask

	

	task write_reg(input bit [7:0] PADDR, reg [7:0] PWDATA);
		pkt = new();
		$display ($time, "ns:  [WRITE REG] Start");
		apb_i2c_io.PWRITE = 1;
		apb_i2c_io.PSELx = 1;
		//pkt.PADDR = PADDR;
		apb_i2c_io.PADDR = PADDR;
		@(posedge apb_i2c_io.PCLK);
		apb_i2c_io.PWDATA = PWDATA;
		apb_i2c_io.PENABLE = 1;
		@(posedge apb_i2c_io.PCLK);
		apb_i2c_io.PSELx = 0;
		apb_i2c_io.PENABLE = 0;
		if(PADDR == 8'h02) begin
			pkt.PWDATA = PWDATA;
			driver_mbox.put(pkt);
		end
		@(posedge apb_i2c_io.PCLK);
		$display($time, "ns:  [WRITE DONE] Data %x to reg %x", PWDATA, PADDR);
	
	endtask

	task read_reg(input bit [7:0] PADDR);
		pkt = new ();
		$display ($time, "ns:  [READ REG] Start");
		apb_i2c_io.PWRITE = 0;
		apb_i2c_io.PSELx = 1;
		apb_i2c_io.PADDR = PADDR;
		@(posedge apb_i2c_io.PCLK);
		apb_i2c_io.PENABLE = 1;
		@(posedge apb_i2c_io.PCLK);
		apb_i2c_io.PSELx = 0;
		apb_i2c_io.PENABLE = 0;
		@(posedge apb_i2c_io.PCLK);
		$display($time, "ns:  [READ Done] Data %x read from reg %x", apb_i2c_io.PWDATA, PADDR);
	endtask

	


  

endclass
`endif 