import '../models/licencia_model.dart';

class LicenciaService {
  Future<void> guardarSolicitud(Licencia licencia) async {
    await Future.delayed(Duration(seconds: 1));
    print("Solicitud guardada: \${licencia.nombre}, Motivo: \${licencia.motivo}");
  }
}