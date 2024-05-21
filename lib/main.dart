import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:nutripet1/telas/login_tela.dart';
import 'package:nutripet1/telas/widgetUsavel/theme_provider.dart'; // Import do provedor de tema

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Pet Simulator',
          theme:
              themeProvider.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          home: const TelaLogin(),
        );
      },
    );
  }
}
