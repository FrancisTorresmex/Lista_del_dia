import 'package:flutter/material.dart';
import 'package:tusdeberes/theme/theme_theme.dart';
import 'package:tusdeberes/widgets/fields_widget.dart';


class AddPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {   

    return Scaffold(
      backgroundColor: colorMyPage,
      appBar: AppBar(
        backgroundColor: colorMyAppBar, //uso de mi tema de colores
        title: Text('Nuevo deber'),
      ),
      body: Duty(), // clase que contiene los campos a llenar
    );
  }
}

