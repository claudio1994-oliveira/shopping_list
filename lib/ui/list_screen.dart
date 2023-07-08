import 'package:flutter/material.dart';
import 'package:lista_compras/models/item.dart';
import 'package:lista_compras/ui/add_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);
  @override
  State<ListScreen> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  List<Item> items = <Item>[
    Item(title: 'teste1', isDone: false),
    Item(title: 'teste2', isDone: false),
    Item(title: 'teste3', isDone: false),
    Item(title: 'teste4', isDone: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Compras"),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) => ListTile(
                leading: const CircleAvatar(
                  child: IconTheme(
                      data: IconThemeData(color: Colors.white),
                      child: Icon(Icons.shopping_cart)),
                ),
                title: Text(items[index].title),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                ),
              )),
          separatorBuilder: (context, index) => const Divider(
                color: Colors.orange,
              ),
          itemCount: items.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _addItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addItem(BuildContext context) async {
    final item = await showDialog<Item>(
        context: context, builder: (BuildContext context) => AddItem());
    setState(() {
      items.add(item!);
    });
  }
}
