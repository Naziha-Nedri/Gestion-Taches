
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/TacheModel.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'DataService.dart';

import 'Task.dart';
import 'note.dart';
import 'notes_database.dart';


class TacheDetailsScreen extends StatefulWidget {
  final Tache tache ;
  TacheDetailsScreen(this.tache);

  @override
  _TacheDetailsScreenState createState() => _TacheDetailsScreenState();
}

class _TacheDetailsScreenState extends State<TacheDetailsScreen> {
  DateTime date;
  DateTime Date;
  bool enabled;
  Tache tache;
  var _datecontroller= TextEditingController();
  var _datecontroller1= TextEditingController();
  var _quantitecontroller= TextEditingController();
  String ddebut;
  String dfin;
  String quantit;
  String text='';
  TodoService _todoService;
  List<Todo> _todolist= List<Todo>();

  @override
  initState(){
    super.initState();
    getAllTodos();
  }
  initstate(){
    super.initState();
    _datecontroller.addListener(gettext);
  }
  gettext(){
    setState(() {
      text=_datecontroller.text;
    });
  }
  @override
  void dispose(){
    super.dispose();
    _datecontroller.dispose();
  }



  getAllTodos() async{
    _todoService=TodoService();
    _todolist = List<Todo>();
    var todos = await _todoService.readTodos();
    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.id=todo['id'];
        model.datedebut=todo['datedebut'];
        model.datefin=todo['datefin'];
        model.quantite=todo['quantite'];
      });
    });
  }






  DateTime _init =DateTime.now();
  Future <Null> selectTimePicker(BuildContext context) async{

    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: _init,
        firstDate: DateTime(1945),
        lastDate: DateTime(2030));
    /*if (picked == null)
     return;
    setState(() => date = picked);*/
    if (_picked != null){
      setState(() {
        _init = _picked;
        _datecontroller.text = DateFormat('yyy/MM/dd').format(_picked);
      });

    }

  }
  Future <Null> selectTimePicker1(BuildContext context) async{

    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: _init,
        firstDate: DateTime(1945),
        lastDate: DateTime(2030));
    /*if (picked == null)
     return;
    setState(() => date = picked);*/
    if (_picked != null){
      setState(() {
        _init = _picked;
        _datecontroller1.text = DateFormat('yyy/MM/dd').format(_picked);
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff182D33),
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Text(widget.tache.Nom,style: TextStyle(fontSize: 25,color: Colors.blueGrey[900]),),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [SizedBox(height: 20),
              Container(

                child: Center(

                  child: Text(
                    widget.tache.Code.toString(),

                    style: TextStyle(fontSize: 45,color: Colors.teal[100]),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(
                  10,
                  // Space between underline and text
                ),
                decoration: BoxDecoration(
                    border:  Border.all(
                      color: Colors.yellow[200],
                      width: 1.0, // Underline thickness
                    )
                ),
                child: Text(
                  widget.tache.datedebut,

                  style: TextStyle(fontSize: 22,color: Colors.white,),
                ),
              ),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(
                    10
                  // Space between underline and text
                ),
                decoration: BoxDecoration(
                    border:  Border.all(
                      color: Colors.yellow[200],
                      width: 1.0, // Underline thickness
                    )
                ),
                child: Text(
                  widget.tache.datefin,

                  style: TextStyle(fontSize: 22,color: Colors.white),
                ),
              ),

              SizedBox(height: 20),
              Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(
                      0,
                      // Space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border:  Border.all(
                          color: Colors.amber,
                          width: 1.0, // Underline thickness
                        )
                    ),
                    child: TextField(
                      enabled: enabled,


                      controller: _datecontroller,
                      style: TextStyle(color: Colors.white,fontSize: 22),
                      decoration: InputDecoration(
                          hintText: 'saisisez la date début réele',
                          hintStyle: TextStyle(color: Colors.white54),
                          prefixIcon: InkWell(
                            onTap: (){
                              selectTimePicker(context);
                            },
                            child:Icon(Icons.calendar_today,color: Colors.greenAccent,),
                          )
                      ),
                    ),


                  ),




                  //Text('${date.day}/${date.month}/${date.year}'),
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(
                        0,
                        // Space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border:  Border.all(
                            color: Colors.amber,
                            width: 1.0, // Underline thickness
                          )
                      ),
                      child: TextField(
                        enabled: enabled,
                        controller: _datecontroller1,
                        style: TextStyle(color: Colors.white,fontSize: 22),
                        decoration: InputDecoration(
                            hintText: 'saisisez la date Fin réele',
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: InkWell(
                              onTap: (){
                                selectTimePicker1(context);
                              },
                              child:Icon(Icons.calendar_today,color: Colors.greenAccent,),
                            )
                        ),
                      ),
                    ),)

                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(
                  7,
                  // Space between underline and text
                ),
                decoration: BoxDecoration(
                    border:  Border.all(
                      color: Colors.amber,
                      width: 1.0, // Underline thickness
                    )
                ),
                child: TextField(
                  enabled: enabled,
                  controller: _quantitecontroller,

                  style: TextStyle(color: Colors.white,fontSize: 22),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 14),
                      hintText: ' Saisisez la Quantité',
                      hintStyle: TextStyle(color: Colors.white54)),

                ),

              ),
              SizedBox(height: 25),

              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () async {
                  //setState(() {
                  var todoObject = Todo();
                  todoObject.datedebut =  _datecontroller.text;
                  todoObject.datefin= _datecontroller1.text;
                  todoObject.quantite= _quantitecontroller.text;

                  var _todoService = TodoService();
                  var  result = await _todoService.saveTodo(todoObject);

                  print(result);

                  // });
                },
                color: Colors.teal[200],
                child: Text(
                  'Enregistrer',
                  style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),

              ), SizedBox(height: 15),
              Container(

                child: MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,

                  onPressed: (){




                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text('ATTENTION'),
                        content: Text('Vous Ne Pouvez Plus Modifier Les Données aprés Validation'),
                        actions: <Widget>[
                          FlatButton(child: Text('Oui'),color: Colors.greenAccent,onPressed:(


                              ){
                            setState(() {
                              enabled=false;
                            });
                            Navigator.of(context).pop(AlertDialog);
                          },
                          ),
                          FlatButton(child: Text('Non'),color: Colors.amber,onPressed:() => Navigator.of(context).pop(AlertDialog),
                          )
                        ],
                      );
                    });
                  },


                  color: Colors.amber,
                  child: Text(
                    'Valider',
                    style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),

                ),
              ),

            ],


          ),

        ),
      ),
    );

  }


}


