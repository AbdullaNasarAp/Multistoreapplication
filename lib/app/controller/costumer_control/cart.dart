import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  int get count {
    return _list.length;
  }

  void addItems(
    String name,
    double price,
    int qty,
    int qtty,
    List imageUrl,
    String documentId,
    String suppId,
  ) {
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
}
