import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tusdeberes/models/dataBase_model.dart';
import 'package:tusdeberes/providers/dataBase_providers.dart';
import 'package:tusdeberes/theme/theme_theme.dart';
import 'package:tusdeberes/widgets/alerts_widget.dart';



List<Should> myList = []; //para guardar aqui los deberes de la base
List<bool> isChecked = []; //para el checkbox se puso en lista para que se pudiera presionar en casa cuadrito de check (sin esto la precionar una se activaaban todos)

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorMyPage,
      appBar:  AppBar(
        title: Text('Deberes del dia'),
        backgroundColor: colorMyAppBar,
        actions: [
          Container(
            margin: EdgeInsets.only(top: 15.0, right: 10.0),
            child: _TalkingFrog(),
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(bottom: 72), //para que la lista no la tape el boton
          child: _Lista()
      ),
      floatingActionButton: _Agregar(),
    );

  }
}


//clase de la lista de deberes
class _Lista extends StatefulWidget {

  @override
  __ListaState createState() => __ListaState();
}

class __ListaState extends State<_Lista> {

  @override
    void initState() {
      _loadData();
      super.initState();           
    }

  @override
  Widget build(BuildContext context) {

    isChecked.clear();

    return FutureBuilder(
      future: _loadData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

          return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, i) => _createShould(i)
          );
      },
    );
  }

  // carga los deberes de la base de datos
    _loadData() async{
      List<Should> myList2 = await Operation.shouldsList();
      myList = myList2;
      setState((){});
    }

  //muestra los deberes de la base de datos
     _createShould(int i) {

      if(myList[i].finished == 0) { //este if es para mentener el estado del checkbox aun cuando se cierre la app y se vuelva a abrir
        isChecked.add(false); //false paloma marcada, true paloama desmarcada
      }else{
        isChecked.add(true);
      }

        return Dismissible(
          key: Key(myList[i].id.toString()),  //para la key del dismissible
          direction: DismissDirection.startToEnd,
          background: _styleDismissible(),
          child: ListTile(
            title: Text(myList[i].name),
            trailing: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.redAccent[700]),
            leading: Checkbox(
                  value: isChecked[i],
                  activeColor: Colors.amberAccent, //color del cuadrito al activarse
                  onChanged: (value) {
                    print(isChecked);
                    print(isChecked.length);
                    setState(() {
                      isChecked[i] = !isChecked[i]; //cambiamos el valor del check
                      if(isChecked[i] == false) { //si es falso actualizamos el campo finished de la tabla duty a 0 osea (false, se marca la palomita)
                        myList[i].finished = 0;
                      }else{ //si no lo actualizamos a 0 osea (true, se desmcarca la palomita)
                        myList[i].finished = 1;
                      }
                      _updateAsync(myList[i]); //actualizamos ese campo de la tabla
                    });
                  }
                ),
          onTap: () {
            Navigator.pushNamed(context, 'edit_page', arguments: myList[i]).then((value) => setState((){})); //enviamos los argumentos de nombre, descripcion
          },
          ),
          onDismissed: (direction) {
            _deleteDimissible(myList[i]);
            myList.removeAt(i);
          });
      }


  //para eliminar deslizando
    _deleteDimissible(Should should) {
      Operation.delete(should); //usamos el metodo que lo elimina de la tabla sqflite
      alertDelete(context, 'Deber eliminado ¿uno menos?');
      setState(() {});
    }

  //metodo para usar el update async
   _updateAsync(Should should) async{
      await Operation.update(should);
   }

   //metodo para el estilo del dismissible (color, icono etc)
   _styleDismissible() {
      return Container(
        color: Colors.redAccent[700],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(FontAwesomeIcons.trash, color: Colors.white,),
            SizedBox(width: 10.0,),
            Text('¿Eliminar?', style: TextStyle(fontSize: 20.0, color: Colors.white),)
          ],
        ),
      );
   }

}


//clase para mostrar cuantos deberes faltan al presionar a la rana (:
class _TalkingFrog extends StatefulWidget {

  @override
  __TalkingFrogState createState() => __TalkingFrogState();
}

class __TalkingFrogState extends State<_TalkingFrog> {
  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: FaIcon(FontAwesomeIcons.frog),
      onPressed: () {
        alertMyGoal(context, '¡Hola!, hoy tienes ${myList.length} pendientes *salto*');
      },
    );
  }
}






//clase para  ir a agregar
class _Agregar extends StatefulWidget {

  @override
  __AgregarState createState() => __AgregarState();
}

class __AgregarState extends State<_Agregar> {
  @override

  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      child: FaIcon(FontAwesomeIcons.plus),
      onPressed: () => Navigator.pushNamed(context, 'add_page').then((value) => setState((){})),
    );
  }
}
