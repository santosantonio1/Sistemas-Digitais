--------------------------------------------------------------------------------
-- Temporizador decimal do cronometro de xadrez
-- Fernando Moraes - 25/out/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
library work;

entity temporizador is
    port( clock, reset, load, en : in std_logic;
          init_time : in  std_logic_vector(7 downto 0);
          cont      : out std_logic_vector(15 downto 0)
      );
end temporizador;

architecture a1 of temporizador is
    signal segL, segH, minL, minH : std_logic_vector(3 downto 0);
    signal en1, en2, en3, en4: std_logic;
begin
   
   -- PERMITE O DECREMENTO DOS MINUTOS E DOS SEGUNDOS CASO ALGUM DELES SEJA DIFERENTE DE 0
   -- E O SINAL DE ENABLE(PERMISSAO) SEJA 1
   en1 <= '1' when en = '1' and not(segL=x"0" and segH=x"0" and minL=x"0" and minH=x"0") else '0';

   -- DECREMENTA A DEZENA DOS SEGUNDOS CASO A UNIDADE ESTEJA EM 0 
   en2 <= '1' when en1 = '1' and segL="0000" else '0';

   -- DECREMENTA A UNIDADE DOS MINUTOS CASO OS SEGUNDOS ESTJAM EM 0
   en3 <= '1' when en2 = '1' and segH="0000" else '0';

   -- DECREMENTA A DEZENA DOS MINUTOS CASO O RESTO ESTEJA EM 0
   en4 <= '1' when en3 = '1' and minL="0000" else '0';

   -- CADA PARTE DO CONTADOR(UNIDADES E DEZENAS) TEM O SEU PRÓPRIO DECOUNTER
   sL : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en1,
        first_value => "0000",
        limit => "1001",
        cont => segL
    );
   sH : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en2,
        first_value => "0000",
        limit => "0101",
        cont => segH
   );
   mL : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en3,
        first_value => init_time(3 downto 0),
        limit => "1001",
        cont => minL
   );
   mH : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en4,
        first_value => init_time(7 downto 4),
        limit => "0101",
        cont => minH
   );
   
   -- UNE AS DEZENAS E UNIDADES EM UM OUTPUT DE 16 CASAS
   cont <= minH & minL & segH & segL;
end a1;


