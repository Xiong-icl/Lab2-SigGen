module sigdelay #(

    parameter   ADDRESS_WIDTH = 9,
                DATA_WIDTH = 9
)(
    
    input logic clk,
    input logic rst,
    input logic wr,             
    input logic rd,
    input logic [DATA_WIDTH-1:0] mic_signal,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic [ADDRESS_WIDTH-1:0] incr,
    output logic [DATA_WIDTH-1:0] delayed_signal
);

    logic [ADDRESS_WIDTH-1:0] addr1, wr_addr, rd_addr;
    logic [DATA_WIDTH-1:0] din, dout;

counter counter(

    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .addr1 (addr1)
);

ramdualport ramdualport(

    .clk (clk),
    .wr (wr),
    .rd (rd),
    .rd_addr (rd_addr),
    .wr_addr (wr_addr),
    .dout (dout),
    .din (din)
);

always_ff @ (posedge clk)   begin
    if (rst) begin
        
        wr_addr <= {ADDRESS_WIDTH{1'b0}};
        rd_addr <= {ADDRESS_WIDTH{1'b0}};
    end
    else begin

        if (wr)
        wr_addr <= wr_addr + {{ADDRESS_WIDTH-1{1'b0}}, 1'b1};
        if (rd)
        rd_addr <= wr_addr - offset;
    end
end

always_ff @ (posedge clk) begin
    din <= mic_signal;
    delayed_signal <= dout;
    
end

endmodule
