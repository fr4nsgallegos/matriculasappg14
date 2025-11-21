import 'package:flutter/material.dart';
import 'package:matriculasappg14/models/carrera_model.dart';
import 'package:matriculasappg14/models/matricula_model.dart';
import 'package:matriculasappg14/models/persona_model.dart';
import 'package:matriculasappg14/models/universidad_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UniversidadModel> instituciones = [];

  void eliminarTodasLasMatriculas(UniversidadModel universidad) {
    setState(() {
      universidad.matriculas.clear();
    });
  }

  int cantidadMatriculas(UniversidadModel universidad) {
    return universidad.matriculas.length;
  }

  Widget _buildCabeceraInstitucion(UniversidadModel institucion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${institucion.nombre} - ${institucion.matriculas.length}"),
        // Agregar
        IconButton(
          icon: cantidadMatriculas(institucion) < 5
              ? Icon(Icons.add)
              : Icon(Icons.lock),
          onPressed: () {
            if (cantidadMatriculas(institucion) > 4) return;

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
        // Editar
        IconButton(
          onPressed: () {
            institucion.nombre = "Cambiado LIMA";

            setState(() {});
          },
          icon: Icon(Icons.edit, color: Colors.orange),
        ),
        // Eliminar institucion
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Eliminar"),
                  content: Text("¿Deseas eliminar la institucion?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                        setState(() {
                          instituciones.remove(institucion);
                          if (instituciones.isEmpty) {
                            expandedIndex = null;
                          }
                        });
                      },
                      child: Text(
                        "Eliminar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.delete, color: Colors.red),
        ),
        // Eliminar todas las matriculas
        IconButton(
          icon: Icon(Icons.delete_forever),
          color: cantidadMatriculas(institucion) > 0 ? Colors.redAccent : null,
          onPressed: cantidadMatriculas(institucion) > 0
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Eliminar"),
                        content: Text("¿Deseas eliminar todas las matrículas?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () {
                              eliminarTodasLasMatriculas(institucion);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Eliminar",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildMatriculaTile(
    MatriculaModel matricula,
    UniversidadModel universidad,
  ) {
    return ListTile(
      title: Text(
        "${matricula.estudiante.nombre} ${matricula.estudiante.apellido}",
      ),
      subtitle: Text(
        "${matricula.carrera.nombre} - ${matricula.carrera.duracion}",
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Eliminar"),
              content: Text("¿Deseas eliminar esta matrícula?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    //Eliminar
                    universidad.matriculas.remove(matricula);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text("Eliminar", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  int? expandedIndex;

  _buildExpansionUniversidad(int index, UniversidadModel universidad) {
    return ExpansionTile(
      key: ValueKey('expansionTile_$index${expandedIndex == index}'),
      initiallyExpanded: expandedIndex == index,
      title: _buildCabeceraInstitucion(universidad),
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      onExpansionChanged: (bool isOpen) {
        expandedIndex = isOpen ? index : null;
        setState(() {});
      },
      children: universidad.matriculas.map((matricula) {
        return _buildMatriculaTile(matricula, universidad);
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
            for (int i = 0; i < instituciones.length; i++)
              _buildExpansionUniversidad(i, instituciones[i]),

            // ...instituciones.map((e) {
            //   return Column(
            //     children: [
            //       _buildExpansionUniversidad(e),
            //       // _buildCabeceraInstitucion(e),
            //       // ...e.matriculas.map((matricula) {
            //       //   return _buildMatriculaTile(matricula);
            //       // }).toList(),
            //     ],
            //   );
            // }).toList(),
          ],
        ),
      ),
    );
  }
}
