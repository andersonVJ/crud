import 'package:flutter/material.dart';
import 'package:crud/models/cursos.dart';
import 'package:crud/models/estudiante.dart';
import 'package:crud/models/Bd.dart';

class DetallesCursoScreen extends StatefulWidget {
  final Curso curso;

  DetallesCursoScreen(this.curso);

  @override
  _DetallesCursoScreenState createState() => _DetallesCursoScreenState();
}

class _DetallesCursoScreenState extends State<DetallesCursoScreen> {
  // Controladores para los campos de estudiante
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Curso'),
      ),
      body: Column(
        children: <Widget>[
          // Mostrar detalles del curso
          ListTile(
            title: Text('Nombre del Curso: ${widget.curso.nombre}'),
            subtitle: Text(
                'Créditos: ${widget.curso.creditos.toString()} - Docente: ${widget.curso.nombreDocente}'),
          ),
          // Aquí puedes mostrar la lista de estudiantes asignados al curso
          // Utiliza un ListView.builder o ListView para mostrar la lista de estudiantes
          // y permite agregar, editar y eliminar estudiantes según sea necesario.
        ],
      ),
    );
  }
}
