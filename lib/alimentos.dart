
class Alimento {
  final String nome;
  final int energia;
  final int alimentacao;
  final int felicidade;
  final int forca;

  Alimento({
    required this.nome,
    required this.energia,
    required this.alimentacao,
    required this.felicidade,
    required this.forca,
  });
}

class Alimentos {
  static List<Alimento> paesMassasCereais = [
    Alimento(nome: 'Pão', energia: 5, alimentacao: 2, felicidade: 0, forca: 0),
    Alimento(nome: 'Macarrão', energia: 5, alimentacao: 2, felicidade: 0, forca: 0),
  ];

  static List<Alimento> frutas = [
    Alimento(nome: 'Maçã', energia: 6, alimentacao: 3, felicidade: 2, forca: 0),
    Alimento(nome: 'Banana', energia: 6, alimentacao: 3, felicidade: 2, forca: 0),
  ];

  static List<Alimento> legumes = [
    Alimento(nome: 'Cenoura', energia: 0, alimentacao: 5, felicidade: 2, forca: 0),
    Alimento(nome: 'Brócolis', energia: 0, alimentacao: 5, felicidade: 2, forca: 0),
  ];

  static List<Alimento> leiteDerivados = [
    Alimento(nome: 'Leite', energia: 2, alimentacao: 5, felicidade: 2, forca: 4),
    Alimento(nome: 'Queijo', energia: 2, alimentacao: 5, felicidade: 2, forca: 4),
  ];

  static List<Alimento> carnesOvos = [
    Alimento(nome: 'Frango', energia: 0, alimentacao: 4, felicidade: 2, forca: 6),
    Alimento(nome: 'Peixe', energia: 0, alimentacao: 4, felicidade: 2, forca: 6),
  ];

  static List<Alimento> docesGuloseimas = [
    Alimento(nome: 'Chocolate', energia: 3, alimentacao: -3, felicidade: 4, forca: 0),
    Alimento(nome: 'Balas', energia: 3, alimentacao: -3, felicidade: 4, forca: 0),
  ];

  static List<Alimento> salgadosPadaria = [
    Alimento(nome: 'Coxinha', energia: 2, alimentacao: -2, felicidade: 4, forca: 0),
    Alimento(nome: 'Pão de queijo', energia: 2, alimentacao: -2, felicidade: 4, forca: 0),
  ];

  static List<Alimento> refrigerantesSucos = [
    Alimento(nome: 'Refrigerante', energia: 2, alimentacao: -5, felicidade: 0, forca: 0),
    Alimento(nome: 'Suco de caixinha', energia: 2, alimentacao: -5, felicidade: 0, forca: 0),
  ];

  static List<Alimento> sucosNaturais = [
    Alimento(nome: 'Suco de laranja', energia: 4, alimentacao: 2, felicidade: 2, forca: 0),
    Alimento(nome: 'Suco de morango', energia: 4, alimentacao: 2, felicidade: 2, forca: 0),
  ];

  static List<Alimento> embutidos = [
    Alimento(nome: 'Presunto', energia: 2, alimentacao: 0, felicidade: 0, forca: 2),
    Alimento(nome: 'Peito de peru', energia: 2, alimentacao: 0, felicidade: 0, forca: 2),
  ];
}
