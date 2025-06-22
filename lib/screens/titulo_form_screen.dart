import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase import
import 'seleccion_tipo_screen.dart';

class TituloFormScreen extends StatefulWidget {
  @override
  _TituloFormScreenState createState() => _TituloFormScreenState();
}

class _TituloFormScreenState extends State<TituloFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _temaController = TextEditingController();
  final _resumenController = TextEditingController();
  bool _mostrarAcciones = false;

  void _enviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('solicitudes_titulo').add({
          'tema': _temaController.text,
          'resumen': _resumenController.text,
          'nombre': 'Juan Pérez',
          'matricula': '20231234',
          'carrera': 'Educación Inicial',
          'semestre': 'VI',
          'fecha_envio': DateTime.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Solicitud enviada y guardada en Firebase')),
        );

        setState(() {
          _mostrarAcciones = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar en Firebase')),
        );
      }
    }
  }

  void _mostrarEstadoDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Estado del Trámite'),
        content: Text(
          'Se le asignará un asesor y se le comunicará los pasos a seguir.\nGracias.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _volverAMenuSeleccion() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => SeleccionTipoScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Título')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Tema', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _temaController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  SizedBox(height: 16),
                  Text('Resumen', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _resumenController,
                    maxLines: 4,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                    child: Text('Enviar Solicitud'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
            if (_mostrarAcciones) ...[
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _mostrarEstadoDialog,
                icon: Icon(Icons.info_outline),
                label: Text('Consultar estado del trámite'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _volverAMenuSeleccion,
                icon: Icon(Icons.home),
                label: Text('Volver al menú'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
