module dff (
    input clk,
    input rst,
    input D,
    output reg Q,
    output reg not_Q
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= 0;
            not_Q <= 0;
        end
        else begin
            Q <= D;
            not_Q <= ~D;
        end
    end
endmodule
