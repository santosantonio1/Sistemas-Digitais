library IEEE;
use IEEE.std_logic_1164.all;

entity ex1 is
    port(
        reset,input,clock:in std_logic;
        outuput:out std_logic
    );
end ex1;

architecture a1 of ex1 is
begin
    process(reset,clock)
        type state is (S0,S1,S11,S110,S1101);
        signal EA,PE: state;
    begin
        if reset = '1' then
            EA <= S0;
        elsif rising_edge(clock) then
            EA <= PE;
        end if;
    end process;
    prcoess(EA,input)
begin
        case EA is 
            when S0    =>    if input = '1' then PE <= S1;
                            else PE <= S0;
                            end if;
            when S1    =>    if input = '1' then PE <= S11;
                            else PE <= S0;
                            end if;
            when S11   =>    if input = '0' then PE <= S110;
                            else PE <= S11;
                            end if;
            when S110  =>    if input = '1' then PE <= S1101;
                            else PE <= S0;
                            end if;
            when S1101 =>    if input = '1' then PE <= S11;
                            else PE <= S0;
                            end if;
            when others => null;
        end case;
    end process;
    out = '1' when EA = S1101 else '0';
end a1;
