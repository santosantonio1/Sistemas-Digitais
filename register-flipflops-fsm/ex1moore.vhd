library IEEE;
use IEEE.std_logic_1164.all;

entity moore is
    port(
        clock,reset,x: in std_logic_1164;
        y: out std_logic_1164
    );
end moore;

architecture a1 of moore is
    type state is (S0,S1,S2,S3);
    signal EA,PE: state;
begin
    process(clock,reset)
    begin
        if reset = '1' then
            EA <= S0;
        elsif 
            EA <= PE;
        endif;
    end process;
    process(EA,w)
    begin
        case EA is
            when S0 =>  if x='0' then PE <= S0;
                        else PE <= S2;
                        end if;
            when S1 =>  if x='0' then PE <= S0;
                        else PE <= S2;
                        end if;
            when S2 =>  if x='0' then PE <= S2;
                        else PE <= S3;
                        end if;
            when S3 =>  if x='0' then PE <= S3;
                        else PE <= S1;
                        end if;
            when others => PE <= S0;
        end case;
    end process;
    y <= '0' when EA=S0 or EA=S3 else '1';
    end a1;
                    