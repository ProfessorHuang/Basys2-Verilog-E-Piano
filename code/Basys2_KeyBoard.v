/*这个模块是本项目中的难点所在，需要了解PS2接口通信的相关知识，需要了解PS2接口的数据帧格式以及PS2键盘的按键扫描码。
PS2数据帧格式为
1个起始位（总为0）+8个数据位（低位在前）+1个校验位（奇校验）+1个停止位（总为1）
PS2键盘发送数据时，在时钟信号为高电平时读取数据，通过移位寄存器进行存储，直到读到停止位即完成一次数据的读取。
具体代码实现如下*/

module Basys2_Keyboard(
     input wire clk,
	 input wire PS2C,
	 input wire PS2D,
	 output reg [7:0] key_code
    );
	 reg [8:0] cntdiv;
	 wire ck1;
	 reg [9:0] s_buf;
	 reg PS2C_old;
	 
	 always@(posedge clk)
	    begin
		    cntdiv<=cntdiv+1;
		 end
	 
	 assign ck1=cntdiv[8];
	 
	 always@(posedge ck1)  
	 begin
	   PS2C_old<=PS2C;
		if((PS2C_old==1'b0)&&(PS2C==1'b1))
		  begin
		    if(s_buf[0]==1'b0)
			   begin
				  if(PS2D==1'b1)
				  begin
				    key_code<=s_buf[8:1];
					 s_buf<=10'b1111111111;
				  end
              else
              begin
                s_buf<=10'b1111111111;
              end
              end
          else
			   begin
				  s_buf<={PS2D,s_buf[9:1]};
				end
        end
    end

endmodule
