import 'package:flutter/material.dart';
import 'package:shopping_helper_flutter/models/grocery_item.dart';
import 'package:shopping_helper_flutter/widgets/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final List<GroceryItem> _shoppingList = [];

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

  void _removeItem(GroceryItem item) {
    setState(() {
      _shoppingList.remove(item);
    });
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
      body: _shoppingList.isNotEmpty
          ? ListView.builder(
              itemCount: _shoppingList.length,
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
            )
          : const Center(
              child: Text('No items added'),
            ),
    );
  }
}
