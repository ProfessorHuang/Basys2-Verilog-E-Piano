/*本模块用于实现跑马灯的效果以及让跑马灯随按键的变化而改变，增加趣味性。设置两种模式，一种是从左往右跑，一种是从右往左跑，用一个8位寄存器存储8盏灯的状态，
用有限状态机的思想，设定每隔一定时间，灯的状态由现态转到次态，根据模式的不同，当前现态转到的次态便不同，同时设定每当按键发生改变时，
模式发生一次变化即可实现。*/
//可加可不加
module Run_Horse(
    input clk,
	 input [7:0] key_code,
	 output reg [7:0]current_state
    );
	 reg [7:0]next_state;
	 
	 
	 reg [24:0]count;
	 reg clkdiv;
	 reg mode;
	 reg [7:0]key_code_old;
	 

	 initial  begin
	    current_state=8'b10000000;
		 count<=0;
		 mode<=1;
	 end
	 
	 always@(posedge clk)
	    if(key_code_old!=key_code)
	       begin
			    key_code_old<=key_code;
             mode<=~mode;
			  end
		    
			  
	 //先进行分频功能
	 always@(posedge clk)
	    begin
	       if(count==2000000)
	          begin 
				    clkdiv=~clkdiv; 
					 count=0; 
				 end
	       else 
			    begin
	             count=count+1;	 
				 end	 
       end		 
	 
	 always@(posedge clkdiv)
	 current_state<=next_state;
	 
	 always@(current_state,mode)
	    
	       begin
		       case(current_state)
			    8'b10000000:next_state<=mode==1?8'b01000000:8'b00000001;
			    8'b01000000:next_state<=mode==1?8'b00100000:8'b10000000;
			    8'b00100000:next_state<=mode==1?8'b00010000:8'b01000000;
			    8'b00010000:next_state<=mode==1?8'b00001000:8'b00100000;
			    8'b00001000:next_state<=mode==1?8'b00000100:8'b00010000;
			    8'b00000100:next_state<=mode==1?8'b00000010:8'b00001000;
			    8'b00000010:next_state<=mode==1?8'b00000001:8'b00000100;
		   	    8'b00000001:next_state<=mode==1?8'b10000000:8'b00000010;
			    default:next_state<=8'b10000000;
		       endcase
          end		
         

endmodule
