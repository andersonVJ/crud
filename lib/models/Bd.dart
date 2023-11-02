import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crud/models/estudiante.dart';
import 'package:crud/models/cursos.dart';
import 'dart:convert';

class DatabaseHelper {
  late Database database;

  Future open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tu_base_de_datos.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
  CREATE TABLE estudiante (
    id INTEGER PRIMARY KEY,
    documentoIdentidad INTEGER,
    nombres TEXT,
    edad INTEGER,
    cursosIds TEXT
  )
''');
      await db.execute('''
        CREATE TABLE curso (
          id INTEGER PRIMARY KEY,
          nombre TEXT,
          creditos INTEGER,
          nombreDocente TEXT,
          estudiantesIds BLOB
        )
      ''');
    });
  }

  // Métodos CRUD para Estudiantes
  Future<int> insertEstudiante(Estudiante estudiante) async {
    await open();
    estudiante.cursosIds = json.encode(estudiante.cursosIds);
    return await database.insert('estudiante', estudiante.toMap());
  }

  Future<Estudiante?> getEstudiante(int id) async {
    await open();
    if ((await database.query('estudiante',
                columns: null, where: 'id = ?', whereArgs: [id]))
            .length >
        0) {
      return Estudiante.fromMap((await database.query('estudiante',
              columns: null, where: 'id = ?', whereArgs: [id]))
          .first);
    }
    return null;
  }

  Future<int> updateEstudiante(Estudiante estudiante) async {
    await open();
    return await database.update('estudiante', estudiante.toMap(),
        where: 'id = ?', whereArgs: [estudiante.id]);
  }

  Future<int> deleteEstudiante(int id) async {
    await open();
    return await database
        .delete('estudiante', where: 'id = ?', whereArgs: [id]);
  }

  // Método para obtener todos los estudiantes
  Future<List<Estudiante>> getAllEstudiantes() async {
    await open();
    final List<Map<String, dynamic>> maps = await database.query('estudiante');
    return List.generate(maps.length, (i) {
      return Estudiante(
        id: maps[i]['id'],
        documentoIdentidad: int.parse(maps[i]['documentoIdentidad']),
        nombres: maps[i]['nombres'],
        edad: maps[i]['edad'],
        cursosIds: '',
      );
    });
  }

  // Métodos CRUD para Cursos

  Future<int> insertCurso(Curso curso) async {
    await open();
    return await database.insert('curso', curso.toMap());
  }

  Future<Curso?> getCurso(int id) async {
    await open();
    if ((await database.query('curso',
                columns: null, where: 'id = ?', whereArgs: [id]))
            .length >
        0) {
      return Curso.fromMap((await database
              .query('curso', columns: null, where: 'id = ?', whereArgs: [id]))
          .first);
    }
    return null;
  }

  Future<int> updateCurso(Curso curso) async {
    await open();
    return await database
        .update('curso', curso.toMap(), where: 'id = ?', whereArgs: [curso.id]);
  }

  Future<int> deleteCurso(int id) async {
    await open();
    return await database.delete('curso', where: 'id = ?', whereArgs: [id]);
  }
}
