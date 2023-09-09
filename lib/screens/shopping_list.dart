import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_helper_flutter/data/categories.dart';
import 'package:shopping_helper_flutter/inherited_notifier.dart';

import 'package:shopping_helper_flutter/models/grocery_item.dart';
import 'package:shopping_helper_flutter/screens/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<GroceryItem> _shoppingList3 = [];

  // Future<List<GroceryItem>> _loadItems() async {
  //   final url = Uri.https(
  //       'shopping-helper-7f4f4-default-rtdb.europe-west1.firebasedatabase.app',
  //       'shopping-list.json');

  //   final response = await http.get(url);
  //   final Map<String, dynamic> listData = json.decode(response.body);
  //   final List<GroceryItem> loadedItems = [];

  //   for (final item in listData.entries) {
  //     final category = categories.entries
  //         .firstWhere((c) => c.value.title == item.value['category'])
  //         .value;
  //     loadedItems.add(
  //       GroceryItem(
  //           id: item.key,
  //           name: item.value['name'],
  //           quantity: item.value['quantity'],
  //           category: category),
  //     );
  //   }
  //   _shoppingList = loadedItems;
  //   return loadedItems;
  // }

  void _addItem() async {
    // final newItem = await Navigator.of(context).push<GroceryItem>(
    //   MaterialPageRoute(
    //     builder: (ctx) => const NewItem(),
    //   ),
    // );
    // if (newItem == null) {
    //   return;
    // }
    // setState(() {
    //   _shoppingList.add(newItem);
    // });
  }

  void _removeItem(GroceryItem item) async {
    // final index = _shoppingList.indexOf(item);

    // setState(() {
    //   _shoppingList.remove(item);
    // });

    // final url = Uri.https(
    //     'shopping-helper-7f4f4-default-rtdb.europe-west1.firebasedatabase.app',
    //     'shopping-list/${item.id}.json');
    // final response = await http.delete(url);

    // if (response.statusCode >= 400) {
    //   setState(() {
    //     _shoppingList.insert(index, item);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping list"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/new-item');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ShoppingInheritedNotifier(
        notifier: shoppingData,
        child: FutureBuilder(
          future: loadItems(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('Can`t get shooping data'),
              );
            }
            if (snapshot.data!.isEmpty) {
              const Center(child: Text('No items added'));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) {
                  print(shoppingData.shoppingList);
                  return Dismissible(
                    onDismissed: (direction) {
                      _removeItem(ShoppingInheritedNotifier.of(context)[index]);
                    },
                    key: ValueKey(
                        ShoppingInheritedNotifier.of(context)[index].id),
                    child: ListTile(
                      title: Text(
                        ShoppingInheritedNotifier.of(context)[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: ShoppingInheritedNotifier.of(context)[index]
                              .category
                              .color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 24,
                        height: 24,
                      ),
                      trailing: Text(
                        ShoppingInheritedNotifier.of(context)[index]
                            .quantity
                            .toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
