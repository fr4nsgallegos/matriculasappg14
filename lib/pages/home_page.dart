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
  List<UniversidadModel> instituciones = [];

  Widget _buildCabeceraInstitucion(UniversidadModel institucion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${institucion.nombre} - ${institucion.matriculas.length}"),
        IconButton(
          icon: Icon(Icons.add),
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
            institucion.matriculas.add(
              MatriculaModel(
                fecha: "19/11/25",
                hora: "15:30",
                estudiante: jhonnyEstudiante,
                carrera: carreraSoftware,
              ),
            );
            setState(() {});
          },
        ),
        IconButton(
          onPressed: () {
            institucion.nombre = "Cambiado LIMA";

            setState(() {});
          },
          icon: Icon(Icons.edit, color: Colors.orange),
        ),
      ],
    );
  }

  Widget _buildMatriculaTile(MatriculaModel matricula) {
    return ListTile(
      title: Text(
        "${matricula.estudiante.nombre} ${matricula.estudiante.apellido}",
      ),
      subtitle: Text(
        "${matricula.carrera.nombre} - ${matricula.carrera.duracion}",
      ),
    );
  }

  _buildExpansionUniversidad(UniversidadModel universidad) {
    return ExpansionTile(
      title: _buildCabeceraInstitucion(universidad),
      tilePadding: EdgeInsets.symmetric(horizontal: 32),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      children: universidad.matriculas.map((matricula) {
        return _buildMatriculaTile(matricula);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UniversidadModel tecsup = UniversidadModel(
            nombre: "ULINMA",
            direccion: "AV 1234 LIMA",
            ruc: "123456789987",
            telefono: "9876543212",
            matriculas: [],
          );
          instituciones.add(tecsup);
          setState(() {});
        },
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...instituciones.map((e) {
              return Column(
                children: [
                  _buildExpansionUniversidad(e),
                  // _buildCabeceraInstitucion(e),
                  // ...e.matriculas.map((matricula) {
                  //   return _buildMatriculaTile(matricula);
                  // }).toList(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
