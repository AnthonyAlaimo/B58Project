 module fsm(
    input clock, 
    input update, 
    input reset, 
	input blow,
	output reg load,
    output reg [7:0] load_x,
    output reg [6:0] load_y,
    input continueDraw, 
    input complete_player,
    input complete_m1,
    input complete_m2,
    input complete_start,
    input [7:0] player_x,
    input [6:0] player_y,
    input [7:0] m1_x,
    input [6:0] m1_y,
    input [7:0] m2_x,
    input [6:0] m2_y,
    output reg draw_player,
    output reg draw_d_player,
    output reg draw_m1,
    output reg draw_m2,
    output reg draw_start,
    output reg shift_h, 
    output reg shift_v, 
    output reg clear, 
    output reg [6:0] shift_amount, 
    output reg writeEn, 
    output [4:0] state
    );
    
    reg [4:0] curState, nextState;
	reg [6:0] velocity;

    localparam  start = 5'b10110,
                eStart = 5'b11011,
                ePlayer = 5'b00000, 
                dPlayer = 5'b00001, 
                eM1 = 5'b00010, 
                dM1 = 5'b00011, 
                eM2 = 5'b00100, 
                dM2 = 5'b00101, 
                detectHits = 5'b01110, 
                load_dead = 5'b11100,
                dead = 5'b11110,
                load_player = 5'b00110,
                load_m1 = 5'b11000,
                load_m2 = 5'b10101,
                gameOver = 5'b01111, 
                idle = 5'b10010;
    
	assign state = curState;

   reg resetting;

	initial begin
	    curState <= load_player;
		velocity <= 1'b0;
        resetting <= 1'b1;
	end

    always@(*) 
    begin: state_table
        case(curState)
            start: begin
                if(blow == 1'b1)
                    nextState <= eStart;
                else
                    nextState <= start;
					end
            eStart: begin
                if(complete_start == 1'b1)
                    nextState <= ePlayer;
                else
                    nextState <= eStart;
					end
            ePlayer: begin
                if(complete_player == 1'b1) begin
                    if (resetting == 1'b1)
                        nextState <= eM1;
                    else
                        nextState <= dPlayer;
							end
                else
                    nextState <= ePlayer;
            end
            
            dPlayer: begin
                if(complete_player == 1'b1)
					nextState <= eM1;
                else
                    nextState <= dPlayer;
            end

            eM1: begin
                if(complete_m1 == 1'b1) begin 
                    if (resetting == 1'b1)
                        nextState <= eM2;
                    else
                        nextState <= dM1;
						end
                else
                    nextState <= eM1;
            end

            dM1: begin
                if(complete_m1 == 1'b1)
                    nextState <= eM2;
                else
                    nextState <= dM1;
            end
				
			eM2: begin
                if(complete_m2 == 1'b1)
                    if (resetting == 1'b1) begin
                        nextState <= load_player;
							end
                    else
                        nextState <= dM2;
                else
                    nextState <= eM2;
            end

            dM2: begin
                if(complete_m2 == 1'b1)
                    nextState <= detectHits;
                else
                    nextState <= dM2;
            end
				
            detectHits: begin
                if((m1_x + 16 >= player_x && m1_x + 16 <= player_x + 16 || m1_x >= player_x && m1_x <= player_x + 16)
                        && (m1_y >= player_y && m1_y <= player_y + 16 || m1_y + 4 >= player_y && m1_y +4 <= player_y + 16))
                        nextState <= load_dead;
                else if((m2_x + 16 >= player_x && m2_x + 16 <= player_x + 16 || m2_x >= player_x && m2_x <= player_x + 16)
                        && (m2_y >= player_y && m2_y <= player_y + 16 || m2_y + 4 >= player_y && m2_y +4 <= player_y + 16))
                        nextState <= load_dead;
                else
                    nextState <= idle;
            end
            
            load_dead: begin nextState <= dead; end

            dead: begin nextState <= dead; end

            load_player: begin nextState <= load_m1; end

            load_m1: begin nextState <= load_m2; end

            load_m2: begin nextState <= start; end
				
            idle: begin
                if(continueDraw == 1'b1 && update == 1'b1)
                    nextState <= ePlayer;
                else
                    nextState <= idle;
            end

            default: nextState <= load_player;
		endcase
    end

    always@(*)
    begin: state_signals
      case(curState)
        start: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b1;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b0;
            shift_h <= 1'b1;
            shift_v <= 1'b0;
        end

        eStart: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b1;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b1;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
        end

        ePlayer: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b1;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b1;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
        end

		dPlayer: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b1;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b0;
            shift_h <= 1'b0;
            shift_v <= 1'b1;
        end

		eM1: begin
            draw_m1 <= 1'b1;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b1;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
        end

        dM1: begin
            draw_m1 <= 1'b1;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b0;
            shift_h <= 1'b1;
            shift_v <= 1'b0;
        end
		  
		eM2: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b1;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b1;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
        end

        dM2: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b1;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b0;
            shift_h <= 1'b1;
            shift_v <= 1'b0;
        end

        load_dead: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b1;
            draw_start <= 1'b0;
            load <= 1'b1;
            writeEn <= 1'b0;
            clear <= 1'b0;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
			end

        dead: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b1;
				draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b1;
            clear <= 1'b0;
            shift_h <= 1'b1;
            shift_v <= 1'b0;
			end
        load_player: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b1;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b1;
            writeEn <= 1'b0;
            clear <= 1'b0;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
			end
        load_m1: begin
            draw_m1 <= 1'b1;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b1;
            writeEn <= 1'b0;
            clear <= 1'b0;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
			end
        load_m2: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b1;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b1;
            writeEn <= 1'b0;
            clear <= 1'b0;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
			end
        idle: begin
            draw_m1 <= 1'b0;
            draw_m2 <= 1'b0;
            draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
            writeEn <= 1'b0;
            clear <= 1'b0;
            shift_h <= 1'b0;
            shift_v <= 1'b0;
		end

		default: begin
			draw_m1 <= 1'b0;
			draw_m2 <= 1'b0;
			draw_player <= 1'b0;
            draw_d_player <= 1'b0;
            draw_start <= 1'b0;
            load <= 1'b0;
			writeEn <= 1'b0;
			clear <= 1'b0;
			shift_h <= 1'b0;
			shift_v <= 1'b0;
		end
      endcase
    end

    always@(posedge clock)
        begin: state_FFs
            if(reset == 1'b0)
				begin
                resetting = 1'b1;
                curState = ePlayer;
				end
            else
                curState = nextState;

                if (curState == load_dead) begin
                    load_x = player_x;
                    load_y = player_y;
                end
                else if (curState == load_player) begin
                    load_x = 8'd72;
                    load_y = 7'd52;
                end
                else if (curState == load_m1) begin
                    load_x = 8'b0;
                    load_y = 7'd20;
                end
                else if (curState == load_m2) begin
                    load_x = 8'd180;
                    load_y = 7'd100;
                end
                else begin
                    load_x = 1'b0;
                    load_y = 1'b0;
                end


                if (curState == dM1)
                    shift_amount = 1'b1;
                else if (curState == dM2)
                    shift_amount = 1'b1;
                else if (curState == dPlayer) begin
                    if (blow == 1'b1)
                        shift_amount = -1'b1;
                    else
                        shift_amount = 1'b1;
                end
                else
                    shift_amount = 1'b0;
						  
					if (curState == start)
						resetting <= 1'b0;

        end
 endmodule