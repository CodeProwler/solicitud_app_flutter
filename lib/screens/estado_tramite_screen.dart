import 'package:flutter/material.dart';
import 'notificaciones_screen.dart';
import 'retroalimentacion_screen.dart';

class EstadoTramiteScreen extends StatelessWidget {
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
              MaterialPageRoute(builder: (_) => NotificacionesScreen()),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progreso del trámite:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            LinearProgressIndicator(value: 0.6),
            SizedBox(height: 12),
            Text('60% completado.'),
            SizedBox(height: 24),
            Text('Últimos pasos:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('✓ Envío de formulario'),
            Text('✓ Asignación de asesor'),
            Text('✗ Entrega de borrador'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.feedback),
        label: Text('Retroalimentación'),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RetroalimentacionScreen()),
        ),
      ),
    );
  }
}