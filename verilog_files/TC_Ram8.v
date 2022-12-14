module TC_Ram8 (clk, rst, load, save, address, in, out);
    parameter UUID = 0;
    parameter NAME = "";
    input clk;
    input rst;
    input load;
    input save;
    input [7:0] address;
    input [7:0] in;
    output reg [7:0] out;
    reg [7:0] mem [0:255];
    integer i;
    
    initial begin
        for (i=0; i<256; i=i+1) mem[i] = 8'b0000_0000;
        out = 8'b0000_0000;
    end
    
    always @ (address or rst or load) begin
        if (load && !rst)
            out <= mem[address];
        else
            out <= 8'b0000_0000;
    end
    always @ (negedge clk) begin
        if (rst)
            for (i=0; i<256; i=i+1) mem[i] <= 8'b0000_0000;
        else if (save)
            mem[address] <= in;
    end
endmodule
