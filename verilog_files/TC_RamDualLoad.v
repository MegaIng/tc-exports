module TC_RamDualLoad (clk, rst, load0, save, address0, in, load1, address1, out0, out1);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 16;
    parameter WORD_COUNT = 256;
    input clk;
    input rst;
    input load0;
    input save;
    input [32:0] address0;
    input [WORD_WIDTH-1:0] in;
    input load1;
    input [32:0] address1;
    output reg [WORD_WIDTH-1:0] out0;
    output reg [WORD_WIDTH-1:0] out1;

    reg [WORD_WIDTH-1:0] mem [0:WORD_COUNT];

    integer i;

    initial begin
        for (i=0; i<WORD_COUNT; i=i+1) mem[i] = {WORD_WIDTH{1'b0}};
        out0 = {64{1'b0}};
        out1 = {64{1'b0}};
    end

    always @ (address0 or rst or load0) begin
        if (load0 && !rst)
            out0 = mem[address0];
        else
            out0 = {WORD_WIDTH{1'b0}};
    end
    always @ (address1 or rst or load1) begin
        if (load1 && !rst)
            out1 = mem[address1];
        else
            out1 = {WORD_WIDTH{1'B0}};
    end
    always @ (negedge clk) begin
        if (rst)
            for (i=0; i<WORD_COUNT; i=i+1) mem[i] = {WORD_WIDTH{1'b0}};
        else if (save)
            mem[address0] = in;
    end
endmodule
