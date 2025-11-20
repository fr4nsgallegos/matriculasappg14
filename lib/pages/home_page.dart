import 'package:flutter/material.dart';
import 'package:matriculasappg14/models/persona_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PersonaModel> personas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                personas.add(
                  PersonaModel(
                    nombre: "Jhonny",
                    apellido: "Galleogos",
                    direccion: "Av 123 123",
                  ),
                );
                setState(() {});
              },
              child: Text("Agregar persona"),
            ),
          ],
        ),
      ),
    );
  }
}
