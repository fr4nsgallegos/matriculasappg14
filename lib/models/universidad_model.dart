import 'package:matriculasappg14/models/matricula_model.dart';

class UniversidadModel {
  String nombre;
  String direccion;
  String ruc;
  String telefono;
  List<MatriculaModel> matriculas;

  UniversidadModel({
    required this.nombre,
    required this.direccion,
    required this.ruc,
    required this.telefono,
    required this.matriculas,
  });
}
