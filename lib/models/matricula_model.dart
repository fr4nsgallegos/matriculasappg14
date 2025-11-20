import 'package:matriculasappg14/models/carrera_model.dart';
import 'package:matriculasappg14/models/persona_model.dart';

class MatriculaModel {
  String fecha;
  String hora;
  PersonaModel estudiante;
  CarreraModel carrera;

  MatriculaModel({
    required this.fecha,
    required this.hora,
    required this.estudiante,
    required this.carrera,
  });
}
