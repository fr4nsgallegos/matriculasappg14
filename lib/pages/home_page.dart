import 'package:flutter/material.dart';
import 'package:matriculasappg14/models/carrera_model.dart';
import 'package:matriculasappg14/models/matricula_model.dart';
import 'package:matriculasappg14/models/persona_model.dart';
import 'package:matriculasappg14/models/universidad_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PersonaModel> personas = [];
  List<Widget> listar(List<PersonaModel> personas) {
    return personas.map((persona) {
      return ListTile(
        title: Text(persona.nombre),
        subtitle: Text(persona.apellido),
      );
    }).toList();
  }

  UniversidadModel tecsup = UniversidadModel(
    nombre: "TECSUP",
    direccion: "AV 1234 LIMA",
    ruc: "123456789987",
    telefono: "9876543212",
    matriculas: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Text("${tecsup.nombre} - ${tecsup.matriculas.length}"),
                ElevatedButton(
                  onPressed: () {
                    PersonaModel jhonnyEstudiante = PersonaModel(
                      nombre: "Jhonny",
                      apellido: "Galleogos",
                      direccion: "Av 123 123",
                    );
                    CarreraModel carreraSoftware = CarreraModel(
                      "Ing. Software",
                      "5 años",
                    );
                    tecsup.matriculas.add(
                      MatriculaModel(
                        fecha: "19/11/25",
                        hora: "15:30",
                        estudiante: jhonnyEstudiante,
                        carrera: carreraSoftware,
                      ),
                    );
                    setState(() {});
                  },
                  child: Text("Agregar matrícula"),
                ),
              ],
            ),

            ...tecsup.matriculas.map((matricula) {
              return ListTile(
                title: Text(
                  "${matricula.estudiante.nombre} ${matricula.estudiante.apellido}",
                ),
                subtitle: Text(
                  "${matricula.carrera.nombre} - ${matricula.carrera.duracion}",
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
