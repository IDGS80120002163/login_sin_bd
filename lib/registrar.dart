import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'principal.dart';

class RegistroNombre extends StatefulWidget {
  @override
  _RegistroNombreState createState() => _RegistroNombreState();
}

class _RegistroNombreState extends State<RegistroNombre> {
  final TextEditingController _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comprobarNombre();
  }

  void _comprobarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('nombre')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
      );
    }
  }

  void _saveNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _nombreController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Principal()),
    );
  }

  void _clearField() {
    _nombreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de nombre')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Escriba su nombre'),
              autofocus: true,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveNombre,
                  child: Text('Guardar'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _clearField,
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
