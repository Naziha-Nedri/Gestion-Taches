import "package:flutter/material.dart";
import 'package:flutter_app/TacheModel.dart';
import 'package:flutter_app/Description.dart';
class TaskView extends StatelessWidget {
  const TaskView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        backgroundColor: Color(0xff15282d),
          appBar: AppBar(
            backgroundColor: Colors.teal[200],
            title: Text('Liste des taches',style: TextStyle(color: Colors.blueGrey[900],fontSize: 27,),),
            centerTitle: true,
          ),

          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 39),
            child: ListView.builder(

                itemCount: tacheList.length,
                itemBuilder: (context, index) {
                  Tache tache = tacheList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 25),

                    child: Card(

                      child: Container(
                        color: Color(0xff0e1c1f),

                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                        child: ListTile(
                          title: Text(tache.Nom,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                          subtitle: Text(tache.Code.toString(),style: TextStyle(color: Colors.blueGrey[300],fontSize: 16),),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(

                                builder: (context) => TacheDetailsScreen(tache)));
                            },
                          trailing: Icon(Icons.arrow_forward_rounded,color: Colors.lightBlueAccent,),

                        ),
                      ),

                    ),
                  );

                }),
          ));
    }}
