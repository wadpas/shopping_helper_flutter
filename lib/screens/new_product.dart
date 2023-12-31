import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_helper_flutter/models/product.dart';

import 'package:shopping_helper_flutter/providers/app_provider.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = '';

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<AppProvider>()
          .addProduct(
            _enteredName,
            _enteredQuantity,
            _selectedCategory,
          )
          .then(
            (_) => Navigator.of(context).pop(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New product'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          List<String> categories = value.categoryList;
          _selectedCategory = categories[0];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 3 ||
                          value.trim().length > 50) {
                        return 'Must be betwen 1 and 50 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredName = value!;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Quantity'),
                          ),
                          initialValue: _enteredQuantity.toString(),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return 'Must be betwen 1 and 50 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredQuantity = int.parse(value!);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField(
                          value: _selectedCategory,
                          items: [
                            for (final category in categories)
                              DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.reset();
                        },
                        child: const Text('Reset'),
                      ),
                      value.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _saveProduct,
                              child: const Text('Add product'),
                            )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
