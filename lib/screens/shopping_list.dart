import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_helper_flutter/models/product.dart';
import 'package:shopping_helper_flutter/providers/app_provider.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AppProvider>().fetchData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Helper"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/new-product');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: value.productList.length,
                  itemBuilder: (ctx, index) {
                    List<Product> products = value.productList;
                    return Dismissible(
                      background: Container(
                        color: Colors.redAccent,
                      ),
                      onDismissed: (direction) {
                        deleteProduct(products[index]);
                      },
                      key: UniqueKey(),
                      child: ListTile(
                        title: Text(
                          products[index].name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 24,
                          height: 24,
                        ),
                        trailing: Text(
                          products[index].quantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
