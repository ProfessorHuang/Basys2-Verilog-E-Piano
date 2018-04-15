//顶层模块，用于调用各子函数
module E_Piano(
     input wire clk,        //Basys2时钟，50MHz
	 input wire PS2C,       //PS2接口的时钟
	 input wire PS2D,       //PS2接口的数据
	 input wire [1:0]select,
	 output wire [7:0] led,    //Basys2上的8个LED灯，用于跑马灯效果
	 output wire [6:0] seg,  //七段数码管的显示    
	 output wire [3:0] an,   //七段数码管的使能端
	 output speaker         //Pmod—AMP模块的蜂鸣器
    );
	 wire [7:0]key_code;
	 
    Basys2_Keyboard U1(
	 .clk(clk),
	 .PS2C(PS2C),
	 .PS2D(PS2D),
	 .key_code(key_code)
	 );
	 
	 make_melody U2(
	 .clk(clk),
	 .switch(key_code),
	 .speaker(speaker)
	 );
	 
	 Run_Horse U3(
	 .clk(clk),
	 .key_code(key_code),
	 .current_state(led)
	 );
	 
	 Music_Score U4(
	 .clk(clk),
	 .switch(select),
	 .key_code(key_code),
	 .seg(seg),
	 .an(an)
	 );
	 
	 endmodule
