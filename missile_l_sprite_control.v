module missile_l_sprite_control(
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
    reg [11:0] sprite [0:63]; 
    reg [5:0] pointer;

    initial begin
        x_pos = 8'd180;
        y_pos = 7'd100;
        pointer = 1'b0;

			sprite[0] = 12'b000000000000;
			sprite[1] = 12'b110100110100;
			sprite[2] = 12'b110100110100;
			sprite[3] = 12'b111011011110;
			sprite[4] = 12'b111011011110;
			sprite[5] = 12'b111011011110;
			sprite[6] = 12'b111011011110;
			sprite[7] = 12'b111011011110;
			sprite[8] = 12'b111011011110;
			sprite[9] = 12'b111011011110;
			sprite[10] = 12'b111011011110;
			sprite[11] = 12'b111011011110;
			sprite[12] = 12'b111011001000;
			sprite[13] = 12'b111010000001;
			sprite[14] = 12'b111001100000;
			sprite[15] = 12'b111001100000;
			sprite[16] = 12'b110100110100;
			sprite[17] = 12'b110100110100;
			sprite[18] = 12'b110100110100;
			sprite[19] = 12'b111011000010;
			sprite[20] = 12'b111011000010;
			sprite[21] = 12'b111011000010;
			sprite[22] = 12'b111011000010;
			sprite[23] = 12'b111011011110;
			sprite[24] = 12'b111011011110;
			sprite[25] = 12'b111011011110;
			sprite[26] = 12'b111011011110;
			sprite[27] = 12'b111011011110;
			sprite[28] = 12'b111011001000;
			sprite[29] = 12'b111010000001;
			sprite[30] = 12'b111001100000;
			sprite[31] = 12'b000000000000;
			sprite[32] = 12'b111100000000;
			sprite[33] = 12'b111100000000;
			sprite[34] = 12'b111100000000;
			sprite[35] = 12'b101010001010;
			sprite[36] = 12'b101010001010;
			sprite[37] = 12'b101010001010;
			sprite[38] = 12'b110110110000;
			sprite[39] = 12'b101010001010;
			sprite[40] = 12'b101010001010;
			sprite[41] = 12'b101010001010;
			sprite[42] = 12'b101010001010;
			sprite[43] = 12'b101010001010;
			sprite[44] = 12'b101110100111;
			sprite[45] = 12'b101110000000;
			sprite[46] = 12'b101101000000;
			sprite[47] = 12'b000000000000;
			sprite[48] = 12'b000000000000;
			sprite[49] = 12'b111100000000;
			sprite[50] = 12'b111100000000;
			sprite[51] = 12'b101010001010;
			sprite[52] = 12'b101010001010;
			sprite[53] = 12'b101010001010;
			sprite[54] = 12'b101010001010;
			sprite[55] = 12'b101010001010;
			sprite[56] = 12'b101010001010;
			sprite[57] = 12'b101010001010;
			sprite[58] = 12'b101010001010;
			sprite[59] = 12'b101010001010;
			sprite[60] = 12'b101110100111;
			sprite[61] = 12'b101110000000;
			sprite[62] = 12'b101101000000;
			sprite[63] = 12'b101101000000;
    end

    always@(negedge clk) begin
		  if (draw) begin
			  if (clear) 
					begin
						 x_out = x_pos + pointer[3:0];
						 y_out = y_pos + pointer[5:4];
						 colour_out = 1'b0;
						 pointer = pointer + 1'b1;
					end
			  else if (shift_h)
					begin
						 x_out = x_pos - shift_amount + pointer[3:0];
						 y_out = y_pos + pointer[5:4];
						 colour_out = sprite[pointer];
						 pointer = pointer + 1'b1;
						 if (pointer == 1'b0)
							  x_pos = x_pos - shift_amount;
					end
			  else if (shift_v)
					begin
						 x_out = x_pos + pointer[3:0];
						 y_out = y_pos + shift_amount + pointer[5:4];
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
