import 'package:flutter/material.dart';

class Tache {
  String Nom;
  String datedebut;
  String datefin;
  String Code;

  Tache(
      {@required this.Nom,
        @required this.datedebut,
        @required this.Code,
        @required this.datefin,
       });
}

List<Tache> tacheList = [
  Tache(
      Nom: 'Preparation Formation',
      datedebut: 'Date Début Prévue   :    01/09/2021',
      Code :"TF01",
      datefin:   'Date Fin Prévue        :    02/09/2021'
  ),

     Tache(
     Nom: 'Formation des utilisateurs',
      datedebut: 'Date Début Prévue   :    03/09/2021',
       datefin:  'Date Fin Prévue        :    05/09/2021',
      Code :"TF02"),

Tache(
Nom: 'Validation Formation avec PV',
datedebut:       'Date Début Prévue   :    06/09/2021',
  datefin:       'Date Fin Prévue        :    06/09/2021',
Code :"TF03")

];
