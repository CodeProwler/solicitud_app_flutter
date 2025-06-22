import 'package:flutter/material.dart';
import 'seleccion_tipo_screen.dart'; // Asegúrate de que esta ruta sea válida

class LicenciaFormScreen extends StatefulWidget {
  @override
  _LicenciaFormScreenState createState() => _LicenciaFormScreenState();
}

class _LicenciaFormScreenState extends State<LicenciaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final motivoController = TextEditingController();
  final observacionesController = TextEditingController();
  DateTime? fechaInicio;
  DateTime? fechaFin;
  bool _mostrarAcciones = false;

  Future<void> _selectDate(BuildContext context, bool isInicio) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isInicio) {
          fechaInicio = picked;
        } else {
          fechaFin = picked;
        }
      });
    }
  }

  void _enviarSolicitud() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Solicitud enviada con éxito')),
      );
      setState(() {
        _mostrarAcciones = true;
      });
    }
  }

  void _mostrarEstadoDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Estado del Trámite'),
        content: Text(
            'Solicitud aceptada.\nSe le enviará más información por correo.\nGracias.'),
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
      appBar: AppBar(title: Text("Nueva Solicitud de Licencia")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Datos del Estudiante", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nombre: Juan Pérez"),
                  Text("Matrícula: 20231234"),
                  Text("Carrera: Educación Inicial"),
                  Text("Semestre: VI"),
                  SizedBox(height: 16),
                  Text("Motivo de la Solicitud", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: motivoController,
                    decoration: InputDecoration(labelText: "Motivo detallado"),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Campo obligatorio" : null,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Inicio: ${fechaInicio?.toLocal().toString().split(' ')[0] ?? '--'}"),
                          trailing: Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("Fin: ${fechaFin?.toLocal().toString().split(' ')[0] ?? '--'}"),
                          trailing: Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: observacionesController,
                    decoration: InputDecoration(labelText: "Observaciones (opcional)"),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _enviarSolicitud,
                    child: Text("Enviar Solicitud"),
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
            ]
          ],
        ),
      ),
    );
  }
}
