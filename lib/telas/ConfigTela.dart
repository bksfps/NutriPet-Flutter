import 'package:flutter/material.dart';

class ConfigTela extends StatefulWidget {
  @override
  _ConfigTelaState createState() => _ConfigTelaState();
}

class _ConfigTelaState extends State<ConfigTela> {
  bool _notificacoesAtivadas = true;
  bool _temaEscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONFIGURAÇÕES',
          style: TextStyle(fontFamily: 'PixelatedDisplay'),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Notificações',
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
            value: _notificacoesAtivadas,
            onChanged: (bool value) {
              setState(() {
                _notificacoesAtivadas = value;
              });
            },
          ),
          SwitchListTile(
            title: Text(
              'Tema Escuro',
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
            value: _temaEscuro,
            onChanged: (bool value) {
              setState(() {
                _temaEscuro = value;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'Sobre',
              style: TextStyle(fontFamily: 'PixelatedDisplay'),
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'NutriPet',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(Icons.pets),
                children: [
                  Text(
                    'NutriPet é um aplicativo para monitorar a alimentação e saúde dos seus pets virtuais!',
                    style: TextStyle(fontFamily: 'PixelatedDisplay'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
