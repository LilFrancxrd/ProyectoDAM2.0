import 'package:flutter/material.dart';

class BibliotecaCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onTap;

  const BibliotecaCard({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    super.key, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
      width: double.infinity,
    
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color:Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:Colors.blueGrey.shade600,
          width: 1
        )
      ),
        child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
          children: [

            //IMAGEN

            AspectRatio(    
      
              aspectRatio: 16/9,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.directional(topStart: Radius.circular(12)),
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Icon(Icons.videogame_asset , size: 40 , color: Colors.lightBlueAccent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            //TITULO

            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3.0),

            //GENEROS

            Text(
              subtitle,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white
              ),
              overflow: TextOverflow.ellipsis
            )
          ],
        ),
      ),
    );
  }
}