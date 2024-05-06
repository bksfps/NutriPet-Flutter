import 'package:flutter/material.dart';
import 'package:nutripet1/pet.dart';
import 'package:nutripet1/petlog.dart';
import 'package:nutripet1/telas/pet_tela.dart';

class SelecaoOvosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Definindo a cor de fundo como verde
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPetTypeButton(context, 'DINOSSAURO', PetType.dinossauro),
            SizedBox(height: 20), // Adicionando espaçamento entre os botões e os textos
            _buildPetTypeButton(context, 'DRAGON', PetType.dragao),
            SizedBox(height: 20), // Adicionando espaçamento entre os botões e os textos
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
            fontSize: 20, // Aumentando o tamanho do texto
            fontFamily: 'PixelatedDisplay', // Nome da fonte pixelizada
          ),
        ),
        SizedBox(height: 10), // Adicionando espaçamento entre o texto e o botão
        ElevatedButton(
          onPressed: () => _selectPet(context, type),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.transparent, // Cor do texto
            side: BorderSide(color: Colors.black), // Cor da borda
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
          title: Text('DIGITE O NOME DO PET', style: TextStyle(fontFamily: 'PixelatedDisplay', color: Colors.black)), // Aplicando a fonte PixelatedDisplay e cor do texto
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
                foregroundColor: Colors.black, // Cor do texto
              ),
              child: Text('CANCELAR'), // Não é necessário aplicar a fonte aqui, pois a cor do texto já foi definida acima
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToExibicaoPetScreen(context, type, nameController.text);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Cor do texto
              ),
              child: Text('CONFIRMAR'), // Não é necessário aplicar a fonte aqui, pois a cor do texto já foi definida acima
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
