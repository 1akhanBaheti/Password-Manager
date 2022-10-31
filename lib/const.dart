import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cred/provider.dart';

class Const {
  static ChangeNotifierProvider<Providerr> inst =
      ChangeNotifierProvider<Providerr>(((ref) => Providerr()));
  static const String token ="";
}
