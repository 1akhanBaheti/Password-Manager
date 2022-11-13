import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:my_cred/apis.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/data%20models/security.dart';
import 'package:my_cred/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Providerr extends ChangeNotifier {
  bool darkMode = false;
  SharedPreferences? prefs;
  Status getAllPasswordStatus = Status.loading;
  Status savePasswordStatus = Status.loading;
  List passwords = [];
  late Security passwordAnalysis;
  double estimateBruteforceStrength(String password) {
    if (password.isEmpty) return 0.0;

    // Check which types of characters are used and create an opinionated bonus.
    double charsetBonus;
    if (RegExp(r'^[a-z]*$').hasMatch(password)) {
      charsetBonus = 1.0;
    } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
      charsetBonus = 1.2;
    } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
      charsetBonus = 1.3;
    } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
      charsetBonus = 1.3;
    } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
      charsetBonus = 1.5;
    } else {
      charsetBonus = 1.8;
    }

    logisticFunction(double x) {
      return 1.0 / (1.0 + exp(-x));
    }

    curve(double x) {
      return logisticFunction((x / 3.0) - 4.0);
    }

    return curve(password.length * charsetBonus);
  }

  String randomPassword(
      {bool letters = true,
      bool uppercase = false,
      bool number = false,
      bool specialChar = false,
      double passwordLength = 8}) {
    if (letters == false &&
        uppercase == false &&
        specialChar == false &&
        number == false) {
      letters = true;
    }
    String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String upperCaseLetters = lowerCaseLetters.toUpperCase();
    String numbers = "0123456789";
    String special = "@#=+!£\$%&?[](){}";
    String allowedChars = "";
    allowedChars += (letters ? lowerCaseLetters : '');
    allowedChars += (uppercase ? upperCaseLetters : '');
    allowedChars += (number ? numbers : '');
    allowedChars += (specialChar ? special : '');

    int i = 0;
    String result = "";
    while (i < passwordLength.round()) {
      int randomInt = Random.secure().nextInt(allowedChars.length);
      result += allowedChars[randomInt];
      i++;
    }
    return result;
  }

  void setDarkMode(bool value) {
    prefs!.setBool("dark", value);
    darkMode = value;
    notifyListeners();
  }

  void securityAnalysis() {
    passwordAnalysis = Security(
        safe: 0,
        weak: 0,
        risk: 0,
        strengths: [],
        securityTitles: [],
        securedPercentage: 0.0);
    for (var element in passwords) {
      passwordAnalysis.strengths
          .add(estimateBruteforceStrength(element["dec_password"]));
      if (passwordAnalysis.strengths.last >= 0.0 &&
          passwordAnalysis.strengths.last <= 0.25) {
        passwordAnalysis.securityTitles.add("Risk");
        passwordAnalysis.risk++;
      } else if (passwordAnalysis.strengths.last >= 0.26 &&
          passwordAnalysis.strengths.last <= 0.5) {
        passwordAnalysis.securityTitles.add("Weak");
        passwordAnalysis.weak++;
      } else if (passwordAnalysis.strengths.last >= 0.51 &&
          passwordAnalysis.strengths.last <= 0.75) {
        passwordAnalysis.securityTitles.add("Safe");
        passwordAnalysis.safe++;
      } else {
        passwordAnalysis.securityTitles.add("Safe");
        passwordAnalysis.safe++;
      }
    }
    int total = passwordAnalysis.securityTitles.length;
    passwordAnalysis.securedPercentage =
        (passwordAnalysis.safe + (passwordAnalysis.weak / 2)) / total;
  }

  Future getAllPasswords() async {
    getAllPasswordStatus = Status.loading;
    var response = await http.get(Uri.parse(Apis.allPasswords),
        headers: {"Authorization": "Token ${Const.token}"});
    if (response.statusCode != 200) {
      getAllPasswordStatus = Status.failed;
      print("fetchfailed");
      notifyListeners();
      throw response.body;
    } else {
      passwords = [];
      passwords = json.decode(response.body);
      print("fetchDone");
      securityAnalysis();
      getAllPasswordStatus = Status.success;
      notifyListeners();
    }
  }

  Future savePassword(Map data) async {
    savePasswordStatus = Status.loading;
    print(data);
    var response = await http.post(Uri.parse(Apis.savePassword),
        headers: {
          "Authorization": "Token ${Const.token}",
          "Content-Type": "application/json",
        },
        body: json.encode(data));
    if (response.statusCode != 201) {
      print("failed");
      savePasswordStatus = Status.failed;
      notifyListeners();
      throw response.body;
    } else {
      passwords.add(json.decode(response.body));
      securityAnalysis();
      savePasswordStatus = Status.success;
      notifyListeners();
    }
  }

  Future editPassword(Map data, index) async {
    savePasswordStatus = Status.loading;
    var response = await http.patch(
        Uri.parse(Apis.editPassword
            .replaceAll('id', passwords[index]["id"].toString())),
        headers: {
          "Authorization": "Token ${Const.token}",
          "Content-Type": "application/json",
        },
        body: json.encode(data));
    if (response.statusCode != 200) {
      print(response.statusCode);
      savePasswordStatus = Status.failed;
      notifyListeners();
      throw response.body;
    } else {
      passwords[index] = (json.decode(response.body));
      securityAnalysis();
      savePasswordStatus = Status.success;
      notifyListeners();
    }
  }

  Future deletePassword(int index) async {
    var response = await http.delete(
      Uri.parse(Apis.deletePassword
          .replaceAll('id', passwords[index]["id"].toString())),
      headers: {"Authorization": "Token ${Const.token}"},
    );

    if (response.statusCode != 204) {
      print(response.statusCode);
      notifyListeners();
      throw response.body;
    } else {
      passwords.removeAt(index);
      securityAnalysis();
      notifyListeners();
    }
  }

  Future login({required String email, required String password}) async {
    var response = await http.post(
      Uri.parse(Apis.login),
      body:{"username": email, "password": password},
    );
    if (response.statusCode != 200) {
      print(response.body);
      throw response.body;
    } else {
      await prefs!.setBool("isLogged", true);
      await prefs!
          .setString("email", json.decode(response.body)["user"]["username"]);
      await prefs!
          .setString("name", json.decode(response.body)["user"]["first_name"]);
      await prefs!.setString("token", json.decode(response.body)["token"]);

      Const.email = json.decode(response.body)["user"]["username"];;
      Const.name = json.decode(response.body)["user"]["first_name"];
      Const.isLogged = true;
      Const.token = json.decode(response.body)["token"];
    }
  }

  Future register(
      {required String email,
      required String password,
      required String name}) async {
    var response = await http.post(
      Uri.parse(Apis.register),
      body: {"first_name": name, "password": password, "username": email},
    );
    if (response.statusCode != 200) {
      print(response.body);
      throw response.body;
    } else {
      await prefs!.setBool("isLogged", true);
      await prefs!
          .setString("email", json.decode(response.body)["user"]["username"]);
      await prefs!
          .setString("name", json.decode(response.body)["user"]["first_name"]);
      await prefs!.setString("token", json.decode(response.body)["token"]);
      Const.isLogged = true;
      Const.token = json.decode(response.body)["token"];
    }
  }

  List searchedList = [];
  void search(String s) {
    if (s.isEmpty) {
      notifyListeners();
      return;
    }
    searchedList = [];
    for (var element in passwords) {
      if (element["title"].toString().toLowerCase().contains(s)) {
        searchedList.add(element);
      }
    }
    notifyListeners();
  }
}
