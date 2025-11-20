import 'package:flutter/material.dart';

class ListilePage extends StatefulWidget {
  @override
  State<ListilePage> createState() => _ListilePageState();
}

class _ListilePageState extends State<ListilePage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black45,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Usuario"),
              subtitle: Text(
                "sum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap in",
                maxLines: 2,
              ),
              // leading: Icon(Icons.person),
              leading: CircleAvatar(child: Text("A")),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                print("Tocado!");
                isSelected = !isSelected;
                setState(() {});
              },
              onLongPress: () {
                print("Mantener presionado");
              },
              // dense: true, //reduce la altura del item, lo vuelve más compacto
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              selected:
                  isSelected, //vuelve el Listile en un estilo de selección y para esto se coloca el selected color
              selectedColor: Colors.red,
              isThreeLine:
                  true, //se debe usar cuando el subtitle tiene mucho texto
              enabled: true, //habilita o deshabilita la interacción
              tileColor: Colors.grey, //Controla el color de fondo
              selectedTileColor:
                  Colors.green, //Color de fondo cuando esta seleccionado
            ),
          ],
        ),
      ),
    );
  }
}
