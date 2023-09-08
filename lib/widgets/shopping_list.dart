import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_helper_flutter/data/categories.dart';

import 'package:shopping_helper_flutter/models/grocery_item.dart';
import 'package:shopping_helper_flutter/widgets/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<GroceryItem> _shoppingList = [];

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'shopping-helper-7f4f4-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');

    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((c) => c.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category),
      );
    }
    _shoppingList = loadedItems;
    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _shoppingList.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _shoppingList.indexOf(item);

    setState(() {
      _shoppingList.remove(item);
    });

    final url = Uri.https(
        'shopping-helper-7f4f4-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _shoppingList.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping list"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: _loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data!.isEmpty) {
            const Center(child: Text('No items added'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) {
                _removeItem(_shoppingList[index]);
              },
              key: ValueKey(_shoppingList[index].id),
              child: ListTile(
                title: Text(
                  _shoppingList[index].name,
                  style: const TextStyle(fontSize: 20),
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    color: _shoppingList[index].category.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 24,
                  height: 24,
                ),
                trailing: Text(
                  _shoppingList[index].quantity.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
