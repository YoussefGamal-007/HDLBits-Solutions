module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    always@* begin 
        case({a,b,c,d}) 
            0,4,8,1,9,7,15,11,2,6: out = 1;
            default: out = 0;
        endcase
    end
endmodule
