import 'package:flutter/material.dart';
import 'package:nutripet1/missoes.dart'; // Importe o arquivo de missões

class MissoesTela extends StatefulWidget {
  @override
  _MissoesTelaState createState() => _MissoesTelaState();
}

class _MissoesTelaState extends State<MissoesTela> {
  List<Missao> _missoesExibidas = Missoes.obterMissoesAleatorias(3);
  DateTime _dataAtual = DateTime.now();

  @override
  void initState() {
    super.initState();
    _verificarDataAtual();
  }

  void _verificarDataAtual() {
    final novaData = DateTime.now();
    if (novaData.weekday == DateTime.monday && _dataAtual.day != novaData.day) {
      setState(() {
        _dataAtual = novaData;
      });
    }
  }

  String _calcularProximoReset() {
    final proximaSegunda = _dataAtual.add(Duration(days: (8 - _dataAtual.weekday) % 7));
    final diasFaltando = proximaSegunda.difference(DateTime.now()).inDays;
    return '$diasFaltando DIAS PARA TROCA DAS MISSÕES';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MISSÕES SEMANAIS', style: TextStyle(fontFamily: 'PixelatedDisplay')),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _missoesExibidas.length,
              itemBuilder: (context, index) {
                Missao missao = _missoesExibidas[index];
                return ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text(missao.titulo, style: TextStyle(fontFamily: 'PixelatedDisplay')),
                  subtitle: Text(missao.descricao, style: TextStyle(fontFamily: 'PixelatedDisplay')),
                  trailing: missao.concluida
                      ? Icon(Icons.check, color: Colors.green)
                      : Text('${missao.recompensa} pontos', style: TextStyle(fontFamily: 'PixelatedDisplay')),
                  tileColor: missao.concluida ? Colors.green.withOpacity(0.3) : null,
                );
              },
            ),
          ),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                _calcularProximoReset(),
                style: TextStyle(fontFamily: 'PixelatedDisplay', fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
