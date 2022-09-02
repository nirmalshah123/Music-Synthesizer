LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity music is
port (toneOut : out std_logic;											--This would be given to the toneGenerator IP, to generate a particular note
	clk_50, resetn : in std_logic;
	LED : out std_logic_vector(7 downto 0));
end entity music;

architecture fsm of music is
-- Fill all the states
type state_type is (Silent,sa,re,ga,ma,pa,dha,ni);

signal y_present : state_type:=Silent;
signal count	  : integer	:=0;
signal clock_music	: std_logic:='0';

constant s:std_logic_vector(7 downto 0):=(others=>'0');					-- 1-hot encoding for representing state as well as the LEDs
constant sa1 : std_logic_vector(7 downto 0):=(0=>'1', others=>'0');
constant re1 : std_logic_vector(7 downto 0):=(1=>'1', others=>'0');
constant ga1 : std_logic_vector(7 downto 0):=(2=>'1', others=>'0');
constant ma1 : std_logic_vector(7 downto 0):=(3=>'1', others=>'0');
constant pa1 : std_logic_vector(7 downto 0):=(4=>'1', others=>'0');
constant dha1 : std_logic_vector(7 downto 0):=(5=>'1', others=>'0');
constant ni1 : std_logic_vector(7 downto 0):=(6=>'1', others=>'0');

signal switch		: std_logic_vector(7 downto 0):=s;

component toneGenerator is
port (toneOut : out std_logic;										    --this pin will give your notes output
clk : in std_logic;
LED : out std_logic_vector(7 downto 0);
switch : in std_logic_vector(7 downto 0));
end component;
begin

	process(clk_50,resetn,y_present,count,clock_music)					
	variable y_next_var : state_type := Silent;
	variable n_count : integer := 0;
	variable timecounter : integer range 0 to 1E8 := 0;

	variable clk_c			: std_logic:='0';
	
	begin
	
		y_next_var := y_present;
		n_count := count;												--Count variable is used as an index, for playing a certain note  present at the index

		case y_present is
			when Silent=>
				switch<=s;
				if(count = 0) then
					y_next_var:=pa;
					n_count := count + 1;
				elsif(count = 31) then
					y_next_var:=Silent;
					n_count:=count+1;
				elsif(count = 32) then
					y_next_var:=pa;
					n_count:=1;
				
				else
					y_next_var:=pa;
					n_count:=1;
				end if;	
				
					
			WHEN sa =>												   --if the machine in Sa state
				switch<=sa1;
				
				
				if((count = 24)) then
					y_next_var:=ni;
					n_count := count + 1;
				elsif(count=29) then
					y_next_var:= sa;
					n_count := count + 1;
				elsif(count = 30) then
					y_next_var:=Silent;
					n_count := count + 1;
				else
					y_next_var:=sa;
					n_count:=count+1;
				end if;
				

			WHEN re =>
				switch<=re1;
				
				if(count = 16) then
					y_next_var:=ga;
					n_count := count + 1;
				elsif((count = 23) or (count = 28)) then
					y_next_Var:=sa;
					n_count := count + 1;
				elsif(count = 27) then
					y_next_var:=re;
					n_count := count + 1;
				end if;
				
			WHEN ga =>
				switch<=ga1;
				
				if(count = 8) then
					y_next_var:=ma;
					n_count := count + 1;
				elsif((count = 15) or (count = 22))then
					y_next_Var:=re;
					n_count := count + 1;
				elsif((count = 17) or (count = 18) or (count = 19)) then
					y_next_var:=ga;
					n_count := count + 1;	
				elsif(count = 20) then
					y_next_var:=ma;
					n_count:=count+1;
				end if;

				WHEN ma =>
				switch<=ma1;
				
				if((count = 7) or (count = 14) or (count = 21)) then
					y_next_var:=ga;
					n_count := count + 1;
				elsif((count = 9) or (count = 10) or (count = 11))then
					y_next_Var:=ma;
					n_count := count + 1;
				elsif((count = 12)) then
					y_next_var:=pa;
					n_count := count + 1;	
				end if;
				
				WHEN pa =>
				switch<=pa1;
				
				if((count = 1) or (count = 2) or (count = 3)) then
					y_next_var:=pa;
					n_count := count + 1;
				elsif((count = 4))then
					y_next_Var:=dha;
					n_count := count + 1;
				elsif((count = 6) or (count = 13)) then
					y_next_var:=ma;
					n_count := count + 1;	
				end if;

				WHEN dha =>
				switch<=dha1;
				
				if((count = 5)) then
					y_next_var:=pa;
					n_count := count + 1;	
				end if;

				WHEN ni =>
				switch<=ni1;
				
				if((count = 25)) then
					y_next_var:=ni;
					n_count := count + 1;
				elsif((count = 26))then
					y_next_Var:=re;
					n_count := count + 1;	
				end if;
				
			WHEN others =>
						y_next_var:=Silent;
						n_count:=0;
				
		END CASE ;
	
		if (clk_50 = '1' and clk_50' event) then
			if (resetn = '0') then
				if timecounter = 6250000 then					-- The cycles in which clk is 1 or 0
					timecounter := 1;							-- When it reaches max count i.e. 625x10^4 it will be 0 again 
					clk_c := not clk_c;							-- this variable will toggle
				else
					timecounter := timecounter + 1;				-- Counter will be incremented till it reaches max count
					
				end if;
			elsif resetn = '1' then
				timecounter := 1;
				clk_c := '0';
			end if;
		end if;
		clock_music <= clk_c;
	
	
		if(resetn = '1') then
			y_present<= Silent;
			count<=0;
			elsif(clock_music = '1' and clock_music' event) then
				y_present<=y_next_var;
				count <=n_count;
			

		end if;
	end process;
	
i0	: toneGenerator port map(toneOut=>toneOut,clk=>clk_50,LED=>LED,switch=>switch);
end fsm;