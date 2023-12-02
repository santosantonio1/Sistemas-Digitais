--------------------------------------------------------------------------------
-- RELOGIO DE XADREZ
-- Author - Fernando Moraes - 25/out/2023
-- Revision - Iaçanã Ianiski Weber - 30/out/2023
--------------------------------------------------------------------------------
library IEEE;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port( 
        clock, reset, load, j1, j2: in std_logic;
        init_time: in std_logic_vector(7 downto 0);
        contj1, contj2: out std_logic_vector(15 downto 0);
        winJ1, winJ2: out std_logic
    );
end relogio_xadrez;


    -- NO ESTADO DE initialization OS CONTADORES SÃO ZERADOS 
architecture relogio_xadrez of relogio_xadrez is
    type states is (initialization,load_start_game,player1,player2,winnerj1,winnerj2);
    signal EA, PE : states;
    signal cont1, cont2: std_logic_vector(15 downto 0);
    signal en1, en2, started: std_logic;    
begin

    -- CRIAÇÃO DO CONTADOR PARA O JOGADOR 1
    contador1 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en1,
        init_time => init_time,
        cont => contj1
    );

    -- CRIAÇÃO DO CONTADOR PARA O JOGADOR 2
    contador2 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en2,
        init_time => init_time,
        cont => contj2
    );

    -- PROCESSO DE TROCA DE ESTADOS
    process (clock, reset)
    begin
        if reset = '1' then
            EA <= initialization;
        else if rising_edge(clock) then
            if load = '1' then
                EA <= load_start_game;
            else
                EA <= PE;
            end if;
        end if;
    end if;
    end process;


    -- PROCESSO PARA DEFINIR O PROXIMO ESTADO
    process (EA, j1, j2, started, contj1, contj2) 
    begin
        case EA is

            -- ZERANDO OS CONTADORES
            when initialization =>
                if load ='1' then 
                    PE <= load_start_game;
                else 
                    PE <= initialization;
                end if;


            -- CARREGANDO OS TEMPOS INICIAIS
            when load_start_game =>
                if j1 ='1' then 
                    PE <= player1;
                elsif j2 = '1' then PE <= player2;
                else PE <= load_start_game;
                end if;


            -- TURNO DO JOGADOR 1
            when player1 =>
                    if contj1 = x"0" then
                        PE <= winnerj2;
                    else if j1='1' then
                        PE <= player2;
                        else PE <= player1;                        
                        end if;
                    end if;


            -- TURNO DO JOGADOR 2
            when player2 =>
                if contj2 = x"0" then
                    PE <= winnerj1;
                else if j2='1' then
                    PE <= player1;
                    else PE <= player2;
                    end if;
                end if;


            -- VENCEDOR: JOGADOR 1
            when winnerj1 =>
                if reset ='1' then 
                    PE <= initialization;
                elsif load ='1' then PE <= load_start_game;
                end if;


            -- VENCEDOR: JOGADOR 2
            when winnerj2 =>
                if reset ='1' then 
                    PE <= initialization;
                elsif load ='1' then PE<= load_start_game;
                end if;


        end case;


    end process;


        -- O SINAL DE STARTED DETERMINA QUE O JOGO ESTÁ EM ANDAMENTO
        started <= '1' when EA = player1 or EA = player2 else '0';


        -- ATIVA/DESATIVA O CONTADOR 1
        en1 <= '1' when EA = player1 or (EA = load_start_game and started = '1') else '0';


        -- ATIVA/DESATIVA O CONTADOR 2
        en2 <= '1' when EA = player2 or (EA = load_start_game and started = '1') else '0';


        -- DETERMINA SE O JOGADOR 1 VENCEU
        winJ1 <= '1' when EA = winnerj1 else '0';


        -- DETERMINA SE O JOGADOR 2 VENCEU
        winJ2 <= '1' when EA = winnerj2 else '0';
end relogio_xadrez;


