import 'package:flutter/material.dart';
import 'package:nutripet1/telas/login_tela.dart';
import 'package:nutripet1/telas/widgetUsavel/widgetUsavel.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController _nomeTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _responsavelTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Cadastre-se",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.green,
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2 , 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              textReusavel("Coloque seu Nome", Icons.person_outline, false, _nomeTextController, fontFamily: 'Bold'),
              const SizedBox(
                height: 20,
              ),
              textReusavel("Coloque Usuário", Icons.person_outline, false, _userNameTextController, fontFamily: ''),
              const SizedBox(
                height: 20,
              ),
              textReusavel("Coloque Email", Icons.email, false, _emailTextController, fontFamily: ''),
              const SizedBox(
                height: 20,
              ),
              textReusavel("Coloque Senha", Icons.lock_outline, true, _passwordTextController, fontFamily: ''),
              const SizedBox(
                height: 20,
              ),
              textReusavel("Coloque Nome do Responsável", Icons.emoji_people, false, _responsavelTextController, fontFamily: ''),
              const SizedBox(
                height: 20,
              ),
              signInSignUpButton(context, false, (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaLogin()));
              })
            ],
          ),
        ),
      ),
    ));
  }
}
