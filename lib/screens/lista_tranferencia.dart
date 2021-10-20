import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:flutter/material.dart';

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
