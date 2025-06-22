import 'package:flutter/material.dart';
import 'menu_screen.dart';

class LicenciaConfirmacionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
              SizedBox(height: 24),
              Text(
                'Tu solicitud ha sido enviada exitosamente.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Puedes consultar su estado en el historial de solicitudes.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => MenuScreen()),
                  (route) => false,
                ),
                child: Text('Volver al Menú Principal'),
              )
            ],
          ),
        ),
      ),
    );
  }
}