import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutripet1/telas/login_tela.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Simulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => SelecaoOvosScreen(),
      //   '/exibicao_pet': (context) {
      //     PetLog petLog = PetLog(
      //       petName: '',
      //       type: PetType.dinossauro,
      //     );
      //     return ExibicaoPetScreen(petLog: petLog);
      //   },
      // },
      home: const TelaLogin(),
    );
  }
}
