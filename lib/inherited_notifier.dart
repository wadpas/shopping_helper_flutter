import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_helper_flutter/models/category.dart';

import 'data/categories.dart';
import 'models/grocery_item.dart';

final url = Uri.https(
    'comon-database-8a85d-default-rtdb.europe-west1.firebasedatabase.app',
    'shopping-list.json');

class ShoppingData extends ChangeNotifier {
  List<GroceryItem> _shoppingList = [];

  List<GroceryItem> get shoppingList => _shoppingList;

  set shoppingList(List<GroceryItem> newShoppingList) {
    if (newShoppingList != shoppingList) {
      _shoppingList = newShoppingList;
      notifyListeners();
    }
  }

  void addItem(GroceryItem item) {
    _shoppingList.add(item);
    notifyListeners();
  }

  void removeItem(GroceryItem item) {
    _shoppingList.remove(item);
    notifyListeners();
  }
}

final shoppingData = ShoppingData();

class ShoppingInheritedNotifier extends InheritedNotifier<ShoppingData> {
  const ShoppingInheritedNotifier({
    Key? super.key,
    required super.notifier,
    required super.child,
  });

  static List<GroceryItem> of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<ShoppingInheritedNotifier>()
          ?.notifier
          ?.shoppingList ??
      [];
}

Future<List<GroceryItem>> loadItems() async {
  final response = await http.get(url);

  if (response.statusCode == 400) {
    throw Exception('Failed to fetch data');
  }

  if (response.body == 'null') {
    return [];
  }

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
  shoppingData.shoppingList = loadedItems;
  return loadedItems;
}

late GroceryItem _newItem;

Future<void> addItem({
  required String name,
  required int quantity,
  required Category category,
}) async {
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': name,
          'quantity': quantity,
          'category': category.title,
        },
      ),
    );

    final Map<String, dynamic> resData = json.decode(response.body);

    _newItem = GroceryItem(
      id: resData['name'],
      name: name,
      quantity: quantity,
      category: category,
    );

    shoppingData.addItem(_newItem);
  } catch (error) {
    shoppingData.removeItem(_newItem);
  }
}
