module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter IDLE = 0 , START = 1 , DATA = 2 , STOP = 3 , DISCARD = 4 , PARITY = 5;
    reg [2:0] state , next_state;
    reg [3:0] count;
    always@(posedge clk) begin 
        if(reset)
            state <= IDLE;
        else 
            state <= next_state;
    end 
    
    always@* begin
        case(state)
            IDLE: next_state = in ? IDLE : START;
            START: next_state = DATA;
            DATA: next_state = (count == 8) ? PARITY : DATA;
            PARITY: next_state = in ? STOP : DISCARD;
            STOP: next_state = in ? IDLE : START ;
			DISCARD: next_state = in ? IDLE : DISCARD;
            default: next_state = IDLE;
        endcase
    end
    
    reg parity;
    always @(posedge clk) begin
            if (reset) begin
                done <= 0;
                count <= 0;
                parity <= 0;
            end
            else begin
                case(next_state) 
                    DATA : begin
                        done <= 0;
                        count <= count + 1;
                        parity <= 0;
                    end
                    PARITY: parity <= in;
                    
                    STOP : begin
                        if(^{temp , parity})
                        	done <= 1;
                        count <= 0;
                    end
                    default : begin
                        done <= 0;
                        count <= 0;
                        parity <= 0;
                    end
                endcase
            end
        end

    // New: Datapath to latch input bits.
     reg [7:0] temp;
     always@(posedge clk) begin
        if(reset) temp <= 0;
        else if(next_state == DATA)
           temp[count] <= in;
     end 
    //temp[0] = 0  >> should be this
    //temp[0] = 1  >> what happened
    assign out_byte = (done) ? temp : 8'b0;

    // New: Add parity checking.

endmodule
