module Serial_Twos_Comp (output y, input [7: 0] data, input load, shift_control, Clock, reset_b);
reg [7: 0] SReg;
reg Q;
wire a;
wire SO = SReg [0];
xor2 x2(SO,Q,y);
or2 o2(Q, SO, a);
always @ (posedge Clock, negedge reset_b)
if (reset_b == 0) begin
 SReg <= 0;
 Q <= 0;
end
else begin
if (load) SReg = data;
else if (shift_control) begin
 Q <= a;
 SReg <= {y, SReg[7: 1]};
end
end
endmodule
