class Todo {
  int id;
  String datedebut;
  String datefin;
  String quantite;
  int isFinished;

  todoMap(){
    var mapping = Map<String, dynamic> ();
    mapping['id']= id;
    mapping['datedebut']= datedebut;
    mapping['datefin']= datefin;
    mapping['quantite']= quantite;
    mapping['isFinished']= isFinished;

    return mapping;
  }
}