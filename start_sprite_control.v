module start_sprite_control(
	input clk,
	input draw,
    input clear,
    input shift_h,
    input shift_v,
    input load,
    input [6:0] shift_amount,
    input [7:0] load_x,
    input [6:0] load_y,
    output reg complete,
    output reg [7:0] x_out,
    output reg [6:0] y_out,
    output reg [11:0] colour_out,
	 output reg [7:0] posx,
	 output reg [6:0] posy
    );

    reg [7:0] x_pos;
    reg [6:0] y_pos;
    reg [11:0] sprite [0:15]; 
    reg [3:0] pointer;

    initial begin
        x_pos = 8'd72;
        y_pos = 7'd52;
        pointer = 1'b0;

        sprite[0] = 12'b111111111111;
        sprite[1] = 12'b111111111111;
        sprite[2] = 12'b111111111111;
        sprite[3] = 12'b111111111111;
        sprite[4] = 12'b111111111111;
        sprite[5] = 12'b111111111111;
        sprite[6] = 12'b111111111111;
        sprite[7] = 12'b111111111111;
        sprite[8] = 12'b111111111111;
        sprite[9] = 12'b111111111111;
        sprite[10] = 12'b111111111111;
        sprite[11] = 12'b111111111111;
        sprite[12] = 12'b111111111111;
        sprite[13] = 12'b111111111111;
        sprite[14] = 12'b111111111111;
		  sprite[15] = 12'b111111111111;
    end

    always@(negedge clk) begin
		  if (draw) begin
			  if (clear) 
					begin
						 x_out = x_pos + pointer[1:0];
						 y_out = y_pos + pointer[3:2];
						 colour_out = 1'b0;
						 pointer = pointer + 1'b1;
					end
			  else if (shift_h)
					begin
						 x_out = x_pos + shift_amount + pointer[1:0];
						 y_out = y_pos + pointer[3:2];
						 colour_out = sprite[pointer];
						 pointer = pointer + 1'b1;
						 if (pointer == 1'b0)
							  x_pos = x_pos + shift_amount;
					end
			  else if (shift_v)
					begin
						 x_out = x_pos + pointer[1:0];
						 y_out = y_pos + shift_amount + pointer[3:2];
						 colour_out = sprite[pointer];
						 pointer = pointer + 1'b1;
						 if (pointer == 1'b0)
							  y_pos = y_pos + shift_amount;
					end
            else if (load)
                begin
                    x_pos = load_x;
                    y_pos = load_y;
                end
		end
    end

    always @(*)begin
		if(pointer == 1'b0)
		begin
			complete = 1'b1;
			posy <= y_pos;
			posx <= x_pos;
		end
		else
			complete = 1'b0;
	end
endmodule