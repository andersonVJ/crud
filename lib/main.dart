import 'package:flutter/material.dart';
import 'package:crud/screens/estudiante_screen.dart';
import 'package:crud/screens/cursos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [EstudianteScreen(), CursosScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icono para Estudiantes
            label: 'Estudiantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book), // Icono para Cursos
            label: 'Cursos',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AgregarCursoScreen(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null, // Mostrar el botón solo en la pantalla de Cursos
    );
  }
}

AgregarCursoScreen() {}
