import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'seleccion_tipo_screen.dart';
import 'retroalimentacion_screen.dart';
import 'notificaciones_screen.dart';
import 'estado_tramite_screen.dart'; // ✅ IMPORTACIÓN NECESARIA

class TituloFormScreen extends StatefulWidget {
  @override
  _TituloFormScreenState createState() => _TituloFormScreenState();
}

class _TituloFormScreenState extends State<TituloFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _temaController = TextEditingController();
  final _resumenController = TextEditingController();
  bool _mostrarAcciones = false;
  double progreso = 0.2;
  bool mostrarRetroalimentacion = false;
  List<String> notificaciones = [];

  String? archivoAdjunto;

  void _adjuntarArchivo() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        archivoAdjunto = result.files.single.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📎 Documento "$archivoAdjunto" adjuntado.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ No se seleccionó ningún archivo')),
      );
    }
  }

  void _enviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      if (archivoAdjunto == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ Debe adjuntar un documento antes de enviar.')),
        );
        return;
      }

      try {
        await FirebaseFirestore.instance.collection('solicitudes_titulo').add({
          'tema': _temaController.text,
          'resumen': _resumenController.text,
          'nombre': 'Juan Pérez',
          'matricula': '20231234',
          'carrera': 'Educación Inicial',
          'semestre': 'VI',
          'fecha_envio': DateTime.now(),
          'archivo': archivoAdjunto,
        });

        setState(() {
          _mostrarAcciones = true;
          notificaciones.add("👨‍🏫 Se le asignará un asesor pronto.");
          notificaciones.add("📊 Estado del trámite: 30% (Etapa 1 de 3)");
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Solicitud enviada correctamente')),
        );

        Future.delayed(Duration(seconds: 30), () {
          setState(() {
            progreso = 1.0;
            mostrarRetroalimentacion = true;
            notificaciones.add("✅ El trámite alcanzó el 100%.");
            notificaciones.add("📝 Puede acceder a la retroalimentación.");
          });
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error al guardar en Firebase')),
        );
      }
    }
  }

  void _verNotificaciones() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotificacionesScreen(notificaciones: notificaciones),
      ),
    );
  }

  void _verRetroalimentacion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RetroalimentacionScreen()),
    );
  }

  void _verEstadoTramite() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EstadoTramiteScreen()),
    );
  }

  void _volverAMenuSeleccion() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => SeleccionTipoScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Título'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _verNotificaciones,
          ),
        ],
      ),
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
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _adjuntarArchivo,
                    icon: Icon(Icons.attach_file),
                    label: Text('Adjuntar Documento'),
                  ),
                  if (archivoAdjunto != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Archivo adjuntado: $archivoAdjunto',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                onPressed: _verEstadoTramite,
                icon: Icon(Icons.info_outline),
                label: Text('Consultar estado del trámite'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              if (mostrarRetroalimentacion) ...[
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _verRetroalimentacion,
                  icon: Icon(Icons.feedback),
                  label: Text('Ver Retroalimentación'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
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

