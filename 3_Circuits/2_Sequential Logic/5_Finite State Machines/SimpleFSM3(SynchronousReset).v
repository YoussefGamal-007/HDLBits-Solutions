module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter A=0, B=1, C=2, D=3;
	reg [1:0] state;		// Make sure state and next are big enough to hold the state encodings.
	reg [1:0] next;
    

    //state transition logic   
    always@(*) begin
		case (state)
			A: next = in ? B : A;
			B: next = in ? B : C;
			C: next = in ? D : A;
			D: next = in ? B : C;
		endcase
    end


    // Edge-triggered always block (DFFs) for state flip-flops. Asynchronous reset.
    always @(posedge clk) begin
		if (reset) state <= A;
        else state <= next;
	end
		
		
	// output logic		
	assign out = (state==D);
	
endmodule

