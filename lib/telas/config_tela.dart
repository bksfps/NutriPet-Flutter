import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutripet1/telas/widgetUsavel/theme_provider.dart';

class ConfigTela extends StatefulWidget {
  @override
  _ConfigTelaState createState() => _ConfigTelaState();
}

class _ConfigTelaState extends State<ConfigTela> {
  bool _notificacoesAtivadas = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
            value: themeProvider.isDarkTheme,
            onChanged: (bool value) {
              themeProvider.toggleTheme();
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
                applicationName: 'Feedit',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(Icons.pets),
                children: [
                  Text(
                    'Feedit é um aplicativo para monitorar a alimentação e saúde dos seus pets virtuais!',
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
