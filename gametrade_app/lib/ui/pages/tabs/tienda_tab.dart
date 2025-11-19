import 'package:provider/provider.dart';
import 'package:videotrade_app/models/videogame.dart';
import 'package:videotrade_app/providers/cart_provider.dart';
import 'package:videotrade_app/providers/videojuegos_provider.dart';
import 'package:videotrade_app/providers/ofertas_provider.dart'; 
import 'package:videotrade_app/ui/pages/carrito_page.dart';
import 'package:videotrade_app/ui/widget/tienda/game_card.dart';
import 'package:videotrade_app/models/cart.dart';
import 'package:flutter/material.dart';


import 'package:videotrade_app/ui/widget/tienda/generos_card.dart';
import 'package:videotrade_app/ui/widget/tienda/ofertas_card.dart';

class TiendaTab extends StatefulWidget {
  const TiendaTab({super.key});

  @override
  State<TiendaTab> createState() => _TiendaTabState();
}

class _TiendaTabState extends State<TiendaTab> {
  late Future<List<Videogame>> videojuegosFuture;
  VideojuegosProvider juegosProvider = VideojuegosProvider();
  
  @override
  void initState(){
    super.initState();
    videojuegosFuture = juegosProvider.fetchVideogames();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OfertasProvider>(context, listen: false).cargarOfertas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Videogame>>(
      future: videojuegosFuture, 
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text('No hay videojuegos disponibles'));
        } else{
          final videojuegos = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.account_circle),
              title: Text('TIENDA BKN'),
              actions: [
                Row(
                  children: [
                    Icon(Icons.notifications_none_outlined),
                    SizedBox(width: 10),
                    Icon(Icons.settings)
                  ],
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_right_alt, color: Colors.white),
                      Text(
                        '  Generos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        ),
                      ),
                    ],
                  ),
                ),
                GenerosCard(),

                Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text(
                            '  Ofertas',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white
                            ),
                          ),
                          Icon(Icons.arrow_right_alt, color: Colors.white)
                        ],
                      ),
                    ),
                    
                    Consumer<OfertasProvider>(
                      builder: (context, ofertasProvider, child) {
                        if (ofertasProvider.loading) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        
                        if (ofertasProvider.error != null) {
                          return Container(
                            height: 80,
                            child: Center(
                              child: Text(
                                'Error: ${ofertasProvider.error}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        
                        if (ofertasProvider.ofertas.isEmpty) {
                          return Container(
                            height: 80,
                            child: Center(
                              child: Text(
                                'No hay ofertas disponibles',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        
                        return Container(
                          height: 210,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ofertasProvider.ofertas.length,
                            itemBuilder: (context, index) {
                              final oferta = ofertasProvider.ofertas[index];
                              return Container(
                                width: 280,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: OfertasCard(oferta: oferta),
                              );
                            },
                          ),
                        );
                      },
                    ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text(
                        '  Juegos Populares', 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        ),
                      ),
                      Icon(Icons.arrow_right_alt_outlined, color: Colors.white)
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: videojuegos.length,
                    itemBuilder: (context, index){
                      final juego = videojuegos[index];
                      return GameCard(
                        id: juego.id,
                        title: juego.nombre, 
                        imageUrl: juego.images.isNotEmpty 
                          ? juego.images.first
                          : 'https://via.placeholder.com/400x225?text=No+Image', 
                        price: juego.precio,
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey.shade800,
              foregroundColor: Colors.lightBlueAccent,
              elevation: 6,
              icon: const Icon(Icons.shopping_cart),
              label: Consumer<CartProvider>(
                builder: (context, cart, child){
                  return Text(
                    'Carrito (${cart.itemCount})', 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CarritoPage()));
              },
            ),
          );
        }
      }
    );
  }
}