import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripet1/alimentos.dart';
import 'package:nutripet1/petlog.dart';

class AlimentarTela extends StatefulWidget {
  final PetLog petLog;

  AlimentarTela({required this.petLog});

  @override
  _AlimentarTelaState createState() => _AlimentarTelaState();
}

class _AlimentarTelaState extends State<AlimentarTela> {
  Alimento? _selectedFood;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ALIMENTAR PET',
          style: TextStyle(fontFamily: 'PixelatedDisplay'),
        ),
      ),
      body: ListView(
        children: [
          _buildFoodCategory("PÃES, MASSAS E CEREAIS", Alimentos.paesMassasCereais),
          _buildFoodCategory("FRUTAS", Alimentos.frutas),
          _buildFoodCategory("LEGUMES", Alimentos.legumes),
          _buildFoodCategory("LEITE E DERIVADOS", Alimentos.leiteDerivados),
          _buildFoodCategory("CARNES E OVOS", Alimentos.carnesOvos),
          _buildFoodCategory("DOCES E GULOSEIMAS", Alimentos.docesGuloseimas),
          _buildFoodCategory("SALGADOS DE PADARIA", Alimentos.salgadosPadaria),
          _buildFoodCategory("REFRIGERANTES E SUCOS", Alimentos.refrigerantesSucos),
          _buildFoodCategory("SUCOS NATURAIS", Alimentos.sucosNaturais),
          _buildFoodCategory("EMBUTIDOS", Alimentos.embutidos),
        ],
      ),
    );
  }

  Widget _buildFoodCategory(String category, List<Alimento> foodList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'PixelatedDisplay'),
          ),
        ),
        Column(
          children: [
            for (var alimento in foodList)
              _buildFoodButton(alimento),
          ],
        ),
      ],
    );
  }

  Widget _buildFoodButton(Alimento alimento) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedFood = alimento;
        });
        _showConfirmationDialog(context);
      },
      child: ListTile(
        leading: Icon(Icons.food_bank),
        title: Text(
          alimento.nome.toUpperCase(),
          style: TextStyle(fontFamily: 'PixelatedDisplay'),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ENERGIA: ${alimento.energia}",
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
            Text(
              "ALIMENTAÇÃO: ${alimento.alimentacao}",
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
            Text(
              "FELICIDADE: ${alimento.felicidade}",
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
            Text(
              "FORÇA: ${alimento.forca}",
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'CONFIRMAR ALIMENTAÇÃO',
            style: TextStyle(fontFamily: 'PixelatedDisplay'),
          ),
          content: Text(
            'VOCÊ DESEJAR ALIMENTAR O PET COM ${_selectedFood!.nome.toUpperCase()}?',
            style: TextStyle(fontFamily: 'PixelatedDisplay'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCELAR',
                style: TextStyle(fontFamily: 'PixelatedDisplay'),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _pickImageFromCamera();
                if (_imageFile != null) {
                  _feedPetAndShowNotification(context);
                  Navigator.pop(context);
                  Navigator.pop(context); // Fechar tela de alimentação
                }
              },
              child: Text(
                'CONFIRMAR',
                style: TextStyle(fontFamily: 'PixelatedDisplay'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }

  void _feedPetAndShowNotification(BuildContext context) {
    widget.petLog.feedPet(_selectedFood!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "PET FOI ALIMENTADO COM SUCESSO",
          style: TextStyle(fontFamily: 'PixelatedDisplay'),
        ),
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.pop(context); // Fechar o drawer
  }
}
