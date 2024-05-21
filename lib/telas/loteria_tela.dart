import 'package:flutter/material.dart';
import 'package:nutripet1/petlog.dart';
import 'dart:math';

class LoteriaTela extends StatefulWidget {
  final PetLog petLog;
  LoteriaTela(this.petLog);

  @override
  _LoteriaTelaState createState() => _LoteriaTelaState(petLog);
}

class _LoteriaTelaState extends State<LoteriaTela> {
  String resultado = '';
  int? numeroEscolhido;
  PetLog _petLog;

  _LoteriaTelaState(this._petLog);

  void _gerarNovosNumeros() {
    setState(() {
      if (_petLog.loteriaRodadas > 0) {
        _petLog.loteriaRodadas--;
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
      if (numero == 42 /* Número premiado */) {
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
            if (numeroEscolhido == null) ...[
              Text(
                'ESCOLHA UM NÚMERO:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'PixelatedDisplay'),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List.generate(5, (index) {
                  return ActionChip(
                    label: Text((index + 1).toString().toUpperCase(), style: TextStyle(fontFamily: 'PixelatedDisplay')),
                    onPressed: () => _escolherNumero(index + 1),
                  );
                }),
              ),
            ],
            SizedBox(height: 20),
            Center(
              child: Text(
                resultado,
                style: TextStyle(fontSize: 18, color: numeroEscolhido == 42 /* Número premiado */ ? Colors.green : Colors.red, fontFamily: 'PixelatedDisplay'),
                textAlign: TextAlign.center,
              ),
            ),
            if (numeroEscolhido != null) ...[
              SizedBox(height: 10),
              Center(
                child: Text(
                  'NÚMERO PREMIADO: 42',
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
