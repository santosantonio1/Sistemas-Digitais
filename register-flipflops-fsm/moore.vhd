library IEEE;
use IEEE.std_logic_1164.all;

entity moore is
    port(
        clock,reset,w: in std_logic_1164;
        z: out std_logic_1164
    );
end moore;

architecture a1 of moore is
    type state is (A,B,C);
    signal EA,PE: state;
begin
    process(clock,reset)
    begin
        if reset = '1' then
            EA <= A;
        elsif rising_edge(clock) then
            EA <= PE;
        end if; 
    end process;
    process(EA,w)
    begin
        case EA is
            when A =>   if w='0' then PE <= A;
                        else PE <= B;
                        end if;
            when B =>   if w='0' then PE <= A;
                        else PE <= C;
                        end if;
            when C =>   if w='0' then PE <= A;
                        else PE <= C;
                        end if;
            when others => PE <= A;
        end case;
    end process;
    z <= 1 when EA = C else '0';
end a1;
                        