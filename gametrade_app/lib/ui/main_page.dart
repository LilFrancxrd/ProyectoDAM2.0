import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:videotrade_app/services/auth_services.dart';
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
  
  // 🧪 Función para probar la API
  Future<void> _testApi() async {
    // Mostrar loading
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Probando conexión con API...'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // Ejecutar test
    await AuthService.testApiConnection();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Revisa la consola para ver los resultados'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameTrade'),
        actions: [
          // Logout
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}