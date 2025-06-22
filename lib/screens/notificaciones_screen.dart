import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  final List<String> notificaciones;

  NotificacionesScreen({required this.notificaciones});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notificaciones')),
      body: notificaciones.isEmpty
          ? Center(child: Text('No hay notificaciones aún.'))
          : ListView.builder(
              itemCount: notificaciones.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text(
                      notificaciones[index],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
