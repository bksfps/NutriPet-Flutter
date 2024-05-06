//parte gráfica da tela de alimentar

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alimentar Pet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showFoodDialog(context); //
          },
          child: Text('Selecionar Alimento'),
        ),
      ),
    );
  }

  void _showFoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione um Alimento'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildFoodButtonList(Alimentos.paesMassasCereais),
                _buildFoodButtonList(Alimentos.frutas),
                _buildFoodButtonList(Alimentos.legumes),
                _buildFoodButtonList(Alimentos.leiteDerivados),
                _buildFoodButtonList(Alimentos.carnesOvos),
                _buildFoodButtonList(Alimentos.docesGuloseimas),
                _buildFoodButtonList(Alimentos.salgadosPadaria),
                _buildFoodButtonList(Alimentos.refrigerantesSucos),
                _buildFoodButtonList(Alimentos.sucosNaturais),
                _buildFoodButtonList(Alimentos.embutidos),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFoodButtonList(List<Alimento> foodList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var alimento in foodList)
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedFood = alimento;
              });
              Navigator.of(context).pop();
              _feedPetAndShowNotification(context);
            },
            child: Text(alimento.nome),
          ),
        SizedBox(height: 10),
      ],
    );
  }

  void _feedPetAndShowNotification(BuildContext context) {
    widget.petLog.feedPet(_selectedFood!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Pet foi alimentado com sucesso"),
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }
}