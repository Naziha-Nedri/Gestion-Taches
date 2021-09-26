import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'Constants.dart';
import 'package:flutter/foundation.dart';
import 'ExercModel.dart';
import 'TacheModel.dart';
import 'UnitModel.dart';

class AuthenticationService {
  Future<dynamic> getSessionIdFromHomePage() async {
    var response;
    try {
      response = await http
          .get(Uri.parse("http://10.0.2.2:8080/BigSoftWeb/"))
          .timeout(const Duration(seconds: 15));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    try {
      var sessionId = response.headers["set-cookie"].split(";").first;
      print(sessionId);
      return sessionId;
    } catch (_) {
      return "Une erreur est survenu lors du chargement des données. Contactez votre administrateur";
    }
  }

  Future<dynamic> login({
    @required String domain,
    @required String username,
    @required String password,
  }) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("http://10.0.2.2:8080/BigSoftWeb/AuthAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionID,
        },
        body: {
          "action": "select",
          "domaine": domain,
          "user": username,
          "mpasse": password,
          "lang": "fr",
          "isCheckedAD": "0",
          "CodeUnit": "",
          "CodeExc": "",
          "AnneeExc": "",
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return "Une erreur est survenu lors du chargement des données. Contactez votre administrateur";
    }
    var isAuthenticationSuccess = json.decode(response.body)["success"];
    if (isAuthenticationSuccess) {
      return isAuthenticationSuccess;
    } else {
      var authenticationFeedbackMessage =
          json.decode(response.body)["feedback"];
      return authenticationFeedbackMessage;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////
  Future<dynamic> getUnite() async {
    var response;
    try {
      response = await http.post(
        Uri.parse("http://10.0.2.2:8080/BigSoftWeb/UniteAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionID,
        },
        body: {
          "sort": "CodeUnit",
          "dir": "ASC",
          "action": "selectLine",
          "TypeObj": "Conn",
          "useCache": "true",
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }

    if (response.contentLength == 0) {
      return 0;
    }

    var uniteResponse = UniteResults.fromJson(
      json.decode(response.body),
    );
    return uniteResponse.results;
  }

  Future<dynamic> getExercice() async {
    var response;
    try {
      response = await http.post(
        Uri.parse("http://10.0.2.2:8080/BigSoftWeb/ExcAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionID,
        },
        body: {
          "sort": "CodeExc",
          "dir": "ASC",
          "action": "select",
          "useCache": "true",
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    if (response.contentLength == 0) {
      return 0;
    }
    var exerciceResponse = ExerciceResults.fromJson(
      json.decode(response.body),
    );
    return exerciceResponse.results;
  }

  Future<dynamic> validateSessionAndFinishLoginProcess({
    @required domaine,
    @required username,
    @required password,
    @required codeUnite,
    @required codeExercice,
    @required anneeExercice,
  }) async {
    var response;
    try {
      response = await http.post(
        Uri.parse("http://10.0.2.2:8080/BigSoftWeb/AuthAction"),
        headers: <String, String>{
          "Cookie": Constants.sessionID,
        },
        body: {
          "action": "selectPack",
          "domaine": domaine,
          "user": username,
          "mpasse": password,
          "lang": "fr",
          "isCheckedAD": "0",
          "CodeUnit": codeUnite,
          "CodeExc": codeExercice,
          "AnneeExc": anneeExercice
        },
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return "Cette requette a pris un temps inattendu";
    } on SocketException catch (_) {
      return "Vérifier la configuration de votre réseau";
    }
    print(response.contentLength);
    if (response.contentLength == 0 || response.contentLength == 17) {
      return 0;
    }
    var isValidateSessionSuccess = json.decode(response.body)["success"];
    print(isValidateSessionSuccess);
    if (isValidateSessionSuccess) {
      return isValidateSessionSuccess;
    }
  }
}
/*Future<dynamic> getTache() async {
  // @required int CodeExc;
  var response;
  try {
    response = await http.post(
      Uri.parse("http://10.0.2.2:8080/BigSoftWeb/gtach/TacheAction"),
      headers: <String, String>{
        "Cookie": Constants.sessionID,
      },
      body: {
        "start": "0",
        "limit": "25",
        "sort": "",
        "dir": "ASC",
        "action": "select",
        "code": "",
        "CGrp": ""
      },
    ).timeout(const Duration(seconds: 30));
  } on TimeoutException catch (_) {
    return "Cette requette a pris un temps inattendu";
  } on SocketException catch (_) {
    return "Vérifier la configuration de votre réseau";
  }
  if (response.contentLength == 0) {
    return 0;
  }
  var tacheResponse = TacheResults.fromJson(
    json.decode(response.body),
  );
  return tacheResponse.results;
}
Future<dynamic> getREAL() async {
  var response;
  try {
    response = await http.post(
        Uri.parse("http://10.0.2.2:8080/BigSoftWeb/gtach/RealAction"),
        headers: <String, String>{
        "Cookie": Constants.sessionID,
        },
      body: {
    "start":"0",
    "limit" : "25",
    "sort":"",
    "dir": "ASC",
    "action": "selectLine"
      },
    ).timeout(const Duration(seconds: 30));
  } on TimeoutException catch (_) {
    return "Cette requette a pris un temps inattendu";
  } on SocketException catch (_) {
    return "Vérifier la configuration de votre réseau";
  }
  if (response.contentLength == 0) {
    return 0;
  }
  var tacheResponse = TacheResults.fromJson(
    json.decode(response.body),
  );
  return tacheResponse.results;
}
*/