import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/models/cart.dart';
import 'package:videotrade_app/providers/cart_provider.dart';

class GameCard extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final double price;


  const GameCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final bool enCarrito = cart.items.containsKey(id);


    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del videojuego
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                errorBuilder:(context, error, stackTrace) {
                    return Container(
                      height: 200, // Ajusta según tu diseño
                      color: Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Imagen no disponible', style: TextStyle(fontSize: 12)),
                        ],
                      ) 
                    ) ;
                },
                fit: BoxFit.cover,
              ),
            ),

            // Contenido textual
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '\$${price % 1 == 0 ? price.toInt() : price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 12),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if (enCarrito){
                          cart.removeItem(id);
                        } else{
                          cart.addItem(id, title, price, imageUrl);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: 
                        
                            enCarrito ? Colors.redAccent.shade400 : Colors.lightBlueAccent,
                            foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      
                      child: Text(
                        enCarrito ? 'Quitar del carrito' :                      'Agregar al carrito',
                        style: const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 14,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
