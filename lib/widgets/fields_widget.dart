import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tusdeberes/models/dataBase_model.dart';
import 'package:tusdeberes/providers/dataBase_providers.dart';
import 'package:tusdeberes/widgets/alerts_widget.dart';


final _duty      = TextEditingController();
final _description = TextEditingController();
int _onPresed = 1;

//Campos de del formularios agregar
class Duty extends StatefulWidget {

  @override
  _DutyState createState() => _DutyState();
}

class _DutyState extends State<Duty> {
  final _llave = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {    
    
    final _arguments = ModalRoute.of(context)!.settings.arguments as Should ?;  //el ? es para saber si trae informacion o no

    if( _arguments == null) { //si al entrar aqui no hay argumentos significa que se agregara uno nuevo por ende los controladores se inican vacios, si no con la info cargada
      _duty.text = '';
      _description.text = '';
      _onPresed = 0; //pone 0 para que en el home:page se muestre desmarcada al crearla
    }else{
      final _name = _arguments.name;
      final _desc = _arguments.description;
      _duty.text = _name;
      _description.text = _desc;
    }


    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: Form(
          key: _llave,
          child: Column(
            children: [
              SizedBox(height: 10.0),
              _newDuty(),
              SizedBox(height: 20.0),
              _newDescription(),
              SizedBox(height: 120.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _button(context),
                ],
              ),

            ],
          ),
        ),
      ),
    );
           
  }

  _newDuty(){
      return TextFormField(
        controller: _duty,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 3,
        cursorColor: Colors.amberAccent,
        decoration: InputDecoration(
          icon: FaIcon(FontAwesomeIcons.coffee),          
          labelText: 'Nombre',
          labelStyle: TextStyle(color: Colors.amberAccent), //color de letras del label
        ),
        style: TextStyle(
          color: Colors.amber[900], //color de letra que escribe el usuario         
        ),
      validator: (value) {        
        if(value == null || value.isEmpty){
          return 'Ingresa el nombre del deber';
        }else{
          return null;
        }
      },
      );
    }

    _newDescription(){
      return SingleChildScrollView(
        child: TextFormField(
          controller: _description,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5, //para que sea una caja de texto expandible
          cursorColor: Colors.amberAccent,
          decoration: InputDecoration(          
            icon: FaIcon(FontAwesomeIcons.clipboard),          
            labelText: 'Descripción',
            labelStyle: TextStyle(color: Colors.amberAccent)
          ),
        style: TextStyle(
          color: Colors.amber[900],
        ),
        ),
      );
    }

    _button(context){
      return FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.thumbsUp),
        backgroundColor: Colors.amber,
        tooltip: 'Guardar',
        onPressed: () {

          if (_llave.currentState!.validate()) {
            _save(context);                                    
          }else{
            print('hola'); 
          }

        },
      );
    }
}


//Funcion para guardar deber
_save(context) async{

  Should? _argument = ModalRoute.of(context)!.settings.arguments as Should ?;

  if (_argument == null) {
    await Operation.insert(Should(name:_duty.text, description:_description.text, finished: _onPresed));
    //print('guardado el insert');
    alertSave(context, 'Nueva tarea agregada');
  }else{
    _argument.name = _duty.text;
    _argument.description = _description.text;
    _argument.finished = _onPresed;
    //Operation.update(Should(name: _argument.name, description: _argument.description));
    Operation.update(_argument);
    alertUpdate(context, 'Tarea actualizada');
    //print('guardado $ver');
  }
  Navigator.of(context).popUntil(ModalRoute.withName('home_page'));
}