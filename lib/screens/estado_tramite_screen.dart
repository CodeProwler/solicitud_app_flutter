import 'package:flutter/material.dart';
import 'notificaciones_screen.dart';
import 'retroalimentacion_screen.dart';

class EstadoTramiteScreen extends StatelessWidget {
  final double progreso;
  final String archivoAdjunto;

  const EstadoTramiteScreen({
    Key? key,
    this.progreso = 0.3,
    this.archivoAdjunto = 'Trabajo_Titulo.pdf',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado del Trámite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificacionesScreen(
                    notificaciones: [
                      "📊 El estado de su solicitud está en un 30%.",
                      "📤 Adjuntó el archivo correctamente.",
                      "🕒 En espera de revisión por el comité.",
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Estado del trámite:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 24),

            // Progreso circular visual
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 130,
                  height: 130,
                  child: CircularProgressIndicator(
                    value: progreso,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    semanticsLabel: 'Progreso del trámite',
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${(progreso * 100).toInt()}%',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Etapa 1 de 3',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Barra de progreso lineal
            LinearProgressIndicator(
              value: progreso,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),

            const SizedBox(height: 16),
            const Text(
              'Evaluación del tema en curso',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    '🔍 Su trámite ha sido registrado.\n\nEstá en revisión por el comité académico.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.insert_drive_file, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          archivoAdjunto,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.feedback),
        label: const Text('Retroalimentación'),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RetroalimentacionScreen()),
          );
        },
      ),
    );
  }
}
