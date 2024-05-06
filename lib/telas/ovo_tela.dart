//parte gráfica da tela do ovo

import 'package:flutter/material.dart';
import 'package:nutripet1/pet.dart';
import 'package:nutripet1/petlog.dart';
import 'package:nutripet1/telas/pet_tela.dart';

class SelecaoOvosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleção de Ovos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPetTypeButton(context, 'Dinossauro', PetType.dinossauro),
            _buildPetTypeButton(context, 'Dragão', PetType.dragao),
            _buildPetTypeButton(context, 'Gato', PetType.gato),
          ],
        ),
      ),
    );
  }

  Widget _buildPetTypeButton(
      BuildContext context, String typeName, PetType type) {
    return Column(
      children: [
        Text(typeName),
        ElevatedButton(
          onPressed: () => _selectPet(context, type),
          child: SizedBox(
            height: 80,
            width: 100,
            child: Image.asset('assets/egg${type.index + 1}.png'),
          ),
        ),
      ],
    );
  }

  void _selectPet(BuildContext context, PetType type) async {
    final nameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Digite o nome do pet'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Nome',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToExibicaoPetScreen(context, type, nameController.text);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToExibicaoPetScreen(BuildContext context, PetType type, String name) {
    PetLog petLog = PetLog(petName: name, type: type);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExibicaoPetScreen(
          petLog: petLog,
        ),
      ),
    );
  }
}
