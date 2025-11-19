import 'package:flutter/material.dart';
import 'package:videotrade_app/models/genero.dart';
import 'package:videotrade_app/providers/genero_provider.dart';

class GenerosCard extends StatefulWidget {
  const GenerosCard({super.key});

  @override
  State<GenerosCard> createState() => _GenerosCardState();
}

class _GenerosCardState extends State<GenerosCard> {
  final GenerosProvider provider = GenerosProvider();
  late Future<List<Genero>> _generosFuture;

  @override
  void initState(){
    super.initState();
    _generosFuture = provider.getGeneros();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Genero>>(
      future: _generosFuture,
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if(snapshot.hasError){
          return SizedBox(
            height: 120,
            child: Center(child: Text('Error: ${snapshot.error}'),),
          );
        }
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        
        final List<Genero> generos = snapshot.data!;

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: generos.length,
            itemBuilder: (context, index) {
              final Genero genero = generos[index];

              return SizedBox(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      genero.nombre,
                      style: TextStyle(color:Colors.white),
                      overflow: TextOverflow.ellipsis,
                    )
                    
                  ],
                ),
              ); 
            },
          ),
        );
      }
    );
  }
}