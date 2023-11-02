import 'dart:convert';

class Curso {
  int? id;
  String nombre;
  int creditos;
  String nombreDocente;
  List<int>
      estudiantesIds; // Lista de ID de los estudiantes que están inscritos en el curso

  Curso({
    required this.id,
    required this.nombre,
    required this.creditos,
    required this.nombreDocente,
    required this.estudiantesIds,
  });

  // Método para convertir un  Curso a un mapa
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'creditos': creditos,
      'nombreDocente': nombreDocente,
      'estudiantesIds': json.encode(estudiantesIds),
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      id: map['id'],
      nombre: map['nombre'],
      creditos: map['creditos'],
      nombreDocente: map['nombreDocente'],
      estudiantesIds: List<int>.from(json.decode(map['estudiantesIds'])),
    );
  }
}
