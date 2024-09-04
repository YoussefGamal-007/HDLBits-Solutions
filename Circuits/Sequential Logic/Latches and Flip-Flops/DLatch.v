module top_module (
    input d, 
    input ena,
    output q);

    always@(ena , d)
        if(ena)
            q = d;
        
endmodule
