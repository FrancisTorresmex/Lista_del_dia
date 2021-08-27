import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tusdeberes/theme/theme_theme.dart';


//Función para mostrar un toast de insertar
  void alertSave(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(mensaje, style: TextStyle(color: Colors.amber[900], fontSize: 15)),
            FaIcon(FontAwesomeIcons.cat),
          ],
        ),
        duration: Duration(milliseconds: 3000),
        backgroundColor: colorMyToast,
      ),
    );
  }

//Función para mostrar un toast de eliminar
void alertDelete(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(mensaje, style: TextStyle(color: Colors.amber[900], fontSize: 15)),
          FaIcon(FontAwesomeIcons.crow),
        ],
      ),
      duration: Duration(milliseconds: 3000),
      backgroundColor: colorMyToast,
    ),
  );
}


//Función para mostrar un toast de actualizar
void alertUpdate(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(mensaje, style: TextStyle(color: Colors.amber[900], fontSize: 15)),
          FaIcon(FontAwesomeIcons.carrot),
        ],
      ),
      duration: Duration(milliseconds: 3000),
      backgroundColor: colorMyToast,
    ),
  );
}


//Funcion para mostrar un toast de cantidad de deberes
void alertMyGoal(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(mensaje, style: TextStyle(color: Colors.amber[900], fontSize: 15)),
            FaIcon(FontAwesomeIcons.heart, color: Colors.red,),
          ],
        ),
        duration: Duration(milliseconds: 3000),
        backgroundColor: colorMyToast,
      ),
    );
}