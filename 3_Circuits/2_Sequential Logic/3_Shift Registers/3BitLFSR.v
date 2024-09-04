module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    ff_mux inst0 (KEY[0] , KEY[1] , SW[0] , LEDR[2] , LEDR[0]);
    ff_mux inst1 (KEY[0] , KEY[1] , SW[1] , LEDR[0] , LEDR[1]);
    ff_mux inst2 (KEY[0] , KEY[1] , SW[2] , LEDR[2]^LEDR[1] , LEDR[2]);

endmodule

module ff_mux (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    always@(posedge clk) begin
        if(L)
            Q <= r_in;
        else
            Q <= q_in;
    end
endmodule