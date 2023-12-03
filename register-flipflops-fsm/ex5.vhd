library IEEE;
use IEEE.std_logic_1164.all;

entity ex5 is
    port(
        X,Y: in std_logic_vector(7 downto 0);
        SA,SB,EnableA,EnableB,clock,reset: in std_logic;
        Rb: out std_logic_vector(7 downto 0)
    );
end ex5;

architecture a1 of ex5 is
    signal Q,xmux,ymux: std_logic_vector(7 downto 0);
begin
    process(clock,reset,EnableA)
    begin
        if reset = '1' then
            Q <= (others => '0');
            Rb <= (others => '0');
        elsif rising_edge(clock) then
            if SA = '0' then
                xmux <= Q;
            else
                xmux <= X;
            end if;
                Q <= xmux;
        end if;
    end process;
    process(clock,reset,EnableB)
    begin
        if reset = '1' then    
            Q <= (others => '0');
            Rb <= (others => '0');
        elsif rising_edge(clock) then
            if SB = '0' then
                ymux <= Q;
            else
                ymux <= Y;
            end if;
                Q <= ymux;
        end if;
                Rb <= Q;
    end process;
end a1;
