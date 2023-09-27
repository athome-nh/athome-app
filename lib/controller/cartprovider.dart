import 'dart:convert';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() {
    // When the CartProvider is created, load cart data from shared preferences.
    loadCartFromPreferences();
    loadFavCartFromPreferences();
  }
  List<CartItem> cartItems = [];
  List<CartItem> FavItems = [];

  void addToCart(CartItem cartItem) {
    // Check if the item already exists in the cart
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product == cartItem.product,
    );

    if (existingItemIndex != -1) {
      // If the item exists, update the quantity
      cartItems[existingItemIndex].quantity += cartItem.quantity;
    } else {
      // If the item doesn't exist, add it to the cart
      cartItems.add(cartItem);
    }

    saveCartToPreferences(cartItems, "cartData");
    notifyListeners();
  }

  void addFavToCart(CartItem cartItem) {
    // Check if the item already exists in the cart
    final existingItemIndex = FavItems.indexWhere(
      (item) => item.product == cartItem.product,
    );

    if (existingItemIndex != -1) {
      // If the item exists, update the quantity
      FavItems.remove(FavItems[existingItemIndex]);
    } else {
      // If the item doesn't exist, add it to the cart
      FavItems.add(cartItem);
    }

    saveCartToPreferences(FavItems, "Fav");
    notifyListeners();
  }

  bool itemExistsInCart(ProductModel product) {
    // Check if the item already exists in the cart based on a unique identifier (e.g., product ID)
    return cartItems.any((item) => item.product == product.id);
  }

  bool FavExistsInCart(ProductModel product) {
    // Check if the item already exists in the cart based on a unique identifier (e.g., product ID)
    return FavItems.any((item) => item.product == product.id);
  }

  void saveCartToPreferences(List<CartItem> cartItems, String name) async {
    final cartData = cartItems.map((item) {
      return {
        'product': item.product,
        'quantity': item.quantity,
      };
    }).toList();
    var jsonData = json.encode(cartData);
    setStringPrefs(name, encryptAES(jsonData));
  }

  List<int> ListId() {
    List<int> cardIDs = [];

    cartItems.forEach((element) {
      cardIDs.add(element.product);
    });
    return cardIDs;
  }

  List<int> ListFavId() {
    List<int> cardIDs = [];

    FavItems.forEach((element) {
      cardIDs.add(element.product);
    });
    return cardIDs;
  }

  loadCartFromPreferences() {
    getStringPrefs('cartData').then((value) {
      var jsonList = jsonDecode(decryptAES(value));

      List<CartItem> cart =
          (jsonList as List).map((x) => CartItem.fromMap(x)).toList();

      cartItems = cart;
      notifyListeners();
    });
  }

  loadFavCartFromPreferences() {
    getStringPrefs('Fav').then((value) {
      var jsonList = jsonDecode(decryptAES(value));

      List<CartItem> cart =
          (jsonList as List).map((x) => CartItem.fromMap(x)).toList();

      FavItems = cart;
      notifyListeners();
    });
  }

  int calculateQuantityForProduct(int productId) {
    int totalQuantity = 0;

    for (var cartItem in cartItems) {
      if (cartItem.product == productId) {
        totalQuantity += cartItem.quantity;
      }
    }

    return totalQuantity;
  }

  double calculateTotalPrice(List<ProductModel> product) {
    double totalPrice = 0.0;
    int i = 0;
    for (var cartItem in cartItems) {
      totalPrice += product[i].price! * cartItem.quantity;
    }

    return totalPrice;
  }

  void clearCart() {
    cartItems.clear();

    saveCartToPreferences(cartItems, "cartData");
    notifyListeners(); // Notify listeners when the cart is cleared
  }

  void deleteitem(int id) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product == id,
    );
    cartItems.remove(cartItems[existingItemIndex]);
    saveCartToPreferences(cartItems, "cartData");
    notifyListeners(); // Notify listeners when the cart is cleared
  }

  void removeFromCart(CartItem cartItem) {
    // Check if the item already exists in the cart
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product == cartItem.product,
    );

    if (existingItemIndex != -1) {
      if (cartItems[existingItemIndex].quantity == 1) {
        cartItems.remove(cartItems[existingItemIndex]);
      } else {
        // If the item exists, update the quantity
        cartItems[existingItemIndex].quantity -= 1;
      }
    } else {
      // If the item doesn't exist, add it to the cart
      cartItems.remove(cartItem);
    }
    saveCartToPreferences(cartItems, "cartData");
    notifyListeners();
  }
}
