import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImcModel {
  String titulo;
  String recomendacion;
  String pathImage;
  Color color;

  ImcModel({
    required this.titulo,
    required this.recomendacion,
    required this.pathImage,
    required this.color,
  });

  static List<ImcModel> imcList = [
    ImcModel(
      titulo: "Bajo Peso",
      recomendacion: "Se debe alimentar con nutrientes necesarios",
      pathImage: "assets/images/comer.svg",
      color: Colors.yellow,
    ),
    ImcModel(
      titulo: "Normal",
      recomendacion: "El IMC es normal, mantente asi, muy bien hecho!",
      pathImage: "assets/images/normal.svg",
      color: Colors.green,
    ),
    ImcModel(
      titulo: "Sobrepeso",
      recomendacion:
          "Debes salir a correr 1 o 2 veces a la semana y tomar agua",
      pathImage: "assets/images/caminar.svg",
      color: Colors.orange,
    ),
    ImcModel(
      titulo: "Obesidad",
      recomendacion:
          "Realizar una dieta estricta y balanceada. Hacer ejercicio 4 o 5 veces por semana.",
      pathImage: "assets/images/entrenar.svg",
      color: Colors.red,
    ),
  ];
}

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  double peso = 30;
  double estatura = 140;
  double imc = 0;
  ImcModel? modelo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calcular IMC")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Center(
          child: Column(
            children: [
              Text("Altura:"),
              SliderCustom(
                title: estatura.toStringAsFixed(1),
                sufijo: "cm",
                color: Colors.blue,
                maxValue: 230,
                minValue: 140,
                value: estatura,
                onchanged: (v) {
                  setState(() {
                    estatura = v;
                  });
                },
              ),
              Text("Peso:"),
              SliderCustom(
                title: peso.toStringAsFixed(1),
                sufijo: "kg",
                color: Colors.blue,
                minValue: 30,
                maxValue: 165,
                value: peso,
                onchanged: (v) {
                  setState(() {
                    peso = v;
                  });
                },
              ),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.blue,
                child: Text("Calcular", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    imc = ImcLogic().calcular(peso, estatura);
                    modelo = ImcLogic().resultado(imc);
                  });
                },
              ),
              SizedBox(height: 16),
              // Tarjeta
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      imc.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      modelo?.titulo ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: modelo?.color ?? Colors.black,
                      ),
                    ),
                    Text(
                      modelo?.recomendacion ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    // Imagen
                    if (modelo != null)
                      SvgPicture.asset(
                        modelo!.pathImage,
                        width: 120,
                        height: 120,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImcLogic {
  double calcular(double peso, double estatura) {
    //IMC = Peso (Kg) / Estatura  al cuadrado (Mt).
    double estaturaMetro = estatura / 100;
    double imc = peso / (estaturaMetro * estaturaMetro);
    double factor = pow(10, 2).toDouble();

    return (imc * factor).round() / factor;
  }

  ImcModel resultado(double imc) {
    if (imc < 18.5) {
      return ImcModel.imcList[0];
    } else if (imc < 25) {
      return ImcModel.imcList[1];
    } else if (imc < 30) {
      return ImcModel.imcList[2];
    } else {
      return ImcModel.imcList[3];
    }
  }
}

class SliderCustom extends StatelessWidget {
  final String title;
  final String sufijo;
  final double minValue;
  final double maxValue;
  final double value;
  final Color color;
  final Function(double) onchanged;

  const SliderCustom({
    super.key,
    required this.title,
    required this.sufijo,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.color,
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: sufijo,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          label: value.toString(),
          max: maxValue,
          min: minValue,
          value: value,
          activeColor: color,
          onChanged: onchanged,
        ),
      ],
    );
  }
}
