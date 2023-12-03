library IEEE;
use IEEE.std_logic_1164.all;

entity ms_d is
    port(
        D,clk:in std_logic;
        Q,nQ:out std_logic
    );
end ms_d;

architecture a1 of ms_d is
begin
    process(D,clk)
    begin
        if rising_edge(clk) then
            Q <= D;
        end if;
    end process;
end a1;