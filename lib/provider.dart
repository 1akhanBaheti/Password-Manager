import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_cred/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Providerr extends ChangeNotifier {
  int signup_signin_index = 0;
  bool darkMode = false;
  SharedPreferences? prefs;

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
    darkMode = value;
    notifyListeners();
  }

  Future getAllPasswords() async {

    try {
    var _response = await http.get(Uri.parse(Apis.allPasswords));
     
    }catch (error) {
      rethrow;
    }
   
  }
}
