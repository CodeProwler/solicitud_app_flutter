import '../models/titulo_model.dart';
import '../services/titulo_service.dart';

class TituloController {
  final TituloService _service = TituloService();

  Future<void> enviarTitulo(SolicitudTitulo solicitud) async {
    await _service.guardarTitulo(solicitud);
  }
}