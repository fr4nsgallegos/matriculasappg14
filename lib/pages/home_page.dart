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

  void _editarNombreInstitucion(UniversidadModel institucion) {
    final TextEditingController controller = TextEditingController(
      text: institucion.nombre,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Editar",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Ingresar Nuevo Nombre",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final nuevo = controller.text.trim();
                if (nuevo.isNotEmpty) {
                  setState(() {
                    institucion.nombre = nuevo;
                  });
                }
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCabeceraInstitucion(UniversidadModel institucion) {
    bool limiteMatriculas = institucion.matriculas.length >= 5;
    bool hayMatriculas = institucion.matriculas.isNotEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${institucion.nombre} - ${institucion.matriculas.length}"),
        IconButton(
          icon: Icon(limiteMatriculas ? Icons.lock : Icons.add),
          onPressed: limiteMatriculas
              ? null
              : () {
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
          icon: Icon(Icons.cleaning_services),
          onPressed: !hayMatriculas
              ? null
              : () {
                  _eliminarMatriculas(institucion);
                },
        ),

        IconButton(
          onPressed: () {
            _editarNombreInstitucion(institucion);
          },
          icon: Icon(Icons.edit, color: Colors.orange),
        ),

        IconButton(
          onPressed: () {
            instituciones.remove(institucion);
            setState(() {});
          },
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildMatriculaTile(
    UniversidadModel universidad,
    MatriculaModel matricula,
  ) {
    return ListTile(
      title: Text(
        "${matricula.estudiante.nombre} ${matricula.estudiante.apellido}",
      ),
      subtitle: Text(
        "${matricula.carrera.nombre} - ${matricula.carrera.duracion}",
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          _eliminacionMatricula(universidad, matricula);
        },
      ),
    );
  }

  int? expandedIndex;

  _buildExpansionUniversidad(int index, UniversidadModel universidad) {
    return ExpansionTile(
      key: ValueKey('expansionTile_$index${expandedIndex == index}'),
      initiallyExpanded: expandedIndex == index,
      title: _buildCabeceraInstitucion(universidad),
      tilePadding: EdgeInsets.symmetric(horizontal: 32),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      onExpansionChanged: (bool isOpen) {
        expandedIndex = isOpen ? index : null;
        setState(() {});
      },
      children: universidad.matriculas.map((matricula) {
        return _buildMatriculaTile(universidad, matricula);
      }).toList(),
    );
  }

  void _eliminacionMatricula(
    UniversidadModel universidad,
    MatriculaModel matricula,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [SizedBox(width: 5), Text("Confirmar eliminación")],
          ),
          content: Text(
            "¿Estás seguro de eliminar la matrícula de "
            "${matricula.estudiante.nombre} ${matricula.estudiante.apellido}?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                universidad.matriculas.remove(matricula);
                Navigator.pop(context);
                setState(() {});
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  void _eliminarMatriculas(UniversidadModel universidad) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [SizedBox(width: 5), Text("Limpiar matrículas")],
          ),
          content: Text(
            "¿Estás seguro de eliminar TODAS las matrículas de "
            "${universidad.nombre}?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                universidad.matriculas.clear();
                Navigator.pop(context);
                setState(() {});
              },
              child: Text("Eliminar todas"),
            ),
          ],
        );
      },
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
