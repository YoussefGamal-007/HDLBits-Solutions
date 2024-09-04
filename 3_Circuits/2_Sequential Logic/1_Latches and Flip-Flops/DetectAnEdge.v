module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] q;
    always@(posedge clk) begin
        q <= in;
    end
    
    // assign pedge = ~q & in;
    always@(posedge clk)
        pedge <= ~q & in;

endmodule
