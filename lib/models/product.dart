class Product {
  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.isActive,
  });

  String id;
  final String name;
  final int quantity;
  final String category;
  bool isActive;
}
