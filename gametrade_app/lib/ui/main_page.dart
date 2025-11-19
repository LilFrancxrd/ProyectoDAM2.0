import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:videotrade_app/ui/bottom_navbar.dart';
import 'package:videotrade_app/ui/pages/tabs/biblioteca_tab.dart';
import 'package:videotrade_app/ui/pages/tabs/comunidad_tab.dart';
import 'package:videotrade_app/ui/pages/tabs/perfil_tab.dart';
import 'package:videotrade_app/ui/pages/tabs/tienda_tab.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
  TiendaTab(),
  ComunidadTab(),
  BibliotecaTab(),
  PerfilTab()
  ];
  



  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('GameTrade'),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout),
              tooltip: 'Cerrar Sesion',
              
            ), 
          ],
        ),
        body: _pages[_selectedIndex], // <<--- muestra la página actual
        bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,)
    );
  }
}