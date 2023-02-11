import 'package:flutter/material.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';

class WishListProvider with ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getWishItems {
    return _list;
  }

  int get count {
    return _list.length;
  }

  void addWishItems(
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

  void removeWishItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearIWishtems() {
    _list.clear();
    notifyListeners();
  }

  void removeThis(String id) {
    _list.removeWhere((prod) => prod.documentId == id);
    notifyListeners();
  }
}
