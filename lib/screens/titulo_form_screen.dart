import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'seleccion_tipo_screen.dart';
import 'retroalimentacion_screen.dart';
import 'notificaciones_screen.dart';
import 'estado_tramite_screen.dart';

class TituloFormScreen extends StatefulWidget {
  @override
  _TituloFormScreenState createState() => _TituloFormScreenState();
}

class _TituloFormScreenState extends State<TituloFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _temaController = TextEditingController();
  final _resumenController = TextEditingController();
  final _nombreController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _carreraController = TextEditingController();
  final _semestreController = TextEditingController();

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
          SnackBar(content: Text('⚠️ No se adjuntó ningún archivo. Continuando...')),
        );
      }

      try {
        await FirebaseFirestore.instance.collection('solicitudes_titulo').add({
          'tema': _temaController.text,
          'resumen': _resumenController.text,
          'nombre': _nombreController.text,
          'matricula': _matriculaController.text,
          'carrera': _carreraController.text,
          'semestre': _semestreController.text,
          'fecha_envio': DateTime.now(),
          'archivo': archivoAdjunto ?? '',
        });

        setState(() {
          _mostrarAcciones = true;
          notificaciones.add("👨‍🏫 Se le asignará un asesor pronto.");
          notificaciones.add("📊 Estado del trámite: 30% (Etapa 1 de 3)");
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Solicitud enviada correctamente')),
        );

        // 🚀 Redirigir automáticamente a EstadoTramiteScreen tras 2 segundos
        Future.delayed(Duration(seconds: 2), () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => EstadoTramiteScreen(
                archivoAdjunto: archivoAdjunto ?? 'Documento.pdf',
              ),
            ),
          );
        });

        Future.delayed(Duration(seconds: 30), () {
          if (!mounted) return;
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
  void dispose() {
    _temaController.dispose();
    _resumenController.dispose();
    _nombreController.dispose();
    _matriculaController.dispose();
    _carreraController.dispose();
    _semestreController.dispose();
    super.dispose();
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
                  Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _nombreController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  SizedBox(height: 16),
                  Text('Matrícula', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _matriculaController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  SizedBox(height: 16),
                  Text('Carrera', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _carreraController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  SizedBox(height: 16),
                  Text('Semestre', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _semestreController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  SizedBox(height: 16),
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
