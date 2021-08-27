import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tusdeberes/models/dataBase_model.dart';
import 'package:tusdeberes/providers/dataBase_providers.dart';
import 'package:tusdeberes/theme/theme_theme.dart';
import 'package:tusdeberes/widgets/alerts_widget.dart';
import 'package:tusdeberes/widgets/fields_widget.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorMyPage,
      appBar: AppBar(
        title: Text('Modificar'),
        backgroundColor: colorMyAppBar,
        actions: [
          _trash(),
        ],
      ),
      body: Duty(), // clase que contiene los campos a llenar
    );
  }

  //metodo del icono para borrar
  _trash() {
    Should? _arguments = ModalRoute.of(context)!.settings.arguments as Should; //contiene el id, nombre y descripción del deber
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.trash, color: Colors.redAccent[700]),
      onPressed: () {
        Operation.delete(_arguments);
        alertDelete(context, 'Deber eliminado, ¿uno menos?');
        Navigator.of(context).popUntil(ModalRoute.withName("home_page"));
      }
    );
  }

}
