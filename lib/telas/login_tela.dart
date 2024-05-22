import 'package:flutter/material.dart';
import 'package:nutripet1/telas/cadastro_tela.dart';
import 'package:nutripet1/telas/ovo_tela.dart';
import 'package:nutripet1/telas/widgetUsavel/widgetUsavel.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).padding.top),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "FEEDIT",
                    style: TextStyle(
                      fontFamily: 'PixelatedDisplay',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                logoWidget("assets/logo.png"),
                SizedBox(
                  height: 30,
                ),
                textReusavel("Coloque usuário", Icons.person_outline, false,
                    _userNameTextController, fontFamily: ''),
                SizedBox(
                  height: 20,
                ),
                textReusavel("Coloque a senha", Icons.lock_outline, true,
                    _passwordTextController, fontFamily: ''),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelecaoOvosScreen()));
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Não tem uma conta? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaCadastro()));
            },
            child: const Text(
              "Cadastre-se",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
