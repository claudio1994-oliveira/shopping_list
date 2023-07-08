import 'package:flutter/material.dart';
import 'package:lista_compras/models/item.dart';

class AddItem extends StatelessWidget {
  AddItem({Key? key}) : super(key: key);

  final itemC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      autofocus: true,
      controller: itemC,
      onChanged: (String value) {
        /* setState(() {
          items.add(Item(title: value));
        }); */
      },
    );

    return AlertDialog(
      title: const Text("Adicionar Item"),
      content: textField,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () {
              final item = Item(title: itemC.text);
              itemC.clear();
              Navigator.of(context).pop(item);
            },
            child: const Text("Adicionar")),
      ],
    );
  }
}
