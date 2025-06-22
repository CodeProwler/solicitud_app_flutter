import 'package:flutter/material.dart';
import 'licencia_form_screen.dart';
import 'titulo_inicio_screen.dart';
import 'notificaciones_screen.dart'; // Asegúrate de tener esta pantalla creada

class SeleccionTipoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar tipo de solicitud'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            tooltip: 'Notificaciones',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificacionesScreen(
                    notificaciones: [
                      "✅ Se le asignará un asesor pronto, se le informará a detalle por correo.",
                      "📊 El estado de su solicitud está en un 20%.",
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Qué tipo de solicitud desea hacer?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LicenciaFormScreen()),
                );
              },
              icon: Icon(Icons.description),
              label: Text('Solicitud de Licencia'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TituloInicioScreen()),
                );
              },
              icon: Icon(Icons.school),
              label: Text('Solicitud de Obtención de Título'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
