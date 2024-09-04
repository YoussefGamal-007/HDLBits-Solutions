module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] temp;
    always@(posedge clk)
        temp <= in;
    
    always@(posedge clk) begin
        if(reset) 
            out <= 0;
    	else begin
            for(int i = 0 ; i < 32 ; i = i + 1)
                begin
                    out[i] <= (temp[i] && ~in[i]) ? 1 : out[i];
                end
        end
    end
            

endmodule
