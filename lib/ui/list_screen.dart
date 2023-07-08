import 'package:flutter/material.dart';
import 'package:lista_compras/models/item.dart';
import 'package:lista_compras/ui/add_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  List<Item> items = <Item>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Compras"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                child: IconTheme(
                  data: const IconThemeData(color: Colors.white),
                  child: Icon(
                    items[index].isDone
                        ? Icons.check_circle
                        : Icons.shopping_cart,
                  ),
                ),
              ),
              title: Text(items[index].title),
              onTap: () {
                setState(() {
                  items[index].isDone = !items[index].isDone;
                });
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    items.removeAt(index);
                  });
                },
              ),
            ),
            separatorBuilder: (context, index) => const Divider(
              color: Colors.orange,
            ),
            itemCount: items.length,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addItem(BuildContext context) async {
    final item = await showDialog<Item>(
      context: context,
      builder: (BuildContext context) => AddItem(),
    );
    if (item != null) {
      setState(() {
        items.add(item);
      });
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      items.sort((a, b) {
        if (a.isDone && !b.isDone) {
          return 1;
        } else if (!a.isDone && b.isDone) {
          return -1;
        } else {
          return 0;
        }
      });
    });

    return Future.value();
  }
}
