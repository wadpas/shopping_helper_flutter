import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/grocery_item.dart';

final url = Uri.https(
    'comon-database-8a85d-default-rtdb.europe-west1.firebasedatabase.app',
    'shopping-list.json');
late GroceryItem _groceryItem;

class AppProvider extends ChangeNotifier {
  List<String> categoryList = [];
}

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
    super.key,
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

final List<String> categories = [];
Future<List<GroceryItem>> loadItems() async {
  final response = await http.get(url);

  if (response.statusCode == 400) {
    throw Exception('Failed to fetch data');
  }

  if (response.body == 'null') {
    return [];
  }

  final Map<String, dynamic> listData = json.decode(response.body);

  for (final category in listData['categories'].entries) {
    categories.add(category.key);
  }

  final List<GroceryItem> loadedItems = [];

  for (final item in listData['items'].entries) {
    loadedItems.add(
      GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: item.value['category'],
      ),
    );
  }
  shoppingData.shoppingList = loadedItems;
  return loadedItems;
}

Future<void> addItem({
  required String name,
  required int quantity,
  required String category,
}) async {
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': name,
          'quantity': quantity,
          'category': category,
        },
      ),
    );

    final Map<String, dynamic> resData = json.decode(response.body);

    _groceryItem = GroceryItem(
      id: resData['name'],
      name: name,
      quantity: quantity,
      category: category,
    );

    shoppingData.addItem(_groceryItem);
  } catch (error) {
    shoppingData.removeItem(_groceryItem);
  }
}

Future<void> removeItem(GroceryItem item) async {
  _groceryItem = item;
  try {
    final response = await http.delete(
      Uri.https(
          'comon-database-8a85d-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping-list/${item.id}.json'),
    );
    shoppingData.removeItem(item);
    if (response.statusCode >= 400) {
      shoppingData.addItem(_groceryItem);
      return;
    }
  } catch (error) {
    shoppingData.addItem(_groceryItem);
  }
}
