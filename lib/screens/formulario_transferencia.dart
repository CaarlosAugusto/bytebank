import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownTipoTrans(),
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

class DropdownTipoTrans extends StatefulWidget {
  const DropdownTipoTrans({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DropdownTipoTransState();
  }
}

class DropdownTipoTransState extends State<DropdownTipoTrans> {
  final List<String> list_items = ['CPF/CNPJ', "Celular", "Email"];
  String? _value = 'CPF/CNPJ';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          style: TextStyle(fontSize: 24.0, color: Colors.black54),
          value: _value,
          items: list_items.map((String item) {
            return DropdownMenuItem<String>(
              child: Text('$item'),
              value: item,
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _value = value;
            });
          },
          hint: Text("Tipo de chave"),
          isExpanded: true,
        ));
  }
}
