import 'package:flutter/material.dart';
import 'package:crud/models/estudiante.dart';
import 'package:crud/models/Bd.dart';

class EstudianteScreen extends StatefulWidget {
  @override
  _EstudianteScreenState createState() => _EstudianteScreenState();
}

class _EstudianteScreenState extends State<EstudianteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  List<Estudiante> estudiantes = [];

  @override
  void initState() {
    super.initState();
    _cargarEstudiantes();
  }

  _cargarEstudiantes() async {
    final estudiantesList = await DatabaseHelper().getAllEstudiantes();

    if (estudiantesList != null) {
      setState(() {
        estudiantes = estudiantesList;
      });
    } else {
      // Manejar el caso en el que estudiantesList sea null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes'),
      ),
      body: ListView.builder(
        itemCount: estudiantes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(estudiantes[index].nombres),
              subtitle: Text(
                  'Documento: ${estudiantes[index].documentoIdentidad.toString()} - Edad: ${estudiantes[index].edad}'),
              trailing: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'editar',
                      child: Text('Editar'),
                    ),
                    PopupMenuItem(
                      value: 'eliminar',
                      child: Text('Eliminar'),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 'editar') {
                    _mostrarFormularioEditarEstudiante(
                        context, estudiantes[index]);
                  } else if (value == 'eliminar') {
                    _eliminarEstudiante(context, estudiantes[index]);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarFormularioAgregarEstudiante(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _mostrarFormularioAgregarEstudiante(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Estudiante'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _documentoController,
                  decoration: InputDecoration(labelText: 'Documento Identidad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese el documento de identidad';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nombresController,
                  decoration: InputDecoration(labelText: 'Nombres'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese los nombres';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edadController,
                  decoration: InputDecoration(labelText: 'Edad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese la edad';
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
                  final nuevoEstudiante = Estudiante(
                    documentoIdentidad: int.parse(_documentoController.text),
                    nombres: _nombresController.text,
                    edad: int.parse(_edadController.text),
                    id: null,
                    cursosIds:
                        '', // Asegúrate de configurar cursosIds según tus necesidades
                  );
                  DatabaseHelper().insertEstudiante(nuevoEstudiante);
                  _cargarEstudiantes();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Agregar'),
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

  _mostrarFormularioEditarEstudiante(
      BuildContext context, Estudiante estudiante) {
    _documentoController.text = estudiante.documentoIdentidad.toString();
    _nombresController.text = estudiante.nombres;
    _edadController.text = estudiante.edad.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Estudiante'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _documentoController,
                  decoration: InputDecoration(labelText: 'Documento Identidad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese el documento de identidad';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nombresController,
                  decoration: InputDecoration(labelText: 'Nombres'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese los nombres';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edadController,
                  decoration: InputDecoration(labelText: 'Edad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese la edad';
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
                  estudiante.documentoIdentidad =
                      int.parse(_documentoController.text);
                  estudiante.nombres = _nombresController.text;
                  estudiante.edad = int.parse(_edadController.text);

                  DatabaseHelper().updateEstudiante(estudiante);
                  _cargarEstudiantes();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Guardar Cambios'),
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

  _eliminarEstudiante(BuildContext context, Estudiante estudiante) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Estudiante'),
          content: Text(
              '¿Estás seguro de que deseas eliminar a ${estudiante.nombres}?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (estudiante.id != null) {
                  DatabaseHelper().deleteEstudiante(estudiante.id!);
                  _cargarEstudiantes();
                }
                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
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
