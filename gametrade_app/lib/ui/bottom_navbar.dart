import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap; 
  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap
    });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override



  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blueGrey.shade900,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      selectedItemColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.white70, 
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.lightBlueAccent,),label: 'Tienda', ), 
        BottomNavigationBarItem(icon: Icon(Icons.people, color: Colors.lightBlueAccent,), label: 'Comunidad'),
        BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined, color: Colors.lightBlueAccent,), label: 'Biblioteca'),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.lightBlueAccent,), label: 'Perfil')
        

    ],
    
    
    );
  }
}