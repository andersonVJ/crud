class Estudiante {
  int? id;
  int documentoIdentidad;
  String nombres;
  int edad;

  Estudiante({
    this.id,
    required this.documentoIdentidad,
    required this.nombres,
    required this.edad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'documentoIdentidad': documentoIdentidad,
      'nombres': nombres,
      'edad': edad,
    };
  }
}
