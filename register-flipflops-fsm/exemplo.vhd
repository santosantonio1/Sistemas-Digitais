library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity reg is
    generic(N : integer := 4);
    port(
        clk,load,reset: in std_logic;
        sout: out std_logic;
        d: in std_logic_vector(N-1 downto 0);
        q: out std_logic_vector(N-1 downto 0)
    );
end reg;

architecture a1 of reg is
    signal s: std_logic_vector(N-1 downto 0);
begin
    process(clk,reset)
    begin
        if reset ='1' then
            s <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1'then
                s <= d; -- carga paralela 
            else
                s <= s(n-2 downto 0) & sin; -- carga serial
            end if;
        end if;
    end process;
    q <= s; -- saída paralela
    sout <= s(n-1); -- saída serial
end a1;