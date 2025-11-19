import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/providers/library_provider.dart';
import 'package:videotrade_app/providers/user_provider.dart';
import 'package:videotrade_app/ui/widget/perfil/stat_card.dart';

class PerfilTab extends StatefulWidget {
  const PerfilTab({super.key});

  @override
  State<PerfilTab> createState() => _PerfilTabState();
}

class _PerfilTabState extends State<PerfilTab> {
  late Future<void> _userFuture;

  @override
  void initState(){
    super.initState();
    _userFuture = Provider.of<UserProvider>(context,listen: false).loadDummyData();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }

        final user = Provider.of<UserProvider>(context).currentUser;
        //Valida que user no sea null, sino flutter detecta error
        if(user == null){
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Perfil'),
          ),
        
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [    

                    //AVATAR 

                    CircleAvatar(
                      
                      radius: 60,
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),

                    //NOMBRE USUARIO

                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 8),

                    //ANTIGUEDAD

                    Text(
                      'Usuario desde ${user.membersince.month}/${user.membersince.year}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 8),

                    //ESTADISTICAS

                    Consumer<LibraryProvider>(
                      builder: (context, libraryProvider, child){
                        final games = libraryProvider.ownedgame;
                        final totalGames = games.length;
                        final totalHours = games.fold(0 , (sum, game) => sum + game.hoursplayed);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StatCard(value: '$totalGames', label: 'Total Juegos'),
                            SizedBox(width: 5),
                            StatCard(value: '$totalHours', label: 'Horas jugadas'),
                            SizedBox(width: 5),
                            StatCard(value: '85%', label: 'Completados' )
                          ],
                        );
                      },
                    ),

                    //INVENTARIO
                    Consumer<LibraryProvider>(
                      builder: (context , libraryProvider , child) {
                        final games = libraryProvider.ownedgame; 

                        return Column(
                          children: [
                            SizedBox(height: 12),
                            Container(
                              child: Text(
                                'Inventario',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                                ),
                              ),
                            ),

                            SizedBox(height: 12),

                            Container(
                    
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blueGrey
                              ),
                              child: DataTable(
                  
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'JUEGO',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'GENERO',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'HORAS',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  )
                                ], 
                                rows: games.map((game) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(game.name, style: TextStyle(color: Colors.white),)
                                      ),
                                    DataCell(
                                      Text(game.genre, style: TextStyle(color: Colors.white),)
                                      ),
                                    DataCell(
                                      Text('${game.hoursplayed}h', style: TextStyle(color: Colors.white),))
                                  ]
                                  )).toList()
                              ),
                            )

                          ],
                        );
                      }
                    )  
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

