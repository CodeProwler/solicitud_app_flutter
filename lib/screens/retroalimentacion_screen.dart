import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'carrete_documentos_screen.dart';

class RetroalimentacionScreen extends StatelessWidget {
  final List<String> comentarios = [
    "📝 Revisar redacción del capítulo 1.",
    "📚 Falta anexar la bibliografía.",
  ];

  Future<void> _simularSubidaArchivo(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final fileName = result.files.single.name;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📁 "$fileName" subido exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ No se seleccionó ningún archivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retroalimentación')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comentarios.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.comment, color: Colors.deepPurple),
                    title: Text(comentarios[index]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.upload_file),
                  label: Text("Subir Documento"),
                  onPressed: () => _simularSubidaArchivo(context),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.folder),
                  label: Text("Mis Archivos"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CarreteDocumentosScreen()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
