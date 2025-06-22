import 'package:flutter/material.dart';
import 'notificaciones_screen.dart';
import 'retroalimentacion_screen.dart';

class EstadoTramiteScreen extends StatelessWidget {
  final double progreso = 0.3;
  final String archivoAdjunto; // Si quieres mostrar el archivo cargado

  EstadoTramiteScreen({this.archivoAdjunto = 'Trabajo_Titulo.pdf'}); // Valor por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado del Trámite'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => Navigator.push(
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
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Estado del trámite:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 24),

            // Progreso circular
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  ),
                ),
                Text(
                  '${(progreso * 100).toInt()}%',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 32),
            LinearProgressIndicator(
              value: progreso,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),

            SizedBox(height: 16),
            Text(
              'Etapa 1 de 3: Evaluación del tema',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    '🔍 Su trámite ha sido registrado.\n\nEstá en revisión por el comité académico.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_drive_file, color: Colors.deepPurple),
                      SizedBox(width: 8),
                      Text(
                        archivoAdjunto,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
        icon: Icon(Icons.feedback),
        label: Text('Retroalimentación'),
        backgroundColor: Colors.orange,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RetroalimentacionScreen()),
        ),
      ),
    );
  }
}
