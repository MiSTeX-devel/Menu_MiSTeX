`timescale 1ns/10ps
module  pll_0002(
	input wire refclk,
	input wire rst,
	output wire outclk_0,
	output wire outclk_1,
	output wire locked
);

`ifdef CYCLONEV
	altera_pll #(
		.fractional_vco_multiplier("false"),
		.reference_clock_frequency("50.0 MHz"),
		.operation_mode("direct"),
		.number_of_clocks(2),
		.output_clock_frequency0("100.000000 MHz"),
		.phase_shift0("0 ps"),
		.duty_cycle0(50),
		.output_clock_frequency1("20.000000 MHz"),
		.phase_shift1("0 ps"),
		.duty_cycle1(50),
		.pll_type("General"),
		.pll_subtype("General")
	) altera_pll_i (
		.rst	(rst),
		.outclk	({outclk_1, outclk_0}),
		.locked	(locked),
		.fboutclk	( ),
		.fbclk	(1'b0),
		.refclk	(refclk)
	);
`else
	ALTPLL #(
		.BANDWIDTH_TYPE("AUTO"),
		.CLK0_DIVIDE_BY(10'd15),
		.CLK0_DUTY_CYCLE(6'd50),
		.CLK0_MULTIPLY_BY(10'd30), // 100MHz = 50MHz * 30 / 15
		.CLK0_PHASE_SHIFT(1'd0),
		.CLK1_DIVIDE_BY(10'd75),
		.CLK1_DUTY_CYCLE(6'd50),
		.CLK1_MULTIPLY_BY(10'd30), // 20MHz = 50MHz * 30 / 75
		.CLK1_PHASE_SHIFT(1'd0),
		.COMPENSATE_CLOCK("CLK0"),
		.INCLK0_INPUT_FREQUENCY(15'd20000),
		.OPERATION_MODE("NORMAL")
	) altera_pll_i (
		.ARESET(1'd0),
		.CLKENA(5'd31),
		.EXTCLKENA(4'd15),
		.FBIN(1'd1),
		.INCLK(refclk),
		.PFDENA(1'd1),
		.PLLENA(1'd1),
		.CLK({outclk_1, outclk_0}),
		.LOCKED(locked)
	);
`endif
endmodule

