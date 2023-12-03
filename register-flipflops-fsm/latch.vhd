library IEEE;
use IEEE.std_logic_1164.all;

entity s_r_latch is
    port(
        S,R: in std_logic;
        Q,nQ: out std_logic
        );    
end s_r_latch;

architecture a1 of s_r_latch is
    signal q, nq: std_logic;
begin
    q <= R nor nq;
    nq <= S nor q;
    nQ <= nq;
    Q <= q;
    
end a1;