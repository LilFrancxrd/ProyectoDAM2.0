import 'package:flutter/material.dart';
import 'package:videotrade_app/models/offers.dart';

class OfertasCard extends StatefulWidget {
  final Oferta oferta;
  const OfertasCard({super.key, required this.oferta});
  @override
  State<OfertasCard> createState() => _OfertasCardState();
}

class _OfertasCardState extends State<OfertasCard> {
  @override
  Widget build(BuildContext context) {
    final oferta = widget.oferta;
    
  
    final fechaValida = '${oferta.endDate.day}/${oferta.endDate.month}/${oferta.endDate.year}';
    
    
    final precioFinal = oferta.precioOriginal != null 
        ? oferta.precioOriginal! * (1 - (oferta.discount / 100))
        : 0;

    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // IMAGEN
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: oferta.imagenUrl != null
                  ? Image.network(
                      oferta.imagenUrl!,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage();
                      },
                      fit: BoxFit.cover,
                    )
                  : _buildPlaceholderImage(),
            ),
          ),
          
          //INFO CARD
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  oferta.nombreJuego,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Válida hasta $fechaValida',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (oferta.precioOriginal != null) ...[
                      Text(
                        '\$${precioFinal.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '\$${oferta.precioOriginal!.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.white54,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${oferta.discount.round()}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ] else
                      Text(
                        'Precio no disponible',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );                
  }


  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
          SizedBox(height: 4),
          Text('Sin imagen', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}