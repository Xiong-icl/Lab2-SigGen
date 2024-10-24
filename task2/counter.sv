module counter #(
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [WIDTH-1:0] incr,
    output logic [WIDTH-1:0] addr1,
    output logic [WIDTH-1:0] addr2
);

always_ff @ (posedge clk)
    if(rst) 
        addr1<= {WIDTH{1'b0}};
    
    else  
        addr1 <= addr1 + {{WIDTH-1{1'b0}}, en};
    

endmodule
