// toda a lógica de funcionamento da barra de status e o alteramnto dela

import 'dart:async';
import 'pet.dart';
import 'alimentos.dart';

class PetLog {
  late Pet _pet;
  late Timer _timer;
  late int _feedCount;

  PetLog({required String petName, required PetType type}) {
    _pet = Pet(
      name: petName,
      level: 1,
      alimentacao: 100,
      felicidade: 100,
      energia: 100,
      forca: 100,
      type: type,
    );
    _feedCount = 0; // Inicialize o contador
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_pet.alimentacao > 0) _pet.alimentacao -= 1;
      if (_pet.felicidade > 0) _pet.felicidade -= 1;
      if (_pet.energia > 0) _pet.energia -= 1;
      if (_pet.forca > 0) _pet.forca -= 1;
      if (_pet.alimentacao == 0) _pet.alimentacao = 0;
      if (_pet.felicidade == 0) _pet.felicidade = 0;
      if (_pet.energia == 0) _pet.energia = 0;
      if (_pet.forca == 0) _pet.forca = 0;
      if (_pet.alimentacao < 0) _pet.alimentacao = 0;
      if (_pet.felicidade < 0) _pet.felicidade = 0;
      if (_pet.energia < 0) _pet.energia = 0;
      if (_pet.forca < 0) _pet.forca = 0;
    });
  }


  Pet get pet => _pet;

  Pet getPetStatus() {
    return _pet;
  }

  void dispose() {
    _timer.cancel();
  }

  void feedPet(Alimento alimento) {
    _pet.alimentacao += alimento.alimentacao;
    _pet.felicidade += alimento.felicidade;
    _pet.energia += alimento.energia;
    _pet.forca += alimento.forca;

    if (_pet.alimentacao > 100) _pet.alimentacao = 100;
    if (_pet.felicidade > 100) _pet.felicidade = 100;
    if (_pet.energia > 100) _pet.energia = 100;
    if (_pet.forca > 100) _pet.forca = 100;

    _feedCount++;
    if (_feedCount % 5 == 0) {
      _pet.level++; 
    }
    
  }
}
