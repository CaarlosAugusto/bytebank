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
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController controladorNumeroConta = TextEditingController();
  final TextEditingController controladorValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(controladorNumeroConta.text);
    final double? valor = double.tryParse(controladorValor.text);
    // (!) null check
    if (numeroConta != null && valor != null) {
      debugPrint("Criando transferência");
      final transferencia = Transferencia(valor, numeroConta);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("$transferencia")));
      Navigator.pop(context, transferencia);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando transferência"),
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: widget.controladorNumeroConta,
                rotulo: "Número da conta",
                dica: "0000"),
            Editor(
                controlador: widget.controladorValor,
                rotulo: "Valor",
                dica: "0.00",
                icone: Icons.monetization_on),
            ElevatedButton(
                child: Text("Confirmar"),
                onPressed: () {
                  debugPrint("clicou em confirmar");
                  widget._criaTransferencia(context);
                })
          ],
        ),
      ),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia?> _transferencia = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferências"),
        backgroundColor: Colors.green[600],
      ),
      body: ListView.builder(
          itemCount: widget._transferencia.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencia[indice];
            return ItemTransferencia(transferencia!);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((tranferenciaRecebida) {
            debugPrint("Chegou no then do future");
            debugPrint("$tranferenciaRecebida");
            if (tranferenciaRecebida != null) {
              setState(() => widget._transferencia.add(tranferenciaRecebida));
            }
          });
        },
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
