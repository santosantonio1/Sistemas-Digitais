library IEEE;
use IEEE.std_logic_1164.all;

entity reg_n_bit is
    generic(N:integer := 6);
    port(
        clk,reset,ce:in std_logic_1164;
        D:in std_logic_vector(N-1 downto 0);
        Q:out std_logic_vector(N-1 downto 0)
    );
end reg_n_bit;

architecture a1 of reg_n_bit is
begin
    process(clk,reset)
    begin
        if reset = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk) then
            if ce = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end a1;