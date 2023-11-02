class Estudiante {
  int? id;
  int documentoIdentidad; // Cambiado a int
  String nombres;
  int edad;
  String cursosIds;

  Estudiante({
    this.id,
    required this.documentoIdentidad,
    required this.nombres,
    required this.edad,
    required this.cursosIds,
  });

  // Método para convertir un Estudiante a un mapaF
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'documentoIdentidad': documentoIdentidad,
      'nombres': nombres,
      'edad': edad,
      'cursosIds': cursosIds,
    };
  }

  // Método para crear un  Estudiante desde un mapa
  factory Estudiante.fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map['id'],
      documentoIdentidad: map['documentoIdentidad'],
      nombres: map['nombres'],
      edad: map['edad'],
      cursosIds: map['cursosIds'],
    );
  }
}
