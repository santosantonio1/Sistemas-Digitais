library IEEE;
use IEEE.std_logic_1164.all;

entity mealy is
    port(
        clock,reset,w: in std_logic_1164;
        z: out std_logic_1164
    );
end mealy;

architecture a1 of mealy is
    type state is(A,B);
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
                        z <= '0';
            when B =>   if w='0' then PE <= A;
                        else PE <= B;
                        z <= w;
            when others => PE <= A;
                           z <= '0';
            end case;
    end process;
end a1;