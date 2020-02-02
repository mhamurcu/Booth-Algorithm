//inputs and outputs are both 17 bit  here, however its only allowed to enter 16 bit unsigned numbers.
//Since booth algorithm works only for signed numbers, and in this homework
//we are supposed to work with the unsigned numbers, I ve decided to make them all positive in order to use 
// booth here. 
module booth (input  [16:0] multiplier,input    [16:0]multiplicand,input clk, output reg [33:0] sum);
reg  [16:0] A,Q,M;
reg [4:0] counter;
reg  Q_1;


reg [4:0] deneme;
reg [1:0] CS;
initial begin
A = 0;
Q_1 = 1'b0;
counter = 17;
deneme = 26;
CS = 0;
end
always @(multiplier,multiplicand) begin
M = multiplicand;
Q = multiplier;


end

always @(clk) begin
if (counter !=0 ) begin
if ( CS != 1)
	begin
   case ({Q[0],Q_1})
       2'b10 : begin
               A <= A-M;
                
                CS <= 1;
                end
       2'b01 : begin
        A <= A+M;        
        CS <= 1;
        end
       
    default:;
    endcase
	end

        
end
  else begin

  
    sum = {A,Q};
	counter <= 17;
	#5 A<=0 ;
end
end

    
        
always @ (negedge clk) begin
 {A,Q,Q_1} = $signed({A,Q,Q_1})>>> 1;

  
       counter <= counter - 1;
	CS <= 0;
   end 
  
    





endmodule

