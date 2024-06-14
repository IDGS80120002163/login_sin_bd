import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'principal.dart';
import 'registrar.dart';

class Edicion extends StatefulWidget {
  @override
  _EdicionState createState() => _EdicionState();
}

class _EdicionState extends State<Edicion> {
  final TextEditingController _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarNombre();
  }

  void _cargarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nombre = prefs.getString('nombre');
    if (nombre != null) {
      setState(() {
        _nombreController.text = nombre;
      });
    }
  }

  void _guardarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _nombreController.text);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Principal()),
      (Route<dynamic> route) => false,
    );
  }

  void _eliminarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombre');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => RegistroNombre()),
      (Route<dynamic> route) => false,
    );
  }

  void _cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar nombre')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Edita tu nombre'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _guardarNombre,
                  child: Text('Save'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _cancelar,
                  child: Text('Cancelar'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _eliminarNombre,
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
