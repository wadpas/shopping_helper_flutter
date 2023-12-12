import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_helper_flutter/providers/constants.dart';
import '../models/product.dart';

late Product _product;

var aa = AppProvider();

class AppProvider extends ChangeNotifier {
  List<String> _categoryList = [];
  List<Product> _productList = [];
  bool isLoading = false;

  List<Product> get productList => _productList;
  List<String> get categoryList => _categoryList;

  Future<void> fetchData() async {
    isLoading = true;

    Map loadedData = await loadProducts();
    _productList = loadedData['products'];
    _categoryList = loadedData['categories'];

    print('object');
    isLoading = false;
    notifyListeners();
  }
}

class ShoppingData extends ChangeNotifier {
  List<Product> _shoppingList = [];

  List<Product> get shoppingList => _shoppingList;

  set shoppingList(List<Product> newShoppingList) {
    if (newShoppingList != shoppingList) {
      _shoppingList = newShoppingList;
      notifyListeners();
    }
  }

  void addProduct(Product product) {
    _shoppingList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _shoppingList.remove(product);
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

  static List<Product> of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<ShoppingInheritedNotifier>()
          ?.notifier
          ?.shoppingList ??
      [];
}

var categories = [];

Future<Map> loadProducts() async {
  final response = await http.get(
    Uri.https(database, 'shopping-list.json'),
  );
  await Future.delayed(Durations.extralong3);
  final Map<String, dynamic> listData = json.decode(response.body);

  final List<Product> loadedProducts = [];
  for (final product in listData['products'].entries) {
    loadedProducts.add(
      Product(
        id: product.key,
        name: product.value['name'],
        quantity: product.value['quantity'],
        category: product.value['category'],
      ),
    );
  }

  final List<String> loadedCategories = [];
  for (final category in listData['categories'].entries) {
    loadedCategories.add(category.key);
  }

  return {
    'products': loadedProducts,
    'categories': loadedCategories,
  };
}

Future<void> addProduct({
  required String name,
  required int quantity,
  required String category,
}) async {
  try {
    final response = await http.post(
      Uri.https(database, 'shopping-list/products.json'),
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

    _product = Product(
      id: resData['name'],
      name: name,
      quantity: quantity,
      category: category,
    );

    shoppingData.addProduct(_product);
  } catch (error) {
    shoppingData.removeProduct(_product);
  }
}

Future<void> removeProduct(Product product) async {
  _product = product;
  try {
    final response = await http.delete(
      Uri.https(
          'comon-database-8a85d-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping-list/${product.id}.json'),
    );
    shoppingData.removeProduct(product);
    if (response.statusCode >= 400) {
      shoppingData.addProduct(_product);
      return;
    }
  } catch (error) {
    shoppingData.addProduct(_product);
  }
}
