import 'dart:math';

class Missao {
  final String titulo;
  final String descricao;
  final int recompensa;
  bool concluida;

  Missao({required this.titulo, required this.descricao, required this.recompensa, this.concluida = false});
}

class Missoes {
  static int _contadorLoteria = 0; // Adiciona um contador para a loteria

  static List<Missao> missoesSemanais = [
    Missao(
      titulo: 'ALIMENTAR O PET 5 VEZES',
      descricao: 'ALIMENTE O SEU PET 5 VEZES DURANTE A SEMANA.',
      recompensa: 50,
    ),
    Missao(
      titulo: 'JOGAR NA LOTERIA 3 VEZES',
      descricao: 'PARTICIPE DA LOTERIA 3 VEZES DURANTE A SEMANA.',
      recompensa: 30,
    ),
    Missao(
      titulo: 'PRATICAR EXERCÍCIOS FÍSICOS 4 VEZES',
      descricao: 'PRATIQUE EXERCÍCIOS FÍSICOS PELO CRONÔMETRO PELO MENOS 4 VEZES DURANTE A SEMANA .',
      recompensa: 20,
    ),
    Missao(
      titulo: 'ENTRE NO JOGO 3 DIAS SEGUIDOS',
      descricao: 'ENTRE NO JOGO 3 DIAS SEGUIDOS DURANTE A SEMANA.',
      recompensa: 40,
    ),
    Missao(
      titulo: 'BRINCAR COM O PET',
      descricao: 'PASSE UM TEMPO DE QUALIDADE BRINCANDO COM SEU PET.',
      recompensa: 25,
    ),
    Missao(
      titulo: 'DAR UM BANHO NO PET',
      descricao: 'DÊ UM BANHO NO SEU PET.',
      recompensa: 35,
    ),
    Missao(
      titulo: 'ENSINAR NOVO TRUQUE',
      descricao: 'ENSINE UM NOVO TRUQUE AO SEU PET.',
      recompensa: 45,
    ),
  ];

  static void incrementarContadorLoteria() {
    _contadorLoteria++;
    _verificarMissaoConcluida(); // Chama a função para verificar se a missão foi concluída
  }

  static void _verificarMissaoConcluida() {
    for (var missao in missoesSemanais) {
      if (missao.titulo == 'JOGAR NA LOTERIA 3 VEZES' && _contadorLoteria >= 3) { // Verifica se o usuário girou a loteria 3 vezes
        missao.concluida = true; // Marca a missão como concluída
      }
    }
  }

  // Função para obter missões aleatórias
  static List<Missao> obterMissoesAleatorias(int quantidade) {
    List<Missao> missoesAleatorias = [];

    if (quantidade > missoesSemanais.length) {
      quantidade = missoesSemanais.length;
    }

    List<int> indicesUtilizados = [];
    while (missoesAleatorias.length < quantidade) {
      int indice = Random().nextInt(missoesSemanais.length);
      if (!indicesUtilizados.contains(indice)) {
        missoesAleatorias.add(missoesSemanais[indice]);
        indicesUtilizados.add(indice);
      }
    }

    return missoesAleatorias;
  }
}
