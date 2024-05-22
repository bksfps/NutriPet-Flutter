import 'package:flutter/material.dart';
import 'package:nutripet1/pet.dart';
import 'package:nutripet1/petlog.dart';
import 'package:nutripet1/telas/pet_tela.dart';

class SelecaoOvosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPetTypeButton(context, 'DINOSSAURO', PetType.dinossauro),
            SizedBox(height: 20),
            _buildPetTypeButton(context, 'DRAGÃO', PetType.dragao),
            SizedBox(height: 20),
            _buildPetTypeButton(context, 'UNICORNIO', PetType.unicornio),
          ],
        ),
      ),
    );
  }

  Widget _buildPetTypeButton(
      BuildContext context, String typeName, PetType type) {
    return Column(
      children: [
        Text(
          typeName,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'PixelatedDisplay',
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _selectPet(context, type),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.transparent,
            side: BorderSide(color: Colors.black),
          ),
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
          title: Text('DIGITE O NOME DO PET', style: TextStyle(fontFamily: 'PixelatedDisplay', color: Colors.black)),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'NOME',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: Text('CANCELAR'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToExibicaoPetScreen(context, type, nameController.text);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: Text('CONFIRMAR'),
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
