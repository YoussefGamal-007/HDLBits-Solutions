module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    reg [3:0] register;
    always@(posedge clk) begin
        if(!resetn)
            register <= 0;
        else 
            register <= {in,register[3:1]};
    end
    
    assign out = register[0];
endmodule
