/*该模块实现曲谱的功能，首先根据开关判断需要显示哪一首歌的曲谱，然后设定一个计数器，根据歌曲的不同，当计数到多长时间时，即让
七段码后两位显示需要显示的音阶符号即可，需要之前将歌曲的音阶一一存入。同时还根据按下的按键，在七段码高两位显示按下的音阶，方便对比。*/
//暴力显示
module Music_Score(
    input clk,
	 input [1:0] switch,
	 input [7:0]key_code,
	 output reg [6:0] seg,      
	 output reg [3:0] an
    );
    //设定每个音符之间基准的时间间隔为0.1s
	 reg [4:0] digit;
	 reg [15:0] cntDiv;
	 reg [30:0] count1;
	 reg [10:0] count2;
	 wire [1:0]clkDisp;
	 reg clk_10Hz;
	 reg [15:0] display;
	 
	 always@(posedge clk)
	    cntDiv<=cntDiv+1;
		 
	 assign clkDisp[1:0]=cntDiv[15:14];//用于刷新7段数码管	 
    
	 always@(posedge clk)    //产生10Hz的频率
	    begin
		    if(count1>=2500000)
			    begin
				    clk_10Hz<=~clk_10Hz;
				    count1<=0;
             end					 
			 else
             count1<=count1+1;
       end		 
    
	 always@(posedge clk_10Hz)
	    begin
		    count2<=count2+1;
		    if(switch==2'b01)   //小星星
			    case(count2)
				 20:display[7:0]<=8'h11;
				 29:display[7:0]<=8'h0; //用于闪烁一下
				 30:display[7:0]<=8'h11;
				 40:display[7:0]<=8'h15;
				 49:display[7:0]<=8'h0; //用于闪烁一下
				 50:display[7:0]<=8'h15;
				 60:display[7:0]<=8'h16;
				 69:display[7:0]<=8'h0; //用于闪烁一下
				 70:display[7:0]<=8'h16;
				 80:display[7:0]<=8'h15;
				 90:display[7:0]<=8'h14;
				 99:display[7:0]<=8'h0; //用于闪烁一下
				 100:display[7:0]<=8'h14;
				 110:display[7:0]<=8'h13;
				 119:display[7:0]<=8'h0; //用于闪烁一下
				 120:display[7:0]<=8'h13;
				 130:display[7:0]<=8'h12;
				 139:display[7:0]<=8'h0; //用于闪烁一下
				 140:display[7:0]<=8'h12;
				 150:display[7:0]<=8'h11;
				 endcase
			 else if(switch==2'b10)  //童话
			    case(count2)
             20:display[7:0]<=8'h22;  //你
				 29:display[7:0]<=8'h00;  
				 30:display[7:0]<=8'h22;  //哭
				 40:display[7:0]<=8'h24;  //着
				 49:display[7:0]<=8'h00;
				 50:display[7:0]<=8'h24;  //对
				 60:display[7:0]<=8'h23;  //我
				 69:display[7:0]<=8'h00;
				 70:display[7:0]<=8'h23;  //说
				 89:display[7:0]<=8'h00;
				 90:display[7:0]<=8'h23;  //童
				 99:display[7:0]<=8'h00;
				 100:display[7:0]<=8'h23; //话
				 110:display[7:0]<=8'h17; //里
				 120:display[7:0]<=8'h22; //都
				 130:display[7:0]<=8'h21; //是
				 139:display[7:0]<=8'h00;
				 140:display[7:0]<=8'h21; //骗
				 150:display[7:0]<=8'h17; //人
             160:display[7:0]<=8'h21; //的
				 179:display[7:0]<=8'h00;
				 180:display[7:0]<=8'h21; //我
				 190:display[7:0]<=8'h17; //不
				 200:display[7:0]<=8'h21; //可
				 210:display[7:0]<=8'h24; //能
				 230:display[7:0]<=8'h16; //是
				 240:display[7:0]<=8'h25; //你
				 250:display[7:0]<=8'h24; //的
				 260:display[7:0]<=8'h23; //王
				 270:display[7:0]<=8'h22; //子
				 279:display[7:0]<=8'h00;
				 290:display[7:0]<=8'h22; //也
				 299:display[7:0]<=8'h00;
				 300:display[7:0]<=8'h22; //许
				 310:display[7:0]<=8'h24; //你
				 319:display[7:0]<=8'h00;
				 320:display[7:0]<=8'h24; //不
				 330:display[7:0]<=8'h23; //会
				 339:display[7:0]<=8'h00;
				 340:display[7:0]<=8'h23; //懂
				 359:display[7:0]<=8'h00;
				 360:display[7:0]<=8'h23; //从
				 369:display[7:0]<=8'h00;
				 370:display[7:0]<=8'h23; //你
				 380:display[7:0]<=8'h27; //说
 				 389:display[7:0]<=8'h00;
				 390:display[7:0]<=8'h27; //爱
				 400:display[7:0]<=8'h26; //我
				 410:display[7:0]<=8'h27; //以
				 420:display[7:0]<=8'h31; //后
				 439:display[7:0]<=8'h00;
				 440:display[7:0]<=8'h31; //我
				 450:display[7:0]<=8'h22; //的
				 460:display[7:0]<=8'h21; //天
				 470:display[7:0]<=8'h26; //空
             479:display[7:0]<=8'h00;				 
				 480:display[7:0]<=8'h26; //星
				 489:display[7:0]<=8'h00;	
				 490:display[7:0]<=8'h26; //星
				 499:display[7:0]<=8'h00;	
				 500:display[7:0]<=8'h26; //都
				 509:display[7:0]<=8'h00;	
				 510:display[7:0]<=8'h26; //亮
				 519:display[7:0]<=8'h00;	
				 520:display[7:0]<=8'h26;  //了
				 endcase        				 
			 else
             display[7:0]<=8'h0;
       end	

    always@(*)
       case(key_code[7:0])
		     8'b00010101:display[15:8]<=8'h11;    //Q低音do
			  8'b00011101:display[15:8]<=8'h12;   //W低音rai
			  8'b00100100:display[15:8]<=8'h13;  //E低音mi
			  8'b00101101:display[15:8]<=8'h14;   //R低音fa
           8'b00101100:display[15:8]<=8'h15;   //T低音so
           8'b00110101:display[15:8]<=8'h16;   //Y低音la
           8'b00111100:display[15:8]<=8'h17;   //U低音xi			  
           8'b00011100:display[15:8]<=8'h21;   //A中音do
           8'b00011011:display[15:8]<=8'h22;   //S中音rai
           8'b00100011:display[15:8]<=8'h23; //D中音mi
           8'b00101011:display[15:8]<=8'h24; //F中音fa
			  8'b00110100:display[15:8]<=8'h25;  //G中音so
			  8'b00110011:display[15:8]<=8'h26;  //H中音la
			  8'b00111011:display[15:8]<=8'h27;  //J中音xi
			  8'b00011010:display[15:8]<=8'h31;  //Z高音do
			  8'b00100010:display[15:8]<=8'h32;  //X高音rai
			  8'b00100001:display[15:8]<=8'h33;  //C高音mi
			  8'b00101010:display[15:8]<=8'h34;  //V高音fa 改
			  8'b00110010:display[15:8]<=8'h35; //B高音so
			  8'b00110001:display[15:8]<=8'h36;  //N高音la
			  8'b00111010:display[15:8]<=8'h37; //M高音xi
			  default:display[15:8]<=8'h00;
	   endcase		  
		 
	    
	 

    always@(*)  //用于7段码的显示
      begin
        case(clkDisp)		  
	       2'b00:begin
			          digit=display[3:0];
				       an=4'b1110;
				    end
          2'b01:begin
                    digit=display[7:4];
                    an=4'b1101;
                  end
          2'b10:begin
			          digit=display[11:8];
				       an=4'b1011;
				    end
          2'b11:begin
                    digit=display[15:12];
                    an=4'b0111;
                  end						
        endcase
      end				 
    	
    always @ (*)
		 case (digit)
		 0: seg = 7'b1000000;
		 1: seg = 7'b1111001;
		 2: seg = 7'b0100100;
		 3: seg = 7'b0110000;
		 4: seg = 7'b0011001;
		 5: seg = 7'b0010010;
		 6: seg = 7'b0000010;
		 7: seg = 7'b1111000;
		 8: seg = 7'b0000000;
		 9: seg = 7'b0010000;
		 'hA: seg=7'b0001000;
		 'hB: seg=7'b0000011;
		 'hC: seg=7'b1000110;
		 'hD: seg=7'b0100001;
		 'hE: seg=7'b0000110;
		 'hF: seg=7'b0001110;
		 default: seg = 7'b0000001;  // 0
	 endcase		
			    
	 
endmodule	
