import '../models/titulo_model.dart';

class TituloService {
  Future<void> guardarTitulo(SolicitudTitulo solicitud) async {
    await Future.delayed(Duration(seconds: 1));
    print("Título guardado: \${solicitud.tema}");
  }
}