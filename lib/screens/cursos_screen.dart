import 'package:crud/models/estudiante.dart';
import 'package:flutter/material.dart';
import 'package:crud/models/Bd.dart';
import 'package:crud/models/cursos.dart';

class CursosScreen extends StatefulWidget {
  @override
  _CursosScreenState createState() => _CursosScreenState();
}

class _CursosScreenState extends State<CursosScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _creditosController = TextEditingController();
  final TextEditingController _docenteController = TextEditingController();

  set estudiantes(List<Estudiante> estudiantes) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _mostrarFormulario(context);
          },
          child: Text('Agregar Curso'),
        ),
      ),
    );
  }

  _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Curso'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre del Curso'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese el nombre del curso';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _creditosController,
                  decoration: InputDecoration(labelText: 'Créditos'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese la cantidad de créditos';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _docenteController,
                  decoration: InputDecoration(labelText: 'Nombre del Docente'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese el nombre del docente';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final nuevoCurso = Curso(
                    nombre: _nombreController.text,
                    creditos: int.parse(_creditosController.text),
                    nombreDocente: _docenteController.text,
                    id: null,
                    estudiantesIds: [],
                  );
                  DatabaseHelper().insertCurso(nuevoCurso).then((value) {
                    if (value > 0) {
                      Navigator.of(context).pop();
                    } else {
                      // Manejar error al agregar el curso
                    }
                  });
                }
              },
              child: Text('Agregar Curso'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
