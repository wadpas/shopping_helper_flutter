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

  Future<void> addProduct(name, quantity, category) async {
    isLoading = true;
    notifyListeners();

    Product newProduct = await saveProduct(name, quantity, category);
    _productList.add(newProduct);
    isLoading = false;
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    isLoading = true;
    notifyListeners();

    await deleteProduct(product);
    _productList.remove(product);
    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleActive(Product product) async {
    isLoading = true;
    notifyListeners();

    await changeActive(product);
    product.isActive = !product.isActive;
    isLoading = false;
    notifyListeners();
  }
}

Future loadProducts() async {
  try {
    final response = await http.get(
      Uri.https(database, 'shopping-list.json'),
    );
    await Future.delayed(Durations.extralong1);
    final Map<String, dynamic> listData = json.decode(response.body);

    final List<Product> loadedProducts = [];
    for (final product in listData['products'].entries) {
      loadedProducts.add(
        Product(
          id: product.key,
          name: product.value['name'],
          quantity: product.value['quantity'],
          category: product.value['category'],
          isActive: product.value['isActive'],
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
  } catch (error) {
    print(error);
  }
}

Future saveProduct(name, quantity, category) async {
  try {
    final response = await http.post(
      Uri.https(database, 'shopping-list/products.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': name,
          'quantity': quantity,
          'category': category,
          'isActive': true,
        },
      ),
    );

    await Future.delayed(Durations.extralong1);

    final Map<String, dynamic> responseData = json.decode(response.body);

    _product = Product(
      id: responseData['name'],
      name: name,
      quantity: quantity,
      category: category,
      isActive: true,
    );

    return _product;
  } catch (error) {
    print(error);
  }
}

Future<void> deleteProduct(Product product) async {
  try {
    await http.delete(
      Uri.https(database, 'shopping-list/products/${product.id}.json'),
    );
    await Future.delayed(Durations.extralong1);
  } catch (error) {
    print(error);
  }
}

Future<void> changeActive(Product product) async {
  try {
    var j = {'isActive': false};
    var r = await http.patch(
      Uri.https(database, 'shopping-list/products/${product.id}.json'),
      body: jsonEncode(
        {'isActive': !product.isActive},
      ),
    );
    await Future.delayed(Durations.extralong1);
  } catch (error) {
    print(error);
  }
}
