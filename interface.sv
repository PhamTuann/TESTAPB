`ifndef INF
`define INF
`timescale 1ns/1ns
interface APB_I2C_IO(input PCLK, input clk);
	logic PRESETn;
	logic PENABLE;
	logic PSELx;
	logic [7:0] PADDR;
	logic [7:0] PWDATA;
	logic PWRITE;
	logic [7:0] PRDATA;
	wire PREADY;
	wire i2c_sda;
	wire i2c_scl;
	wire start;
	wire stop;
	wire [7:0] data_out;
	wire valid;
endinterface

`endif 