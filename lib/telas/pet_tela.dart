import 'package:flutter/material.dart';
import 'package:nutripet1/pet.dart';
import 'package:nutripet1/petlog.dart';
import 'alimentar_tela.dart';
import 'dart:async';

class ExibicaoPetScreen extends StatefulWidget {
  final PetLog petLog;

  ExibicaoPetScreen({required this.petLog});

  @override
  _ExibicaoPetScreenState createState() => _ExibicaoPetScreenState();
}

class _ExibicaoPetScreenState extends State<ExibicaoPetScreen> {
  late Pet _pet;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pet = widget.petLog.getPetStatus();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _pet = widget.petLog.getPetStatus();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.petLog.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_getBackgroundImagePath()),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nome do Pet: ${_pet.name}',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Image.asset(_getImagePath()),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.all(6),
              child: Column(
                children: [
                  _buildProgressBar('Alimentação', _pet.alimentacao),
                  _buildProgressBar('Felicidade', _pet.felicidade),
                  _buildProgressBar('Energia', _pet.energia),
                  _buildProgressBar('Força', _pet.forca),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome do Pet: ${_pet.name}'),
                  Text('Nível do Pet: ${_pet.level}'),
                ],
              ),
            ),
            ListTile(
              title: const Text('Alimentar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlimentarTela(petLog: widget.petLog)),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, double value) {
    Color color = value > 30 ? Colors.green : Colors.red;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: value / 100,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$value',
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            '$label',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
          ),
        ],
      ),
    );
  }

  String _getImagePath() {
    switch (_pet.type) {
      case PetType.dinossauro:
        return 'assets/pet_dinossauro.png';
      case PetType.dragao:
        return 'assets/pet_dragao.png';
      case PetType.gato:
        return 'assets/pet_gato.png';
      default:
        return '';
    }
  }

  String _getBackgroundImagePath() {
    switch (_pet.type) {
      case PetType.dinossauro:
        return 'assets/fundo.jpeg';
      case PetType.dragao:
        return 'assets/fundo.jpeg';
      case PetType.gato:
        return 'assets/fundo.jpeg';
      default:
        return '';
    }
  }
}
