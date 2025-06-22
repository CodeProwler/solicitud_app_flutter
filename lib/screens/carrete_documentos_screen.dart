import 'package:flutter/material.dart';

class CarreteDocumentosScreen extends StatelessWidget {
  final List<String> documentos = [
    "Capítulo 1.pdf",
    "Correcciones.docx",
    "Informe final.pdf",
  ];

  final List<String> fechas = [
    "Subido el 19/06/2025",
    "Subido el 18/06/2025",
    "Subido el 17/06/2025",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Documentos')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: documentos.isEmpty
            ? Center(
                child: Text(
                  "Aún no has subido documentos.",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: documentos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.insert_drive_file, color: Colors.deepPurple),
                      title: Text(documentos[index]),
                      subtitle: Text(fechas[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Abriendo ${documentos[index]}...'),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
