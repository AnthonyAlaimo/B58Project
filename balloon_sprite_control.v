module balloon_sprite_control(
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
    reg [11:0] sprite [0:255]; 
    reg [7:0] pointer;

    initial begin
        x_pos = 8'd72;
        y_pos = 7'd52;
        pointer = 1'b0;

        sprite[0] = 12'b000000000000;
        sprite[1] = 12'b000000000000;
        sprite[2] = 12'b000000000000;
        sprite[3] = 12'b000000000000;
        sprite[4] = 12'b100011011000;
        sprite[5] = 12'b100011011000;
        sprite[6] = 12'b100011011000;
        sprite[7] = 12'b100011011000;
        sprite[8] = 12'b100011011000;
        sprite[9] = 12'b100011011000;
        sprite[10] = 12'b100011011000;
        sprite[11] = 12'b100011011000;
        sprite[12] = 12'b000000000000;
        sprite[13] = 12'b000000000000;
        sprite[14] = 12'b000000000000;
        sprite[15] = 12'b000000000000;
        sprite[16] = 12'b000000000000;
        sprite[17] = 12'b000000000000;
        sprite[18] = 12'b100011011000;
        sprite[19] = 12'b100011011000;
        sprite[20] = 12'b000011100000;
        sprite[21] = 12'b000011100000;
        sprite[22] = 12'b000011100000;
        sprite[23] = 12'b000011100000;
        sprite[24] = 12'b000011100000;
        sprite[25] = 12'b000011100000;
        sprite[26] = 12'b000011100000;
        sprite[27] = 12'b000011100000;
        sprite[28] = 12'b100011011000;
        sprite[29] = 12'b100011011000;
        sprite[30] = 12'b000000000000;
        sprite[31] = 12'b000000000000;
        sprite[32] = 12'b000000000000;
        sprite[33] = 12'b100011011000;
        sprite[34] = 12'b000011100000;
        sprite[35] = 12'b000011100000;
        sprite[36] = 12'b000011100000;
        sprite[37] = 12'b000011100000;
        sprite[38] = 12'b000011100000;
        sprite[39] = 12'b000011100000;
        sprite[40] = 12'b000011100000;
        sprite[41] = 12'b000011100000;
        sprite[42] = 12'b000011100000;
        sprite[43] = 12'b000011100000;
        sprite[44] = 12'b000011100000;
        sprite[45] = 12'b000011100000;
        sprite[46] = 12'b100011011000;
        sprite[47] = 12'b000000000000;
        sprite[48] = 12'b000000000000;
        sprite[49] = 12'b100011011000;
        sprite[50] = 12'b000011100000;
        sprite[51] = 12'b000011100000;
        sprite[52] = 12'b111111111111;
        sprite[53] = 12'b111111111111;
        sprite[54] = 12'b111111111111;
        sprite[55] = 12'b000011100000;
        sprite[56] = 12'b000011100000;
        sprite[57] = 12'b111111111111;
        sprite[58] = 12'b111111111111;
        sprite[59] = 12'b111111111111;
        sprite[60] = 12'b000011100000;
        sprite[61] = 12'b000011100000;
        sprite[62] = 12'b100011011000;
        sprite[63] = 12'b000000000000;
        sprite[64] = 12'b100011011000;
        sprite[65] = 12'b000011100000;
        sprite[66] = 12'b000011100000;
        sprite[67] = 12'b000011100000;
        sprite[68] = 12'b111111111111;
        sprite[69] = 12'b111111111111;
        sprite[70] = 12'b111111111111;
        sprite[71] = 12'b000011100000;
        sprite[72] = 12'b000011100000;
        sprite[73] = 12'b111111111111;
        sprite[74] = 12'b111111111111;
        sprite[75] = 12'b111111111111;
        sprite[76] = 12'b000011100000;
        sprite[77] = 12'b000011100000;
        sprite[78] = 12'b000011100000;
        sprite[79] = 12'b100011011000;
        sprite[80] = 12'b100011011000;
        sprite[81] = 12'b000011100000;
        sprite[82] = 12'b000011100000;
        sprite[83] = 12'b000011100000;
        sprite[84] = 12'b111111111111;
        sprite[85] = 12'b000000000000;
        sprite[86] = 12'b111111111111;
        sprite[87] = 12'b000011100000;
        sprite[88] = 12'b000011100000;
        sprite[89] = 12'b111111111111;
        sprite[90] = 12'b000000000000;
        sprite[91] = 12'b111111111111;
        sprite[92] = 12'b000011100000;
        sprite[93] = 12'b000011100000;
        sprite[94] = 12'b000011100000;
        sprite[95] = 12'b100011011000;
        sprite[96] = 12'b100011011000;
        sprite[97] = 12'b000011100000;
        sprite[98] = 12'b000011100000;
        sprite[99] = 12'b000011100000;
        sprite[100] = 12'b111111111111;
        sprite[101] = 12'b000000000000;
        sprite[102] = 12'b111111111111;
        sprite[103] = 12'b000011100000;
        sprite[104] = 12'b000011100000;
        sprite[105] = 12'b111111111111;
        sprite[106] = 12'b000000000000;
        sprite[107] = 12'b111111111111;
        sprite[108] = 12'b000011100000;
        sprite[109] = 12'b000011100000;
        sprite[110] = 12'b000011100000;
        sprite[111] = 12'b100011011000;
        sprite[112] = 12'b100011011000;
        sprite[113] = 12'b000011100000;
        sprite[114] = 12'b000011100000;
        sprite[115] = 12'b000011100000;
        sprite[116] = 12'b000011100000;
        sprite[117] = 12'b000011100000;
        sprite[118] = 12'b000011100000;
        sprite[119] = 12'b000011100000;
        sprite[120] = 12'b000011100000;
        sprite[121] = 12'b000011100000;
        sprite[122] = 12'b000011100000;
        sprite[123] = 12'b000011100000;
        sprite[124] = 12'b000011100000;
        sprite[125] = 12'b000011100000;
        sprite[126] = 12'b000011100000;
        sprite[127] = 12'b100011011000;
        sprite[128] = 12'b100011011000;
        sprite[129] = 12'b000011100000;
        sprite[130] = 12'b000011100000;
        sprite[131] = 12'b000011100000;
        sprite[132] = 12'b000011100000;
        sprite[133] = 12'b000011100000;
        sprite[134] = 12'b100000000000;
        sprite[135] = 12'b100000000000;
        sprite[136] = 12'b100000000000;
        sprite[137] = 12'b100000000000;
        sprite[138] = 12'b000011100000;
        sprite[139] = 12'b000011100000;
        sprite[140] = 12'b000011100000;
        sprite[141] = 12'b000011100000;
        sprite[142] = 12'b000011100000;
        sprite[143] = 12'b100011011000;
        sprite[144] = 12'b100011011000;
        sprite[145] = 12'b000011100000;
        sprite[146] = 12'b000011100000;
        sprite[147] = 12'b000011100000;
        sprite[148] = 12'b000011100000;
        sprite[149] = 12'b100000000000;
        sprite[150] = 12'b100000000000;
        sprite[151] = 12'b100000000000;
        sprite[152] = 12'b100000000000;
        sprite[153] = 12'b100000000000;
        sprite[154] = 12'b100000000000;
        sprite[155] = 12'b000011100000;
        sprite[156] = 12'b000011100000;
        sprite[157] = 12'b000011100000;
        sprite[158] = 12'b000011100000;
        sprite[159] = 12'b100011011000;
        sprite[160] = 12'b000000000000;
        sprite[161] = 12'b100011011000;
        sprite[162] = 12'b000011100000;
        sprite[163] = 12'b000011100000;
        sprite[164] = 12'b000011100000;
        sprite[165] = 12'b100000000000;
        sprite[166] = 12'b100000000000;
        sprite[167] = 12'b111100000000;
        sprite[168] = 12'b111100000000;
        sprite[169] = 12'b100000000000;
        sprite[170] = 12'b100000000000;
        sprite[171] = 12'b000011100000;
        sprite[172] = 12'b000011100000;
        sprite[173] = 12'b000011100000;
        sprite[174] = 12'b100011011000;
        sprite[175] = 12'b000000000000;
        sprite[176] = 12'b000000000000;
        sprite[177] = 12'b100011011000;
        sprite[178] = 12'b000011100000;
        sprite[179] = 12'b000011100000;
        sprite[180] = 12'b100000000000;
        sprite[181] = 12'b100000000000;
        sprite[182] = 12'b100000000000;
        sprite[183] = 12'b100000000000;
        sprite[184] = 12'b100000000000;
        sprite[185] = 12'b100000000000;
        sprite[186] = 12'b100000000000;
        sprite[187] = 12'b100000000000;
        sprite[188] = 12'b000011100000;
        sprite[189] = 12'b000011100000;
        sprite[190] = 12'b100011011000;
        sprite[191] = 12'b000000000000;
        sprite[192] = 12'b000000000000;
        sprite[193] = 12'b000000000000;
        sprite[194] = 12'b100011011000;
        sprite[195] = 12'b000011100000;
        sprite[196] = 12'b000011100000;
        sprite[197] = 12'b000011100000;
        sprite[198] = 12'b000011100000;
        sprite[199] = 12'b000011100000;
        sprite[200] = 12'b000011100000;
        sprite[201] = 12'b000011100000;
        sprite[202] = 12'b000011100000;
        sprite[203] = 12'b000011100000;
        sprite[204] = 12'b000011100000;
        sprite[205] = 12'b100011011000;
        sprite[206] = 12'b000000000000;
        sprite[207] = 12'b000000000000;
        sprite[208] = 12'b000000000000;
        sprite[209] = 12'b000000000000;
        sprite[210] = 12'b000000000000;
        sprite[211] = 12'b100011011000;
        sprite[212] = 12'b100011011000;
        sprite[213] = 12'b100011011000;
        sprite[214] = 12'b100011011000;
        sprite[215] = 12'b100011011000;
        sprite[216] = 12'b100011011000;
        sprite[217] = 12'b100011011000;
        sprite[218] = 12'b100011011000;
        sprite[219] = 12'b100011011000;
        sprite[220] = 12'b100011011000;
        sprite[221] = 12'b000000000000;
        sprite[222] = 12'b000000000000;
        sprite[223] = 12'b000000000000;
        sprite[224] = 12'b000000000000;
        sprite[225] = 12'b000000000000;
        sprite[226] = 12'b000000000000;
        sprite[227] = 12'b000000000000;
        sprite[228] = 12'b000000000000;
        sprite[229] = 12'b000001010000;
        sprite[230] = 12'b000001010000;
        sprite[231] = 12'b000001010000;
        sprite[232] = 12'b000001010000;
        sprite[233] = 12'b000001010000;
        sprite[234] = 12'b000001010000;
        sprite[235] = 12'b000000000000;
        sprite[236] = 12'b000000000000;
        sprite[237] = 12'b000000000000;
        sprite[238] = 12'b000000000000;
        sprite[239] = 12'b000000000000;
        sprite[240] = 12'b000000000000;
        sprite[241] = 12'b000000000000;
        sprite[242] = 12'b000000000000;
        sprite[243] = 12'b000000000000;
        sprite[244] = 12'b000001010000;
        sprite[245] = 12'b000001010000;
        sprite[246] = 12'b000001010000;
        sprite[247] = 12'b000001010000;
        sprite[248] = 12'b000001010000;
        sprite[249] = 12'b000001010000;
        sprite[250] = 12'b000001010000;
        sprite[251] = 12'b000001010000;
        sprite[252] = 12'b000000000000;
        sprite[253] = 12'b000000000000;
        sprite[254] = 12'b000000000000;
        sprite[255] = 12'b000000000000;
    end

    always@(negedge clk) begin
		  if (draw) begin
			  if (clear) 
					begin
						 x_out = x_pos + pointer[3:0];
						 y_out = y_pos + pointer[7:4];
						 colour_out = 1'b0;
						 pointer = pointer + 1'b1;
					end
			  else if (shift_h)
					begin
						 x_out = x_pos + shift_amount + pointer[3:0];
						 y_out = y_pos + pointer[7:4];
						 colour_out = sprite[pointer];
						 pointer = pointer + 1'b1;
						 if (pointer == 1'b0)
							  x_pos = x_pos + shift_amount;
					end
			  else if (shift_v)
					begin
						 x_out = x_pos + pointer[3:0];
						 y_out = y_pos + shift_amount + pointer[7:4];
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