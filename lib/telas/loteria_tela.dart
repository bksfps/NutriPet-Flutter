import 'package:flutter/material.dart';
import 'package:nutripet1/petlog.dart';
import 'dart:math';

class Loteria {
  List<int> numeros = [];
  int? numeroPremiado;

  void gerarNumeros() {
    Random random = Random();
    numeros = List.generate(5, (_) => random.nextInt(100) + 1);
    sortearNumeroPremiado();
  }

  void sortearNumeroPremiado() {
    Random random = Random();
    numeroPremiado = numeros[random.nextInt(numeros.length)];
  }

  List<int> getNumeros() => numeros;
  int? getNumeroPremiado() => numeroPremiado;
}

class LoteriaTela extends StatefulWidget {
  final PetLog petLog;
  LoteriaTela(this.petLog);

  @override
  _LoteriaTelaState createState() => _LoteriaTelaState(petLog);
}

class _LoteriaTelaState extends State<LoteriaTela> {
  late Loteria loteria;
  String resultado = '';
  int? numeroEscolhido;
  PetLog _petLog;

  _LoteriaTelaState(this._petLog);

  @override
  void initState() {
    super.initState();
    loteria = Loteria();
  }

  void _gerarNovosNumeros() {
    setState(() {
      if (_petLog.loteriaRodadas > 0) {
        _petLog.loteriaRodadas--;
        loteria.gerarNumeros();
        resultado = '';
        numeroEscolhido = null;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'VOCÊ NÃO TEM MAIS RODADAS RESTANTES!',
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
          ),
        );
      }
    });
  }

  void _escolherNumero(int numero) {
    setState(() {
      numeroEscolhido = numero;
      if (numero == loteria.getNumeroPremiado()) {
        _petLog.acertarNumeroPremiado();
        resultado = 'PARABÉNS! VOCÊ ESCOLHEU O NÚMERO PREMIADO!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'SEU PET GANHOU 5 PONTOS EM TODOS OS STATUS!',
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
          ),
        );
      } else {
        resultado = 'QUE PENA! VOCÊ NÃO ESCOLHEU O NÚMERO PREMIADO.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SISTEMA DE LOTERIA', style: TextStyle(fontFamily: 'PixelatedDisplay')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOTERIA',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'PixelatedDisplay'),
            ),
            Center(
              child: Text(
                'GERE NÚMEROS ALEATÓRIOS PARA GANHAR PONTOS DE STATUS PARA SEU PET!',
                style: TextStyle(fontSize: 15, fontFamily: 'PixelatedDisplay'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _petLog.loteriaRodadas > 0 ? _gerarNovosNumeros : null,
              child: Text('GERAR NÚMEROS', style: TextStyle(fontFamily: 'PixelatedDisplay')),
            ),
            SizedBox(height: 20),
            Text(
              'RODADAS RESTANTES: ${_petLog.loteriaRodadas}',
              style: TextStyle(fontSize: 18, fontFamily: 'PixelatedDisplay'),
            ),
            SizedBox(height: 20),
            if (loteria.getNumeros().isNotEmpty && numeroEscolhido == null) ...[
              Text(
                'ESCOLHA UM NÚMERO:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'PixelatedDisplay'),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: loteria.getNumeros().map((numero) {
                  return ActionChip(
                    label: Text(numero.toString().toUpperCase(), style: TextStyle(fontFamily: 'PixelatedDisplay')),
                    onPressed: () => _escolherNumero(numero),
                  );
                }).toList(),
              ),
            ],
            SizedBox(height: 20),
            Center(
              child: Text(
                resultado,
                style: TextStyle(fontSize: 18, color: numeroEscolhido == loteria.getNumeroPremiado() ? Colors.green : Colors.red, fontFamily: 'PixelatedDisplay'),
                textAlign: TextAlign.center,
              ),
            ),
            if (numeroEscolhido != null) ...[
              SizedBox(height: 10),
              Center(
                child: Text(
                  'NÚMERO PREMIADO: ${loteria.getNumeroPremiado()}',
                  style: TextStyle(fontSize: 18, color: Colors.blue, fontFamily: 'PixelatedDisplay'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}