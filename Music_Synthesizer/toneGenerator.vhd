library IEEE;
use IEEE.std_logic_1164.all;



entity toneGenerator is
port (toneOut : out std_logic;												--this pin will give your notes output
clk : in std_logic;
LED : out std_logic_vector(7 downto 0);
switch : in std_logic_vector(7 downto 0));
end entity toneGenerator;

architecture m of toneGenerator is											--We are using one hot encoding and this same state would
constant state_sa1 : std_logic_vector(7 downto 0):=(0=>'1', others=>'0');	--be used to ON the switches
constant state_re1 : std_logic_vector(7 downto 0):=(1=>'1', others=>'0');
constant state_ga1 : std_logic_vector(7 downto 0):=(2=>'1', others=>'0');
constant state_ma1 : std_logic_vector(7 downto 0):=(3=>'1', others=>'0');
constant state_pa1 : std_logic_vector(7 downto 0):=(4=>'1', others=>'0');
constant state_dh1 : std_logic_vector(7 downto 0):=(5=>'1', others=>'0');
constant state_ni1 : std_logic_vector(7 downto 0):=(6=>'1', others=>'0');
constant state_sa2 : std_logic_vector(7 downto 0):=(7=>'1', others=>'0');	


begin
process(clk,switch)
variable csa1,cre1,cga1,cma1,cpa1,cdh1,cni1,csa2	: integer :=1;			-- measure number of cycles CLK for each note
variable sa1,re1,ga1,ma1,pa1,dh1,ni1,sa2	: std_logic:='1';				-- CLK for the speaker

begin
	if(rising_edge(clk)) then												--Synchrnous machine
	
	case switch is
		when state_sa1=>													--The state would change based on which switches are ON
																			--Frequency = 50E6/(2*f_required)
			if (csa1 = 104168) then--240Hz									--If count is 104168 (25E6 cycles)
			csa1 := 1;
			sa1 := not sa1;													--CLK
			else
			csa1 := csa1 + 1;
			end if;
			toneOut <= sa1;
			LED <= (0 => '1', others => '0');								--Switching on the LED
			
		when state_re1=>													
			if (cre1 = 92593) then--270Hz
			cre1 := 1;
			re1 := not re1;
			else
			cre1 := cre1 + 1;
			end if;
			toneOut <= re1;
			LED <= (1 => '1', others => '0');
			
		when state_ga1=>
			if (cga1 = 83333) then--300Hz
			cga1 := 1;
			ga1 := not ga1;
			else
			cga1 := cga1 + 1;
			end if;
			toneOut <= ga1;
			LED <= (2 => '1', others => '0');			
		
		when state_ma1=>
			if (cma1 = 78125) then--320Hz
			cma1 := 1;
			ma1 := not ma1;
			else
			cma1 := cma1 + 1;
			end if;
			toneOut <= ma1;
			LED <= (3 => '1', others => '0');
		
		when state_pa1=>
			if (cpa1 = 69444) then--360Hz
			cpa1 := 1;
			pa1 := not pa1;
			else
			cpa1 := cpa1 + 1;
			end if;
			toneOut <= pa1;
			LED <= (4 => '1', others => '0');
		
		when state_dh1=>
			if (cdh1 = 62500) then--400Hz
			cdh1 := 1;
			dh1 := not dh1;
			else
			cdh1 := cdh1 + 1;
			end if;
			toneOut <= dh1;
			LED <= (5 => '1', others => '0');		
	
		when state_ni1=>
			if (cni1 = 55555) then--450Hz
			cni1 := 1;
			ni1 := not ni1;
			else
			cni1 := cni1 + 1;
			end if;
			toneOut <= ni1;
			LED <= (6 => '1', others => '0');
	
		when state_sa2=>
			if (csa2 = 52083) then--480Hz
			csa2 := 1;
			sa2 := not sa2;
			else
			csa2 := csa2 + 1;
			end if;
			toneOut <= sa2;
			LED <= (7 => '1', others => '0');
				
	
		when others=>
			LED<=(others=>'0');
			
			
		
	end case;
	end if;
end process;
end m;