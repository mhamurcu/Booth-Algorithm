module factorial ();
parameter N = 15;
 reg [16:0] multiplier,multiplicand;
 wire [33:0] outputfor_each_stage;


integer i; //index for loops
reg clk;
reg zero;

initial begin
clk = 1;
i=2;
multiplier = 2;
multiplicand =1;
zero = 0;
end


always 
begin
 #5 clk <= ~clk;
  end

  booth  dut(.multiplier(multiplier), .multiplicand(multiplicand) , .clk(clk) ,.sum(outputfor_each_stage));
always @ (outputfor_each_stage) begin

if(i<N+1) begin
 i= i+1;
  multiplier = {zero,outputfor_each_stage[15:0]};
  multiplicand = i;
   
end



end



endmodule
