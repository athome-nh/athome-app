// models/cart_item.dart

class CartItemPast {
  int product;
  int quantity;

  CartItemPast({
    required this.product,
    this.quantity = 1,
  });
  factory CartItemPast.fromMap(Map<String, dynamic> data) => CartItemPast(
        product: data['product']!,
        quantity: data['quantity']!,
      );
}
