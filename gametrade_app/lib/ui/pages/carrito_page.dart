import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:videotrade_app/models/cart.dart';
import 'package:videotrade_app/providers/cart_provider.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({super.key});
  

  Future<void> _realizarCompra(BuildContext context, CartProvider cart) async {
    try {
      // 1. Obtener usuario y token de Firebase
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario no autenticado')),
        );
        return;
      }
      
      String? token = await user.getIdToken();



      var itemsParaAPI = cart.items.values.map((item) => {
        "videogame_id": item.id,  
        "price": item.precio
      }).toList();



      // Llamar a la API Laravel
      var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/sales/checkout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'items': itemsParaAPI,
        }),
      );

 

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Limpiar el carrito
        cart.clear();
        
        // Opcional: Navegar a la biblioteca
        // Navigator.pushNamed(context, '/library');
        
      } else {
        // Manejar error
        var errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${errorData['message'] ?? 'Error en la compra'}'),
            backgroundColor: Colors.red,
          ),
        );
      }

    } catch (e) {
 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                
                final imageUrl = item.imageUrl.isNotEmpty 
                        ? item.imageUrl
                        : 'https://via.placeholder.com/60x60/2d3748/ffffff?text=Sin+Img';

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
      
                  _realizarCompra(context, cart);
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