import 'package:flutter/material.dart';
import 'modalidad_screen.dart';

class TituloInicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Obtención de Título')),
      body: Column(
        children: [
          ListTile(
            title: Text('Solicitar Obtención de Título'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ModalidadScreen()),
            ),
          ),
          ListTile(
            title: Text('Estado de Trámite'),
            enabled: false,
          ),
          ListTile(
            title: Text('Retroalimentación'),
            enabled: false,
          ),
        ],
      ),
    );
  }
}