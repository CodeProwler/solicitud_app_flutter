class Licencia {
  final String nombre;
  final String matricula;
  final String carrera;
  final String semestre;
  final String motivo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String? observaciones;

  Licencia({
    required this.nombre,
    required this.matricula,
    required this.carrera,
    required this.semestre,
    required this.motivo,
    required this.fechaInicio,
    required this.fechaFin,
    this.observaciones,
  });
}