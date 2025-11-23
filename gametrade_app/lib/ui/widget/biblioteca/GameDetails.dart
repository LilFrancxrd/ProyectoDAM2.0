import 'package:flutter/material.dart';
import 'package:videotrade_app/ui/widget/buttons.dart';
import 'package:videotrade_app/ui/widget/biblioteca/imageCard.dart';
import 'package:videotrade_app/ui/widget/perfil/stat_card.dart';
import 'package:videotrade_app/models/videogame.dart';

class GameDetails extends StatefulWidget {
  final Videogame game;
  
  const GameDetails({super.key, required this.game});
  
  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  bool isLoading = false;
  String getFullImageUrl(String relativeUrl) {
    if (relativeUrl.isEmpty) return '';
    
    // Si ya es una URL completa, devolverla tal cual
    if (relativeUrl.startsWith('http')) {
      return relativeUrl;
    }
    
    // Si empieza con /, quitar el / inicial para evitar doble //
    if (relativeUrl.startsWith('/')) {
      relativeUrl = relativeUrl.substring(1);
    }
    
    // Construir URL completa con tu base URL
    return 'http://10.0.2.2:8000/$relativeUrl';
  }

  @override
  void initState() {
    super.initState();
    print('Cargando detalles de: ${widget.game.nombre}');
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // IMAGEN
          SizedBox(
            height: 500,
            child: ImageCard(
              imageUrl: game.images.isNotEmpty ? getFullImageUrl(game.images.first) : '', 
              gameName: game.nombre,
            ),
          ),
         
              
          
              
  
          
          // INFORMACIÓN DEL JUEGO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   game.nombre,
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 8),
                // Text(
                //   game.genre, // ✅ Usar game.genre directamente
                //   style: TextStyle(
                //     color: Colors.grey.shade300,
                //     fontSize: 16,
                //   ),
                // ),
                // SizedBox(height: 8),
                // if (game.descripcion.isNotEmpty) // ✅ Usar descripcion (con c)
                //   Text(
                //     game.descripcion, // ✅ Usar descripcion (con c)
                //     style: TextStyle(
                //       color: Colors.grey.shade400,
                //       fontSize: 14,
                //     ),
                //     maxLines: 3,
                //     overflow: TextOverflow.ellipsis,
                //   ),
              ],
            ),
          ),

          // ESTADÍSTICAS (si no tienes estos datos, puedes omitirlos o usar placeholders)
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatCard(value: '0h', label: 'Horas Jugadas'), // Placeholder
              SizedBox(width: 10),
              StatCard(value: '0%', label: 'Completado'), // Placeholder
              SizedBox(width: 10),
              StatCard(value: '0', label: 'Total Logros'), // Placeholder
            ],
          ),

          // BOTONES 
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // BOTON JUGAR
                  Boton(
                    label: 'Jugar Ahora', 
                    fontColor: Colors.white,
                    icono: Icon(Icons.play_arrow), 
                    gradient: LinearGradient(colors: [Colors.lightBlueAccent , Colors.lightBlue]), 
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Iniciando ${game.nombre}'),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                        )
                      );
                    }
                  ),
                  SizedBox(height: 10),

                  // BOTON DESINSTALAR
                  Boton(
                    label: 'Desinstalar', 
                    gradient: LinearGradient(colors: [
                      const Color.fromARGB(251, 244, 13, 13),
                      const Color.fromARGB(255, 190, 15, 2)
                    ]),
                    fontColor: Colors.white,
                    icono: Icon(Icons.delete),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Desinstalando ${game.nombre}...'),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),               
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}