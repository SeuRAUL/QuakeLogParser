README

# Quake log parser

## Descrição

O seguinte script converte um arquivo de log gerado pelo servidor de quake 3 arena filtrando as informação de mortes de cada partida do log.

Para cada jogo o parser gerar algo como:

    game_1: {
      total_kills: 45;
      players: ["Dono da bola", "Isgalamido", "Zeh"]
      kills: {
        "Dono da bola": 5,
        "Isgalamido": 18,
        "Zeh": 20
      }
      kills_by_means: {
        "MOD_SHOTGUN": 10,
        "MOD_RAILGUN": 2,
        "MOD_GAUNTLET": 1,
      }
    }

    Onde:
      total_kills     - Total de mortes na partida
      players         - Jogadores participantes
      kills           - Qauntidade de mortes que cada jogador causou
      kills_by_means  - Causas de mortes no jogo, rankeadas.



## Uso

Por terminar, rodar o comando
    
    ruby parser.rb <arquivo_de_log.log>