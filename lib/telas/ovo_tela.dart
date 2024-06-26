import 'package:flutter/material.dart';
import 'package:nutripet1/pet.dart';
import 'package:nutripet1/petlog.dart';
import 'package:nutripet1/telas/pet_tela.dart';
import 'package:audioplayers/audioplayers.dart';

class SelecaoOvosScreen extends StatefulWidget {
  @override
  _SelecaoOvosScreenState createState() => _SelecaoOvosScreenState();
}

class _SelecaoOvosScreenState extends State<SelecaoOvosScreen> {
  late AudioPlayer backgroundMusicPlayer;

  @override
  void initState() {
    super.initState();
    backgroundMusicPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  @override
  void dispose() {
    backgroundMusicPlayer.dispose();
    super.dispose();
  }

  Future<void> _playBackgroundMusic() async {
    await backgroundMusicPlayer.setSource(AssetSource('audio/ovo_music.mp3'));
    await backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop); 
    await backgroundMusicPlayer.setVolume(0.5);
    await backgroundMusicPlayer.resume();
  }

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
    bool isNameValid = false;
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
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, insira o nome do pet.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  isNameValid = true;
                  Navigator.of(context).pop();
                }
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

    if (isNameValid) {
      _navigateToExibicaoPetScreen(context, type, nameController.text);
    }
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
