module t_Serial_Twos_Comp ();
wire y;
reg [7: 0] data;
reg load, shift_control, Clock, reset_b;
 Serial_Twos_Comp M0 (y, data, load, shift_control, Clock, reset_b);
reg [7: 0] twos_comp;
initial begin $dumpfile("tb_proj.vcd"); $dumpvars(0,t_Serial_Twos_Comp); end
always @ (posedge Clock, negedge reset_b)
if (reset_b == 0) twos_comp <= 0;
else if (data[7] == 0) shift_control = 0;
else if (shift_control && !load) twos_comp <= {y, twos_comp[7: 1]};
 initial #200 $finish;
 initial begin Clock = 0; forever #5 Clock = ~Clock; end
 initial begin #2 reset_b = 0; #4 reset_b = 1; end
initial fork
 data = 8'b00001010;
 #20 load = 1;
 #30 load = 0;
 #50 shift_control = 1;
 #50 begin repeat (9) @ (posedge Clock) ;
 shift_control = 0;
end
join
endmodule