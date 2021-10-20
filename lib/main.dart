// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytebank/screens/lista_tranferencia.dart';
import 'package:flutter/material.dart';

void main() {
  // String printText({String text = "Hello Flutter!"}) {
  //   print(text);
  //   return text;
  // }

  // runApp(MyApp());
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.cyan),
      home: ListaTransferencia(),
    );
  }
}
