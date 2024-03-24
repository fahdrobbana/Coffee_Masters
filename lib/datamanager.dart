import 'dart:convert';

import 'package:coffee_masters/datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List<dynamic>;
      _menu = json.map((c) => Category.fromJson(c)).toList();
    } else {
      throw Exception("Failed to load menu");
    }
  }

  Future<List<Category>?> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu;
  }

  cartAdd(Product p) {
    bool found = false;
    for (var item in cart) {
      if (item.product == p) {
        item.quantity++;
        found = true;
      }
    }
    if (!found) {
      cart.add(ItemInCart(product: p, quantity: 1));
    }
  }

  cartRemove(Product p) {
    for (var item in cart) {
      if (item.product == p) {
        item.quantity--;
        if (item.quantity == 0) {
          cart.remove(item);
        }
        break; // Exit loop after removing the item
      }
    }
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
