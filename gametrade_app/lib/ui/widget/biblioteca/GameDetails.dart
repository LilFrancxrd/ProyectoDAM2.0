import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/ui/widget/buttons.dart';
import 'package:videotrade_app/ui/widget/biblioteca/imageCard.dart';
import 'package:videotrade_app/ui/widget/perfil/stat_card.dart';
// Importa tu provider de videojuegos

class GameDetails extends StatefulWidget {
  final String gameId; // ID del juego que viene de la API
  
  const GameDetails({super.key, required this.gameId});
  
  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  bool isLoading = true;
  Map<String, dynamic>? gameData;

  
  @override
  void initState() {
    super.initState();
    _loadGameData();
  }
  
  // Cargar datos del juego desde la API
  Future<void> _loadGameData() async {
    try {
      // TODO: Reemplaza esto con tu servicio real
      // final data = await context.read<VideoJuegosProvider>().getGameById(widget.gameId);
      

      setState(() {
        gameData = {
          'title': 'Grand Theft Auto V',
          'imageUrl': 'https://media.rockstargames.com/rockstargames/img/global/news/upload/13_gtavpc_03272015.jpg',
          'genre': 'Acción • Mundo Abierto',
          'intercambios': 0,
          'intercambiosMaximos': 5,
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

    if(gameData == null){
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(child: CircularProgressIndicator()),
      );
    }    
    print('ENTROOOO BIBLIOTECA DETALLE');
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
          
          //IMAGEN
          SizedBox(
            height: 500,
            child: ImageCard(),
          ),  
          
          // ESTADISTICAS

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatCard(value: '45h', label: 'Horas Juagdas'),
              SizedBox(width: 10),
              StatCard(value: '85%', label: 'Completado'),
              SizedBox(width: 10),
              StatCard(value: '20', label: 'Total Logros'),
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

                  //BOTON JUGAR
                  Boton(
                    label: 'Jugar Ahora', 
                    fontColor: Colors.white,
                    icono: Icon(Icons.play_arrow), 
                    gradient: LinearGradient(colors: [Colors.lightBlueAccent , Colors.lightBlue]), 
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Iniciando GTA V'),
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

                  //BOTON DESINSTALAR
                  Boton(
                    label: 'Desinstalar' , 
                    // color: Colors.red, 
                    gradient: LinearGradient(colors: [const Color.fromARGB(251, 244, 13, 13) , const Color.fromARGB(255, 190, 15, 2)]),
                    fontColor: Colors.white,
                    icono: Icon(Icons.delete),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Desinstalando..'),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12)
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