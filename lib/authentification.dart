import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Constants.dart';
import 'package:flutter_app/login_service.dart';
import 'Exer_Unit.dart';

class Authentification extends StatefulWidget {
  @override
  _Authentification createState() => _Authentification();
}

class _Authentification extends State<Authentification> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final domaineController = new TextEditingController();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();

  AuthenticationService authenticationService = AuthenticationService();
  @override
  void initState() {
    super.initState();
    getSessionID();
  }

  void getSessionID() async {
    Constants.sessionID =
        await authenticationService.getSessionIdFromHomePage();
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
                          height: 50,
                        ),
                        domaine(),
                        SizedBox(height: 20),
                        buildUsername(),
                        SizedBox(height: 20),
                        buildPassword(),
                        SizedBox(height: 40),
                        buildLogin(),
                        SizedBox(height: 40),
                        buildFooter()
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

  Widget domaine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xff15282D),
            border: Border.all(color: Colors.lightBlueAccent),
          ),
          height: 60,
          child: TextField(
            controller: domaineController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                ),
                hintText: 'Domaine',
                hintStyle: TextStyle(color: Colors.white60)),
          ),
        )
      ],
    );
  }

  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xff15282D),
            border: Border.all(color: Colors.lightBlueAccent),
          ),
          height: 60,
          child: TextField(
            controller: usernameController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Utilisateur',
                hintStyle: TextStyle(color: Colors.white60)),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xff15282D),
            border: Border.all(color: Colors.lightBlueAccent),
          ),
          height: 60,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Mot de passe',
                hintStyle: TextStyle(color: Colors.white60)),
          ),
        )
      ],
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
          var requestResult = await authenticationService.login(
            domain: domaineController.text,
            username: usernameController.text,
            password: passwordController.text,
          );
          if (requestResult is bool) {
            Constants.domaine = domaineController.text;
            Constants.username = usernameController.text;
            Constants.password = passwordController.text;
            Navigator.push(
              context,
              //Create the SelectionScreen in the next step.
              MaterialPageRoute(builder: (context) => ExerciceUnite()),
            );

            // login success logic here
            print("success");
          } else {
            // show login failure here
            print(requestResult);
          }
        },

        //////////////////////////////////////////////////////////////////////////////////
        color: Color(0xff25bcbb),
        child: Text(
          'Se Connecter',
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
}
