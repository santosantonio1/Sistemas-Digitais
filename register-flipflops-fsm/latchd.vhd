library IEEE;
use IEEE.std_logic_1164.all;

entity latch_d is 
    port(
        D, clk:in std_logic;
        Q, nQ:out std_logic
    );
end latch_d;

architecture a1 of latch_d is
begin
    process(clk,D)
    begin 
        if(c='1') then
            Q <= D;
        end if;
    end process;
end a1;