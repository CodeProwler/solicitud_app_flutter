import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  final List<String> notificaciones = [
    "Se le asignó el profesor X",
    "La fecha de sustentación tiene plazo hasta el 30/07",
    "Ya está habilitado el módulo de retroalimentación",
    "Su asesor publicó la primera revisión del trabajo",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notificaciones')),
      body: ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.notifications),
          title: Text(notificaciones[index]),
        ),
      ),
    );
  }
}