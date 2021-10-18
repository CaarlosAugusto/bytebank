// ignore_for_file: prefer_const_constructors

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
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController controladorNumeroConta = TextEditingController();
  final TextEditingController controladorValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando transferência"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controladorNumeroConta,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                  labelText: "Número da conta", hintText: "0000"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controladorValor,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: "Valor",
                  hintText: "0.00"),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
              child: Text("Confirmar"),
              onPressed: () {
                debugPrint("clicou em confirmar");
                final int? numeroConta =
                    int.tryParse(controladorNumeroConta.text);
                final double? valor = double.tryParse(controladorValor.text);
                // (!) null check
                if (numeroConta != null && valor != null) {
                  final transferencia = Transferencia(valor, numeroConta);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$transferencia")));
                }
              })
        ],
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  const ListaTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bytebank"),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100.0, 1000)),
          ItemTransferencia(Transferencia(200.0, 1001)),
          ItemTransferencia(Transferencia(300.0, 2000)),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    // TODO: implement toString
    return "Transferência{valor: $valor, numeroConta: $numeroConta}";
  }
}
