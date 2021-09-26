import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/ExercModel.dart';
import 'package:flutter_app/Task.dart';
import 'package:flutter_app/login_service.dart';
import 'package:flutter/services.dart';
import 'Constants.dart';
import 'UnitModel.dart';

class ExerciceUnite extends StatefulWidget {
  @override
  _ExerciceUniteState createState() => _ExerciceUniteState();
}

class _ExerciceUniteState extends State<ExerciceUnite> {
  final unitecontroller = new TextEditingController();
  final anneExercicevontroller = new TextEditingController();

  //final exercicecontroller = new TextEditingController();
  final domaineController = new TextEditingController();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();

  AuthenticationService authenticationService = AuthenticationService();
  String code;
  String anneeExc;

  List<UniteModel> _uniteResultsList;
  List<ExerciceModel> _exerciceResultsList;
  UniteModel _uniteDropdownFieldValue;
  ExerciceModel _exerciceDropdownFieldValue;

  @override
  void initState() {
    super.initState();
    _uniteResultsList = [];
    _exerciceResultsList = [];
    getUniteAndExercice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset:false,
      body: Container(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            child: Stack(children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff182D33),
                          Color(0xff182D33),
                          Color(0xff182D33),
                          Color(0xff182D33),
                        ])),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'B.I.G\n',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 50,
                                      decoration: TextDecoration.none)),
                              TextSpan(
                                  text: ' Informatique',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      decoration: TextDecoration.none)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        unite(),
                        SizedBox(height: 20),
                        exercice(),
                        SizedBox(height: 40),
                        buildLogin(),
                        SizedBox(height: 90),
                        buildFooter(),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget unite() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.blueGrey,
      ),
      child: DropdownButtonFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          helperText: ' ',
          errorBorder: OutlineInputBorder(


          ),
          focusedErrorBorder: OutlineInputBorder(


          ),
          labelText: "Unité",
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.grey[400],
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:Colors.lightBlueAccent,
            ),

          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent),

          ),
        ),
        value: _uniteDropdownFieldValue,
        items: _uniteResultsList.map((value) {
          return DropdownMenuItem(
            child: Text(value.libelleUnit),
            value: value,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _uniteDropdownFieldValue = value;
          });
        },
        validator: (value) => dropdownFieldValidation(
          value,
          "Veuillez sélectionner l'unité",
        ),
      ),
    );
  }

  String dropdownFieldValidation(value, validationMessage) =>
      value == null ? validationMessage : null;

  Widget exercice() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.blueGrey,
      ),
      child: DropdownButtonFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          helperText: ' ',

          focusedErrorBorder: OutlineInputBorder(


          ),
          labelText: "Exercice",
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.grey[400],
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlueAccent,
            ),

          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent),

          ),
        ),
        value: _exerciceDropdownFieldValue,
        items: _exerciceResultsList.map((value) {
          return DropdownMenuItem(
            child: Text(value.libelleExc),
            value: value,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _exerciceDropdownFieldValue = value;
          });
        },
        validator: (value) => dropdownFieldValidation(
          value,
          "Veuillez sélectionner l'exercice",
        ),
      ),
    );
  }

  Widget buildLogin() {
    return Container(
      child: MaterialButton(
        elevation: 0,
        minWidth: double.maxFinite,
        height: 50,
        //////////////////////////////////////////////////////////////////////////////////
        onPressed: () async {
          Constants.codeUnite = _uniteDropdownFieldValue.codeUnit;
          Constants.libelleUnie = _uniteDropdownFieldValue.libelleUnit;
          Constants.codeExercice = _exerciceDropdownFieldValue.codeExc;
          Constants.anneeExercice = _exerciceDropdownFieldValue.anneeExc;
          Constants.libelleExercice = _exerciceDropdownFieldValue.libelleExc;
          print(Constants.domaine);
          print(Constants.username);
          print(Constants.codeUnite);
          print(Constants.codeExercice);
          print(Constants.anneeExercice);
          print(Constants.password);
          var validateSessionResult =
          await authenticationService.validateSessionAndFinishLoginProcess(
            domaine: Constants.domaine,
            username: Constants.username,
            password: Constants.password,
            codeUnite: Constants.codeUnite,
            codeExercice: Constants.codeExercice,
            anneeExercice: Constants.anneeExercice,
          );
          if (validateSessionResult is bool) {
            Navigator.push(
              context,

              MaterialPageRoute(builder: (context) => TaskView()),
            );
          }
        },
        //////////////////////////////////////////////////////////////////////////////////
        color: Color(0xff25bcbb),
        child: Text(
          'Entrer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'BigMobileTask',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xffAFE9DD),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  void getUniteAndExercice() async {
    var _uniteResult = await authenticationService.getUnite();
    if (_uniteResult is List<UniteModel>) {
      _uniteResultsList = _uniteResult;
      var _exerciceResult = await authenticationService.getExercice();
      if (_exerciceResult is List<ExerciceModel>) {
        _exerciceResultsList = _exerciceResult;
      }
    }
    setState(() {});
  }
}
