import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController _emailTextController = TextEditingController();

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
                SizedBox(height: 10),
                logoWidget("assets/logo.png"),
                SizedBox(height: 30),
                textReusavel("Coloque o Email", Icons.person_outline, false,
                    _emailTextController,
                    fontFamily: ''),
                SizedBox(height: 20),
                textReusavel("Coloque a senha", Icons.lock_outline, true,
                    _passwordTextController,
                    fontFamily: ''),
                SizedBox(height: 20),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                        _showSnackBar(context, "Login efetuado com sucesso!", Colors.black);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelecaoOvosScreen()));
                      })
                      .catchError((error) {
                        String errorMessage = _getErrorMessage(error.code);
                        _showSnackBar(context, "Erro: $errorMessage", Colors.red);
                      });
                }),
                signUpOption(),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _resetPasswordDialog(context);
                  },
                  child: const Text(
                    "Esqueceu a senha?",
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'O email fornecido é inválido.';
      case 'user-disabled':
        return 'Este usuário foi desativado.';
      case 'user-not-found':
        return 'Nenhum usuário encontrado com este email.';
      case 'wrong-password':
        return 'A senha fornecida está incorreta.';
      default:
        return 'Ocorreu um erro desconhecido.';
    }
  }

  void _resetPasswordDialog(BuildContext context) {
    final TextEditingController _resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Redefinir Senha"),
        content: TextField(
          controller: _resetEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: "Coloque seu Email"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              _resetPassword(_resetEmailController.text);
              Navigator.of(context).pop();
            },
            child: Text("Redefinir"),
          ),
        ],
      ),
    );
  }

  void _resetPassword(String email) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
          _showSnackBar(context, "Email de redefinição de senha enviado!", Colors.black);
        })
        .catchError((error) {
          String errorMessage = _getErrorMessage(error.code);
          _showSnackBar(context, "Erro: $errorMessage", Colors.red);
        });
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
