
class Should {

   final int? id;
   String name;
   String description;
   int finished;

   Should({this.id, required this.name, required this.description, required this.finished});

   // Convierte en un Map. Las llaves deben corresponder con los nombres de las columnas en la base de datos.
   Map<String, dynamic> toMap() {
     return {
       'id'         : id,
       'name'       : name,
       'description': description,
       'finished'   : finished,
     };
   }

}