module hps_interface
(
    // HPS interface
    input      [31:0]  gp_in,
    output reg [31:0]  gp_out,
    output reg         io_strobe,

    // HPS SPI
    input  spi_mosi,
    output spi_miso,
    input  spi_clk,
    input  spi_cs,

    // other HPS signals
    input fpga_enable,
    input osd_enable,
    input io_enable,

    input  clk_sys,
    input  reset
);

wire [15:0] gp_word_in;
wire [15:0] gp_word_out;
wire        spi_rx_strobe;

spi_slave spi_slave (
    .spi_device__sck(spi_clk),
    .spi_device__sdo(spi_miso),
    .spi_device__sdi(spi_mosi),
    .spi_device__cs(spi_cs),
    .word_in(gp_word_out),
    .word_out(gp_word_in),
    .word_complete(spi_rx_strobe),
    .clk(clk_sys),
    .rst(reset)
);

assign gp_word_in = gp_in[15:0];

always @(posedge clk_sys)
begin
    gp_out <= {
        11'b0,         // [31:21]
        io_enable,     // [20]
        osd_enable,    // [19]
        fpga_enable,   // [18]
        2'b0,          // [17:16]
        gp_word_out       // [15:0]
    };
    io_strobe <= spi_rx_strobe;
end

endmodule
