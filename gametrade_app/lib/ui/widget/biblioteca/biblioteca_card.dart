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
    super.key, 
    required this.onTap
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
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blueGrey.shade600,
            width: 1
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGEN - CORREGIDA
            AspectRatio(    
              aspectRatio: 16/9,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: _buildImage(),
              ),
            ),
            const SizedBox(height: 5),

            // TITULO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 3.0),

            // GENEROS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Si hay imagen URL, mostrarla
    if (imageUrl.isNotEmpty) {
      print('🖼️ Cargando imagen: $imageUrl'); // Debug
      return Image.network(
        'http://10.0.2.2:8000/$imageUrl', // ← Para Android emulator
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error cargando imagen: $error'); // Debug
          return _buildPlaceholder();
        },
      );
    }
    
    // Si no hay imagen, mostrar placeholder
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Icon(
          Icons.videogame_asset, 
          size: 40, 
          color: Colors.lightBlueAccent
        ),
      ),
    );
  }
}