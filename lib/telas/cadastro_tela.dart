import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutripet1/telas/login_tela.dart';
import 'package:nutripet1/telas/widgetUsavel/widgetUsavel.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController _nomeTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _responsavelTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
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
          "CADASTRO",
          style: TextStyle(fontSize: 24, fontFamily: 'PixelatedDisplay'),
        ),
      ),
      body: Container(
        color: Colors.green,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                textReusavel("Digite seu Nome", Icons.person_outline, false,
                    _nomeTextController, fontFamily: 'Bold'),
                const SizedBox(height: 20),
                textReusavel("Digite seu Usuário", Icons.person_outline, false,
                    _userNameTextController, fontFamily: ''),
                const SizedBox(height: 20),
                textReusavel("Digite seu Email", Icons.email, false,
                    _emailTextController, fontFamily: ''),
                const SizedBox(height: 20),
                textReusavel("Digite sua Senha", Icons.lock_outline, true,
                    _passwordTextController, fontFamily: ''),
                const SizedBox(height: 20),
                textReusavel("Confirme sua Senha", Icons.lock_outline, true,
                    _confirmPasswordTextController, fontFamily: ''),
                const SizedBox(height: 20),
                textReusavel("Digite o Nome do Responsável",
                    Icons.emoji_people, false, _responsavelTextController, fontFamily: ''),
                const SizedBox(height: 20),
                signInSignUpButton(context, false, () {
                  if (_passwordTextController.text ==
                      _confirmPasswordTextController.text) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) async {
                      await value.user?.sendEmailVerification();
                      _showSnackBar(context,
                          "Conta criada com sucesso! Verifique seu email.", Colors.black);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TelaLogin()));
                    }).catchError((error) {
                      String errorMessage = _getErrorMessage(error.code);
                      _showSnackBar(context, "Erro: $errorMessage", Colors.red);
                    });
                  } else {
                    _showSnackBar(context, "As senhas não coincidem.", Colors.red);
                  }
                }),
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
      case 'email-already-in-use':
        return 'O email já está em uso por outra conta.';
      case 'invalid-email':
        return 'O email fornecido é inválido.';
      case 'operation-not-allowed':
        return 'Operação não permitida. Entre em contato com o suporte.';
      case 'weak-password':
        return 'A senha fornecida é muito fraca.';
      default:
        return 'Ocorreu um erro desconhecido.';
    }
  }
}
