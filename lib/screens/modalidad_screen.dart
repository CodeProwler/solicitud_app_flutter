import 'package:flutter/material.dart';
import 'titulo_form_screen.dart';

class ModalidadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Modalidad')),
      body: Column(
        children: [
          ListTile(
            title: Text('Tesis'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TituloFormScreen()),
            ),
          ),
          ListTile(
            title: Text('Trabajo Académico'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TituloFormScreen()),
            ),
          ),
          ListTile(
            title: Text('Trabajo de Suficiencia'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TituloFormScreen()),
            ),
          ),
        ],
      ),
    );
  }
}