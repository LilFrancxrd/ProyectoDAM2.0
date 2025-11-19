import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/models/cart.dart';
import 'package:videotrade_app/providers/cart_provider.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    print('ENTRAAAAAA');
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu carrito'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                'Tu carrito está vacío',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            )
          : ListView(
              children: cart.items.values.map((item) {
                print('Item: ${item.nombre}');
                print('Image URL: "${item.imageUrl}"');
                print('URL vacía: ${item.imageUrl.isEmpty}');
                print('URL es null: ${item.imageUrl == 'null'}');
                  // Suponemos que tu CartItem ahora tiene un campo imageUrl
                // Si no lo tiene, podrías agregarlo al hacer addItem
                final imageUrl = item.imageUrl.isNotEmpty 
                        ? item.imageUrl
                        : 'https://via.placeholder.com/60x60/2d3748/ffffff?text=Sin+Img'; // fallback

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey,
                            child: Icon(Icons.videogame_asset,color: Colors.grey,),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      item.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      '\$${item.precio % 1 == 0 ? item.precio.toInt() : item.precio.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        cart.removeItem(item.id);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.blueGrey.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Compra realizada'),
                    ),
                  );
                  cart.clear();
                },
                child: Text(
                  'Comprar todo (${cart.itemCount} artículos - \$${cart.precioTotal % 1 == 0 ? cart.precioTotal.toInt() : cart.precioTotal.toStringAsFixed(2)})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
    );
  }
}
