module sinus();
reg [16:0] f1,f2,f3,f4,f5,f6,f7,f8,f9;
reg [31:0 ] resultexp;
reg clk;
reg [16:0] value;
reg [3:0] counter;
reg[16:0] lookuptable;
wire[33:0] result;
reg [3:0] top;
reg [7:0] minuscounter;
reg [16:0] multiplicand,multiplier;
  localparam sf = 2.0**-16.0; //parameter for displaying the end result 
initial begin
 //generating lookup table
  f1 = 65536;
  f2 = 32768;
  f3 = 10923;
  f4 = 2731;
  f5 = 546;
  f6 = 91;
  f7 = 13;
  f8 = 2;
  f9 = 1;
    counter = 2;
top = 3; //this is the exponential term
clk = 1;
value = 60000; //input value, you can adjust the input from here.
minuscounter = 8'hff;
multiplier =value ;
multiplicand = value;
resultexp = value;
counter = 2;
end

always begin
  
 #5 clk <= ~clk;
end
 booth  dutexp(.multiplier(multiplier), .multiplicand(multiplicand) , .clk(clk) ,.sum(result));
always @ (result)
begin
    

        if(counter < top) begin
            multiplier <= result[32:16];
            multiplicand <= value;
            counter <= counter +1;

		if(result[32:16] == 0 || top == 9)begin // this is used for limiting the calculations when the x^9 term used, or when there are nothing to multiply
		$display("Result is :%f ", $itor (resultexp)*sf);
		$display("You can end the program now");

		end




        end
        else if(counter ==top)
		begin
            multiplier <= result[32:16];
            case (counter)

              
                4'h1: multiplicand <= f1;
                4'h2: multiplicand <= f2;
                4'h3: multiplicand <= f3; 
                4'h4: multiplicand <= f4;
                4'h5: multiplicand <= f5;
                4'h6: multiplicand <= f6;
                4'h7: multiplicand <= f7;
                4'h8: multiplicand <= f8;
		4'h9: multiplicand <= f9;
              default: ;
            endcase
            counter <= counter +1 ;
            


        end
        else begin

            top <= top +2;
            minuscounter <= -minuscounter;
            multiplier <= value;
            multiplicand <= value;
            if(minuscounter == 8'h1)
            resultexp <= resultexp + result[31:16];
            else begin resultexp <= resultexp - result[31:16]; end
            counter <= 2;
	   



        end









end




endmodule