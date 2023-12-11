import 'package:flutter/material.dart';
import 'package:shopping_helper_flutter/providers/app_provider.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Helper"),
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
                  return Dismissible(
                    onDismissed: (direction) {
                      removeItem(ShoppingInheritedNotifier.of(context)[index]);
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
                          color: Colors.amber,
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
