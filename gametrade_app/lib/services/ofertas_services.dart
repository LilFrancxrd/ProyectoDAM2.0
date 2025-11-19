import 'package:videotrade_app/models/offers.dart';

class OfertasServices {
  static bool estaActiva(Oferta oferta){
    final now = DateTime.now();
    return now.isAfter(oferta.startDate as DateTime) && now.isBefore(oferta.endDate);
  }

  static int diasRestantes(Oferta oferta){
    final now = DateTime.now();
    final diferencia = oferta.endDate.difference(now);
    return diferencia.inDays;
  }
  static String formatearFecha(DateTime fecha){
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }
}
