import '../models/licencia_model.dart';
import '../services/licencia_service.dart';

class LicenciaController {
  final LicenciaService _service = LicenciaService();

  Future<void> enviarSolicitud(Licencia licencia) async {
    await _service.guardarSolicitud(licencia);
  }
}