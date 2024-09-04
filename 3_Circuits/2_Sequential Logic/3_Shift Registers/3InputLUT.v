module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg [0:7] q;
    always@(posedge clk) begin
        if(enable)
        	q <= {S , q[0:6]};
    end 
    
    assign Z = q[{A,B,C}];
endmodule
