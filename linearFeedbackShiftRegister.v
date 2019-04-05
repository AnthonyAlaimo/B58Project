module linearFeedbackShiftRegister(
    input clock,
    input [15:0] seed,
    input reset,
    output [2:0] randnum
    );

    reg [7:0] shift_reg;
    wire linear_feedback;

    assign linear_feedback = !(shift_reg[7] ^ shift_reg[3]);
    assign randnum = shift_reg[7:6];

    initial begin
        shift_reg[0] <= seed[8] ^ seed[0];
        shift_reg[1] <= seed[9] ^ seed[1];
        shift_reg[2] <= seed[10] ^ seed[2];
        shift_reg[3] <= seed[11] ^ seed[3];
        shift_reg[4] <= seed[12] ^ seed[4];
        shift_reg[5] <= seed[13] ^ seed[5];
        shift_reg[6] <= seed[14] ^ seed[6];
        shift_reg[7] <= seed[15] ^ seed[7];
    end

    always@(posedge clock)
    begin
        if (!reset) begin
            shift_reg[0] <= seed[8] ^ seed[0];
            shift_reg[1] <= seed[9] ^ seed[1];
            shift_reg[2] <= seed[10] ^ seed[2];
            shift_reg[3] <= seed[11] ^ seed[3];
            shift_reg[4] <= seed[12] ^ seed[4];
            shift_reg[5] <= seed[13] ^ seed[5];
            shift_reg[6] <= seed[14] ^ seed[6];
            shift_reg[7] <= seed[15] ^ seed[7];
        end
        else
            shift_reg <= {shift_reg[6:0], linear_feedback};
    end
endmodule