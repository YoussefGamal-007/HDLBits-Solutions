module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    /////////////////////////////////////////////............FSM...........///////////////////////////////////////////
    parameter [3:0] IDLE	= 0,
					 S1		= 1,
					 S11	= 2,
					 S110	= 3,
					 S1101	= 4,	
					 SHIFT1 = 5,
					 SHIFT2 = 6,
					 SHIFT3 = 7,
					 COUNT  = 8,
					 DONE   = 9; 
    reg [3:0] state, next_state;
    
    // internal signals 
    wire shift_ena;

    // state memory
    always @(posedge clk) begin
		if (reset) state <= IDLE;
		else state <= next_state;
	end
    
    // next state logic
	always @(*) begin
		case (state) 
			IDLE  : next_state = (data) ? S1    : IDLE;
			S1    : next_state = (data) ? S11   : IDLE;
			S11   : next_state = (data) ? S11   : S110;
			S110  : next_state = (data) ? S1101 : IDLE;
			S1101 : next_state = SHIFT1;
			SHIFT1: next_state = SHIFT2;
			SHIFT2: next_state = SHIFT3;
			SHIFT3: next_state = COUNT;
			COUNT : next_state = (done_counting) ? DONE : COUNT;
			DONE  : next_state = (ack) ? IDLE : DONE;			
		endcase
	end

    // output logic
	assign shift_ena = ((state == S1101) | (state == SHIFT1) | (state == SHIFT2) | (state == SHIFT3));
	assign counting = (state == COUNT);
	assign done = (state == DONE);
    
    /////////////////////////////////////////////............Shifter...........///////////////////////////////////////////
    
    // internal signals
    wire count_ena;
    
    always@(posedge clk) begin
        if(shift_ena)
            count <= {count[2:0] , data};
        else if(count_ena)
            count <= count - 1;
        else 
            count <= count;
    end
    
    /////////////////////////////////////////////............Counter...........///////////////////////////////////////////

    // internal signals
    reg [9:0] q;
    wire done_counting;
    always@(posedge clk) begin
        if(reset)
            q <= 0;
        else if(q == 999) 
            q <= 0;
        else if((state == COUNT) && (count >= 0))
            q <= q + 1;
    end 

    assign count_ena = (q == 999);
    assign done_counting = (count == 0 && q == 999);
endmodule
