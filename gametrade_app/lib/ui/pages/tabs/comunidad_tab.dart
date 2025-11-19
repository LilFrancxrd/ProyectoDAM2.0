import 'package:flutter/material.dart';


class ComunidadTab extends StatefulWidget {
  const ComunidadTab({super.key});

  @override
  State<ComunidadTab> createState() => _ComunidadTabState();
}

class _ComunidadTabState extends State<ComunidadTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Comunidad'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [           
            Text('pagina Comunidad')
          ],
        ),
      ),
    );
  }
}