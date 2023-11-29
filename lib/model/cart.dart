// models/cart_item.dart

class CartItem {
  int product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
  factory CartItem.fromMap(Map<String, dynamic> data) => CartItem(
        product: data['product']!,
        quantity: data['quantity']!,
      );
}
