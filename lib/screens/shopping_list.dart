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
          ),
          IconButton(
            onPressed: () {
              context.read<AppProvider>().signOut();
            },
            icon: const Icon(Icons.exit_to_app),
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
                    Product product = value.productList[index];
                    return Dismissible(
                      background: Container(
                        color: Colors.redAccent,
                      ),
                      onDismissed: (direction) {
                        deleteProduct(product);
                      },
                      key: UniqueKey(),
                      child: ListTile(
                        title: Text(
                          product.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            color:
                                product.isActive ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 24,
                          height: 24,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              product.quantity.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 32),
                            GestureDetector(
                              onTap: () => value.toggleActive(product),
                              child: product.isActive
                                  ? const Icon(
                                      Icons.circle_outlined,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.done,
                                      color: Colors.red,
                                    ),
                            )
                          ],
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
