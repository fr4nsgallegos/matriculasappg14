import 'package:flutter/material.dart';

class ExpansiontilePage extends StatelessWidget {
  const ExpansiontilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpansionTile(
              title: Text(
                "Título",
              ), //texto o widgetn pricipal que se ve siempre
              subtitle: Text("subtitulo"),
              leading: Icon(Icons.person),
              // trailing: Icon(Icons.abc),
              initiallyExpanded: true, //indicar que inicie expandido
              onExpansionChanged: (bool isOpen) {
                print("Esta abierto? : $isOpen");
              },
              collapsedBackgroundColor:
                  Colors.red, //color del expansion cuando esta cerrado
              backgroundColor: Colors.blue, //Color de fondo
              iconColor: Colors.cyan,
              textColor: Colors.yellow,
              children: [
                ListTile(title: Text("Elemento 1")),
                ListTile(title: Text("Elemento 2")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
