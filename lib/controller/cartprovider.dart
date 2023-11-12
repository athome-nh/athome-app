import 'dart:convert';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';

import 'package:athome/landing/splash_screen.dart';

import 'package:athome/model/cart.dart';
import 'package:athome/model/cartpast.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() {
    loadCartFromPreferences(userdata["id"].toString());
    loadFavCartFromPreferences(userdata["id"].toString());
    // When the CartProvider is created, load cart data from shared preferences.
  }
  List<CartItem> cartItems = [];
  // ignore: non_constant_identifier_names
  List<CartItem> FavItems = [];
  List<CartItemPast> _cartItemsPast = [];
  List<CartItemPast> get cartItemsPast => _cartItemsPast;

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
    String id = userdata["id"].toString();
    saveCartToPreferences(cartItems, "Cart" + id);
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
    String id = userdata["id"].toString();
    saveCartToPreferences(FavItems, "Fav" + id);
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
    setStringPrefs(name, jsonData);
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

  loadCartFromPreferences(String id) {
    getStringPrefs("Cart" + id).then((value) {
      if (value != "") {
        var jsonList = jsonDecode(value);
        List<CartItem> cart =
            (jsonList as List).map((x) => CartItem.fromMap(x)).toList();

        cartItems = cart;

        notifyListeners();
      }
    });
  }

  loadFavCartFromPreferences(String id) {
    getStringPrefs("Fav" + id).then((value) {
      if (value != "") {
        var jsonList = jsonDecode(value);

        List<CartItem> cart =
            (jsonList as List).map((x) => CartItem.fromMap(x)).toList();

        FavItems = cart;
        notifyListeners();
      }
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

  int calculateTotalPrice(List<ProductModel> product) {
    int totalPrice = 0;
    int i = 0;
    for (var cartItem in cartItems) {
      if (checkOferPrice(product[i])) {
        totalPrice += product[i].offerPrice! * cartItem.quantity;
      } else if (product[i].price2! > -1) {
        totalPrice += product[i].price2! * cartItem.quantity;
      } else {
        totalPrice += product[i].price! * cartItem.quantity;
      }
      i++;
    }

    return totalPrice;
  }

  void clearCart() {
    cartItems.clear();
    String id = userdata["id"].toString();
    saveCartToPreferences(cartItems, "Cart" + id);
    notifyListeners(); // Notify listeners when the cart is cleared
  }

  void clearFav() {
    FavItems.clear();
    String id = userdata["id"].toString();
    saveCartToPreferences(FavItems, "Fav" + id);
    notifyListeners(); // Notify listeners when the cart is cleared
  }

  void deleteitem(int id) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.product == id,
    );
    cartItems.remove(cartItems[existingItemIndex]);
    String id2 = userdata["id"].toString();
    saveCartToPreferences(cartItems, "Cart" + id2);
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
    String id = userdata["id"].toString();
    saveCartToPreferences(cartItems, "Cart" + id);
    notifyListeners();
  }

//Past order funcyions
  void addPastToCart(List<CartItemPast> cartItem) {
    cartItem.forEach((element) {
      final cartItem = CartItem(
        product: element.product,
        quantity: element.quantity,
      );
      addToCart(cartItem);
    });

    notifyListeners();
  }

  void addToCartPast(CartItemPast cartItem) {
    // Check if the item already exists in the cart
    final existingItemIndex = _cartItemsPast.indexWhere(
      (item) => item.product == cartItem.product,
    );

    if (existingItemIndex != -1) {
      // If the item exists, update the quantity
      _cartItemsPast[existingItemIndex].quantity += cartItem.quantity;
    } else {
      // If the item doesn't exist, add it to the cart
      _cartItemsPast.add(cartItem);
    }

    notifyListeners();
  }

  void clearCartPast() {
    cartItemsPast.clear();

    notifyListeners(); // Notify listeners when the cart is cleared
  }

  void deleteitemPast(int id) {
    final existingItemIndex = cartItemsPast.indexWhere(
      (item) => item.product == id,
    );
    cartItemsPast.remove(cartItemsPast[existingItemIndex]);
    notifyListeners(); // Notify listeners when the cart is cleared
  }

  void removeFromCartPast(CartItemPast cartItem) {
    // Check if the item already exists in the cart
    final existingItemIndex = cartItemsPast.indexWhere(
      (item) => item.product == cartItem.product,
    );

    if (existingItemIndex != -1) {
      if (cartItemsPast[existingItemIndex].quantity == 1) {
        cartItemsPast.remove(cartItemsPast[existingItemIndex]);
      } else {
        // If the item exists, update the quantity
        cartItemsPast[existingItemIndex].quantity -= 1;
      }
    } else {
      // If the item doesn't exist, add it to the cart
      cartItemsPast.remove(cartItem);
    }

    notifyListeners();
  }

  int calculateQuantityForProductPast(int productId) {
    int totalQuantity = 0;

    for (var cartItem in cartItemsPast) {
      if (cartItem.product == productId) {
        totalQuantity += cartItem.quantity;
      }
    }

    return totalQuantity;
  }

  int calculateTotalPricePast(List<ProductModel> product) {
    int totalPrice = 0;
    int i = 0;
    for (var cartItem in cartItemsPast) {
      if (checkOferPrice(product[i])) {
        totalPrice += product[i].offerPrice! * cartItem.quantity;
      } else if (product[i].price2! > -1) {
        totalPrice += product[i].price2! * cartItem.quantity;
      } else {
        totalPrice += product[i].price! * cartItem.quantity;
      }
      i++;
    }

    return totalPrice;
  }

  List<int> ListIdPast() {
    List<int> cardIDs = [];

    cartItemsPast.forEach((element) {
      cardIDs.add(element.product);
    });
    return cardIDs;
  }
}
