import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/providers/library_provider.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({super.key});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool isLoading = true;
  Map<String, dynamic>? gameData;
  late Future <void>_gamesFuture;

  @override
  void initState(){
    super.initState();
    _gamesFuture = Provider.of<LibraryProvider>(context , listen: false).loadDummyData();
    _loadGameData();
  }

  Future<void>_loadGameData() async {
    try{

      setState(() {
     
        gameData = {
          'title' : 'Grand Theft Auto V',
          'imageUrl': 'https://media.rockstargames.com/rockstargames/img/global/news/upload/13_gtavpc_03272015.jpg',
          'genre' : 'Accion - Mundo Abierto'
        };
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar el juego: $e')),
        );
      }
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    if (gameData == null){
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: CircularProgressIndicator(),
      );
    }

    return
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              
              // Imagen principal
              Image.network(
                gameData!['imageUrl'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      color: Colors.black,
                      child: const Icon(
                        Icons.broken_image_rounded,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
              ),
              
              // Gradient overlay para mejor legibilidad
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Título con efecto glassmorphism
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                
            
                child: Container(
    
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              gameData!['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              gameData!['genre'] ?? 'Acción',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}