import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:videotrade_app/models/videogame.dart';
import 'package:videotrade_app/providers/library_provider.dart';
// import 'package:videotrade_app/providers/videojuegos_provider.dart';
import 'package:videotrade_app/ui/widget/biblioteca/biblioteca_card.dart';
import 'package:videotrade_app/ui/widget/biblioteca/GameDetails.dart';

class BibliotecaTab extends StatefulWidget {
  const BibliotecaTab({super.key});

  @override
  State<BibliotecaTab> createState() => _BibliotecaTabState();
}

class _BibliotecaTabState extends State<BibliotecaTab> {
  late Future<void> _gameFuture;

  @override
  void initState(){
    super.initState();
    _gameFuture = Provider.of<LibraryProvider>(context, listen: false).loadDummyData();
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: _gameFuture,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        final games = Provider.of<LibraryProvider>(context).ownedgame;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Biblioteca'),
            actions: [
              Row(
                children: [    
                    //FALTA HACERLO FUNCIONAL
                  BottomAppBar(
                    child: Icon(Icons.more_vert, color: Colors.white,),
                    color: Colors.blueGrey.shade900,
        
                  )
                ],
              )
            ],
          ),
          body: Container(  
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
                  child: 
                    Text('  JUEGOS (${games.length})' , 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      )
                    ),
                ),
                Expanded(           
                  child: games.isEmpty
                      ? const Center(
                        child: Text('No hay juegos en la biblioteca'),
                      )
                      :ListView.separated(
                          padding: EdgeInsets.all(16),
                          itemCount: games.length,
                          separatorBuilder: (contex, index) => const SizedBox(height: 12),     
                          itemBuilder: (context , index){
                            final game = games[index];
                            return BibliotecaCard(
                              name: game.name, 
                              subtitle: '${game.genre} ',
                              imageUrl: game.imageUrl ?? ' ', 
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> GameDetails(gameId: '1'))
                                );
                              }
                            );
                          }, 
                        )

                )
              ],
            ),
          ),
        );
      }
    );
  }
}


