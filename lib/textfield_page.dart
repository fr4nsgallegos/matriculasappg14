import 'package:flutter/material.dart';

class TextfieldPage extends StatelessWidget {
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  String? nombre;
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(
                color: Colors.red,
              ), //controla el color del texto ingresado por el usuario
              maxLength: 50, //máximo de caraceteres permitidos
              decoration: InputDecoration(
                counterText: "", //ocultar el contador de caracteres
                labelText:
                    "Nombre", //texto de etiqueta que aparece cuando el field no esta seleccionado
                hint: Text(
                  "Ingrese el nombre completo ",
                ), //texto de ayuda dentro del Field
                prefixIcon: Icon(Icons.person), //Icono de la izquierda
                suffixText:
                    " metros", //icono o widget que va a la derecha (suffix)
              ),
              // onChanged: (String value) {
              //   nombre = value;
              //   print(nombre);
              // },
              controller: _nombreController,
            ),
            SizedBox(height: 16),
            TextField(
              focusNode: _focusNode,
              obscureText: true,
              style: TextStyle(
                color: Colors.red,
              ), //controla el color del texto ingresado por el usuario
              maxLength: 50, //máximo de caraceteres permitidos
              decoration: InputDecoration(
                counterText: "", //ocultar el contador de caracteres
                labelText:
                    "Contraseña", //texto de etiqueta que aparece cuando el field no esta seleccionado
                hint: Text(
                  "Ingresa la contraseña",
                ), //texto de ayuda dentro del Field
                prefixIcon: Icon(Icons.lock), //Icono de la izquierda
                suffixIcon: Icon(
                  Icons.visibility,
                ), //icono o widget que va a la derecha (suffix)
              ),
              // onChanged: (String value) {
              //   nombre = value;
              //   print(nombre);
              // },
              controller: _contrasenaController,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                print(_nombreController);
                print(_nombreController.text);
                print(_contrasenaController.text);
              },
              child: Text("Presionar"),
            ),
            ElevatedButton(
              onPressed: () {
                _focusNode.requestFocus();
              },
              child: Text("Enfocar textfield de contraseña"),
            ),
          ],
        ),
      ),
    );
  }
}
