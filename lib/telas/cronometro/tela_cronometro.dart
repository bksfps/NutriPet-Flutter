import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutripet1/petlog.dart';
import 'package:nutripet1/telas/pet_tela.dart'; // Certifique-se de que este é o caminho correto para ExibicaoPetScreen

class TelaCronometo extends StatefulWidget {
  final PetLog petLog; // Adicione esta linha

  const TelaCronometo({Key? key, required this.petLog}) : super(key: key); // Adicione este construtor

  @override
  State<TelaCronometo> createState() => _TelaCronometoState();
}

class _TelaCronometoState extends State<TelaCronometo> {
  late Stopwatch stopwatch;
  late Timer t;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(2, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    String hours = ((milli ~/ (1000 * 60 * 60)) % 24).toString().padLeft(2, "0");

    return "$hours:$minutes:$seconds:$milliseconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'EXERCÍCIO',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'PixelatedDisplay',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ExibicaoPetScreen(petLog: widget.petLog)), // Ajuste para ExibicaoPetScreen
            );
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  handleStartStop();
                },
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 4,
                    ),
                  ),
                  child: Text(
                    returnFormattedText(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'PixelatedDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                  color: Colors.white,
                ),
                child: CupertinoButton(
                  onPressed: () {
                    stopwatch.reset();
                  },
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Zerar",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'PixelatedDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
