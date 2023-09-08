import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/categories.dart';
import 'models/grocery_item.dart';

class ShoppingData extends ChangeNotifier {
  List<GroceryItem> _shoppingList = [];
  List<GroceryItem> get shoppingList => _shoppingList;
  set value(List<GroceryItem> newShoppingList) {
    if (newShoppingList != shoppingList) {
      _shoppingList = newShoppingList;
      notifyListeners();
    }
  }

  Future _loadItems() async {
    final url = Uri.https(
        'shopping-helper-7f4f4-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');

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
    print(loadedItems);
  }
}
