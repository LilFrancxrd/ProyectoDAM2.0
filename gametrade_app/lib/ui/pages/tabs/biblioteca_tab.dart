import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/providers/library_provider.dart';
import 'package:videotrade_app/ui/widget/biblioteca/biblioteca_card.dart';
import 'package:videotrade_app/ui/widget/biblioteca/GameDetails.dart';

class BibliotecaTab extends StatefulWidget {
  const BibliotecaTab({super.key});

  @override
  State<BibliotecaTab> createState() => _BibliotecaTabState();
}

class _BibliotecaTabState extends State<BibliotecaTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLibrary();
    });
  }

  Future<void> _loadLibrary() async {
    try {
      await context.read<LibraryProvider>().fetchLibrary();
    } catch (e) {
      print('❌ Error cargando biblioteca: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Biblioteca'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLibrary,
            tooltip: 'Recargar',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Menú de opciones
            },
          ),
        ],
      ),
      body: Consumer<LibraryProvider>(
        builder: (context, libraryProvider, child) {
          // Estado de carga
          if (libraryProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              ),
            );
          }

          // Error
          if (libraryProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      libraryProvider.error!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadLibrary,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          // ✅ USAR libraryGames EN LUGAR DE ownedgame
          final games = libraryProvider.libraryGames;

          return Column(
            children: [
              // Header con contador
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                color: Colors.blueGrey.shade800,
                child: Row(
                  children: [
                    const Icon(
                      Icons.videogame_asset,
                      color: Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'JUEGOS (${games.length})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de juegos
              Expanded(
                child: games.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_books,
                              size: 64,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Tu biblioteca está vacía',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Compra juegos en la tienda',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadLibrary,
                        color: const Color(0xFF3B82F6),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: games.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final game = games[index];

                            return BibliotecaCard(
                              name: game.nombre, // ✅ Usar game.nombre
                              subtitle: game.genre, // ✅ Usar game.genre
                              imageUrl: game.images.isNotEmpty ? game.images.first : '',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetails(game: game), // ✅ Ahora sí es Videogame
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}