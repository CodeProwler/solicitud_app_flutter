import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'carrete_documentos_screen.dart';

class RetroalimentacionScreen extends StatefulWidget {
  @override
  _RetroalimentacionScreenState createState() => _RetroalimentacionScreenState();
}

class _RetroalimentacionScreenState extends State<RetroalimentacionScreen> {
  String? archivoAdjunto;

  final List<String> comentarios = [
    "📝 Revisar redacción del capítulo 1.",
    "📚 Falta anexar la bibliografía.",
  ];

  Future<void> _subirDocumentoAutenticacion() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        archivoAdjunto = result.files.single.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📁 "$archivoAdjunto" subido exitosamente')),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📄 Documento de Autenticación:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.insert_drive_file, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      archivoAdjunto ?? 'Documento_Autenticacion.pdf',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text("Subir Documento"),
              onPressed: _subirDocumentoAutenticacion,
            ),
            const SizedBox(height: 24),
            Text(
              '🗨️ Comentarios del asesor:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: comentarios.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.comment, color: Colors.deepPurple),
                    title: Text(comentarios[index]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.folder),
                label: Text("Mis Archivos"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CarreteDocumentosScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
