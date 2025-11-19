import 'package:flutter/foundation.dart';
import 'package:videotrade_app/models/cart.dart';


class CartProvider extends ChangeNotifier {
  final Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => {..._items};

  int get itemCount => _items.length;

  double get precioTotal {
    return _items.values.fold(0.0, (sum, item) => sum + item.precio);
  }

  void addItem(int id, String nombre, double precio, String imageUrl) {
    if (!_items.containsKey(id)) {
      _items[id] = CartModel(
        id: id,
        nombre: nombre,
        precio: precio,
        imageUrl: imageUrl,
      );
    }
    notifyListeners();
  }

  void removeItem(int id) {
    if (!_items.containsKey(id)) return;
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
