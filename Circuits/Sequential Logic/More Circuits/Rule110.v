module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    always@(posedge clk) begin
        if(load)
            q[510:1] <= data[510:1];
        else begin
            for(int i = 1 ; i < 511 ; i = i + 1)
                begin
                    q[i] <= (q[i-1] ^ q[i]) |(!q[i+1] &q[i-1]);
                end 
        end 
    end
    
    always@(posedge clk) begin
        if(load) begin
            q[511] <= data[511];
            q[0] <= data[0];
        end
        else begin
            q[511] <= (q[510] ^ q[511]) |(q[510]);
            q[0] <= q[0];
        end
    end

endmodule
