import 'package:flutter/material.dart';

class TextfieldPage extends StatelessWidget {
  TextEditingController _nombreController = TextEditingController();

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
              controller: _nombreController,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                print(_nombreController);
                print(_nombreController.text);
              },
              child: Text("Presionar"),
            ),
          ],
        ),
      ),
    );
  }
}
