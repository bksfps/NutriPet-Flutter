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
                    '${_pet.name.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'PixelatedDisplay',
                    ),
                  ),
                  SizedBox(height: 10),
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
              height: 210,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: Container(
                color: Color.fromARGB(255, 226, 227, 180),
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    _buildProgressBar('ALIMENTAÇÃO', _pet.alimentacao),
                    _buildProgressBar('FELICIDADE', _pet.felicidade),
                    _buildProgressBar('ENERGIA', _pet.energia),
                    _buildProgressBar('FORÇA', _pet.forca),
                  ],
                ),
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
                color: Color.fromARGB(255, 18, 237, 102),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.account_circle, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text('NOME DO PET: ${_pet.name.toUpperCase()}',
                      style: TextStyle(fontFamily: 'PixelatedDisplay')),
                  Text('NÍVEL DO PET: ${_pet.level}'.toUpperCase(),
                      style: TextStyle(fontFamily: 'PixelatedDisplay')),
                ],
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.pets, color: Colors.black),
              ),
              title: const Text('ALIMENTAR',
                  style: TextStyle(fontFamily: 'PixelatedDisplay')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AlimentarTela(petLog: widget.petLog)),
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
                      '${value.toInt()}',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'PixelatedDisplay',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            '$label',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              fontFamily: 'PixelatedDisplay',
            ),
          ),
        ],
      ),
    );
  }

  String _getImagePath() {
    if (_pet.isAngry) {
      switch (_pet.type) {
        case PetType.dinossauro:
          return 'assets/dino/pet_dinossaurobravo.gif';
        case PetType.dragao:
          return 'assets/dragao/pet_dragaobravo.gif';
        case PetType.unicornio:
          return 'assets/unicornio/pet_unicorniobravo.gif';
        default:
          return '';
      }
    } 
    else if (_pet.isHappy) {
      switch (_pet.type) {
        case PetType.dinossauro:
          return 'assets/dino/pet_dinossaurofeliz.gif';
        case PetType.dragao:
          return 'assets/dragao/pet_dragaofeliz.gif';
        case PetType.unicornio:
          return 'assets/unicornio/pet_unicorniofeliz.gif';
        default:
          return '';
      }
    } 
    else {
      switch (_pet.type) {
        case PetType.dinossauro:
          return 'assets/dino/pet_dinossauro.gif';
        case PetType.dragao:
          return 'assets/dragao/pet_dragao.gif';
        case PetType.unicornio:
          return 'assets/unicornio/pet_unicornio.gif';
        default:
          return '';
      }
    }
  }

  String _getBackgroundImagePath() {
    switch (_pet.type) {
      case PetType.dinossauro:
        return 'assets/fundo.jpeg';
      case PetType.dragao:
        return 'assets/fundo.jpeg';
      case PetType.unicornio:
        return 'assets/fundo.jpeg';
      default:
        return '';
    }
  }
}
