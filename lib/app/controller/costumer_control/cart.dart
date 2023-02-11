import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  int get count {
    return _list.length;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
  }

  Future<void> addItems(
    String name,
    double price,
    int qty,
    int qtty,
    List imageUrl,
    String documentId,
    String suppId,
  ) async {
    final product = Product(
      name: name,
      price: price,
      qtty: qtty,
      qty: qty,
      documentId: documentId,
      imageUrl: imageUrl,
      suppId: suppId,
    );
    _list.add(product);
    notifyListeners();
  }

  void increment(Product product) {
    product.quantiyIncrease();
    notifyListeners();
  }

  void reduceByOne(Product product) {
    product.quantiyDecrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearItems() {
    _list.clear();
    notifyListeners();
  }
}

class Product {
  String name;
  double price;
  int qty = 1;
  int qtty;
  List imageUrl;
  String documentId;
  String suppId;

  Product({
    required this.name,
    required this.price,
    required this.qtty,
    required this.qty,
    required this.documentId,
    required this.imageUrl,
    required this.suppId,
  });
  void quantiyIncrease() {
    qty++;
  }

  void quantiyDecrease() {
    qty--;
  }
}
