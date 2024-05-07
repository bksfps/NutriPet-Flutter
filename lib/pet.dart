// tipo do pet e definição dos atributos

enum PetType {
  dinossauro,
  dragao,
  unicornio,
}

class Pet {
  String name;
  int level;
  double alimentacao;
  double felicidade;
  double energia;
  double forca;
  PetType type;
  bool isAngry;
  bool isHappy;

  Pet({
    required this.name,
    required this.level,
    required this.alimentacao,
    required this.felicidade,
    required this.energia,
    required this.forca,
    required this.type,
    this.isAngry = false,
    this.isHappy = false,
  });
}
