import 'package:flutter/material.dart';

class CarreteDocumentosScreen extends StatelessWidget {
  final List<String> documentos = [
    "Capítulo 1.pdf",
    "Correcciones.docx",
    "Informe final.pdf",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Documentos')),
      body: ListView.builder(
        itemCount: documentos.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: Text(documentos[index]),
        ),
      ),
    );
  }
}