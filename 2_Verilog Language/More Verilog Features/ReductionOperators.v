module top_module (
    input [7:0] in,
    output parity); 
	
    /* even parity means to make the number of ones even number so if the 
    	number of the ones in the 8bits is 3 then parity should be 1 to 
        make the whole number of ones even, so by that if the 8 bit input
        has odd number of ones we will make parity high else if the input 
        already has even number of ones make parity low 
        what is just described is odd number detector which is just simple XOR */
    assign parity = ^ in ;
endmodule
