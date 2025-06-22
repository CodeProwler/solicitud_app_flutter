import 'package:flutter/material.dart';
import 'carrete_documentos_screen.dart';

class RetroalimentacionScreen extends StatelessWidget {
  final List<String> comentarios = [
    "Revisar redacción del capítulo 1.",
    "Falta anexar la bibliografía.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retroalimentación')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comentarios.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.comment),
                title: Text(comentarios[index]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text("Subir Documento"),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.folder),
                label: Text("Mis Archivos"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CarreteDocumentosScreen()),
                ),
              )
            ],
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }
}