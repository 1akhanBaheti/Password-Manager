import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_cred/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data models/security.dart';
import 'enums.dart';
import 'home_screen.dart';

class FirebaseProvider extends ChangeNotifier {
  bool darkMode = false;
  SharedPreferences? prefs;
  Status getAllPasswordStatus = Status.loading;
  Status savePasswordStatus = Status.loading;
  Status passwordDeleteStatus = Status.empty;
  List passwords = [];
  late Security passwordAnalysis;

  Future login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(error.code);
      rethrow;
    }
  }

  void notifylisteners() {
    notifyListeners();
  }

  Future register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      FirebaseFirestore.instance
          .collection("Passwords")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"name": name});
    } on FirebaseAuthException catch (error) {
      print(error.code);
      rethrow;
    }
  }

  void setDarkMode(bool value) {
    prefs!.setBool("dark", value);
    darkMode = value;
    notifyListeners();
  }

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
          .add(estimateBruteforceStrength(element["password"]));
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
    try {
      var inst = FirebaseFirestore.instance
          .collection("Passwords")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Details");
      var data = await inst.get();
      passwords = [];
      for (var element in data.docs) {
        passwords.add(element.data());
      }
      //passwords = json.decode(data.data());
      //  print(passwords.length);
      // print("fetchDone");
      securityAnalysis();
      getAllPasswordStatus = Status.success;
      notifyListeners();
    } catch (error) {
      getAllPasswordStatus = Status.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future savePassword(Map<String, dynamic> data) async {
    savePasswordStatus = Status.loading;
    print(data);
    try {
      var inst = FirebaseFirestore.instance
          .collection("Passwords")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await inst.collection("Details").doc(data["id"]).set(data);

      passwords.add(data);
      securityAnalysis();
      savePasswordStatus = Status.success;
      notifyListeners();
    } catch (error) {
      savePasswordStatus = Status.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future editPassword(Map<String, dynamic> data, index) async {
    savePasswordStatus = Status.loading;
    try {
      var inst = FirebaseFirestore.instance
          .collection("Passwords")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await inst.collection("Details").doc(data["id"]).update(data);
      passwords[index] = data;
      securityAnalysis();
      savePasswordStatus = Status.success;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      savePasswordStatus = Status.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future deletePassword(int index,BuildContext ctx) async {
    try {
      passwordDeleteStatus = Status.loading;
      notifyListeners();
      var inst = FirebaseFirestore.instance
          .collection("Passwords")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await inst.collection("Details").doc(passwords[index]["id"]).delete();
      passwords.removeAt(index);
      securityAnalysis();
       
        Fluttertoast.showToast(msg: "Deleted!");
        Navigator.pushAndRemoveUntil(ctx,
            MaterialPageRoute(builder: (ctx) => Homepage()), (route) => false);
      passwordDeleteStatus = Status.empty;
      //notifyListeners();
    } catch (error) {
      passwordDeleteStatus = Status.failed;
      notifyListeners();
      rethrow;
    }
  }
}
