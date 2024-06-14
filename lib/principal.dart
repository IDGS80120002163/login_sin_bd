import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editar.dart';
import 'registrar.dart';

class Principal extends StatelessWidget {
  Future<String?> _obtenerNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Principal')),
      body: FutureBuilder<String?>(
        future: _obtenerNombre(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el nombre'));
          } else {
            String? nombre = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Hola, $nombre', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Edicion()),
                      );
                    },
                    child: Text('Editar nombre'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
