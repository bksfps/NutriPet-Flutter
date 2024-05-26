import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalizarButton extends StatelessWidget {
  final Function onSaveTime;

  const FinalizarButton({super.key, required this.onSaveTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
        color: Colors.white,
      ),
      child: CupertinoButton(
        onPressed: () {
          onSaveTime();
        },
        padding: const EdgeInsets.all(0),
        child: const Text("Finalizar", style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}