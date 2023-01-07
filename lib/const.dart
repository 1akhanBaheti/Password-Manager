import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cred/firebaseProvider.dart';

class Const {
  static ChangeNotifierProvider<FirebaseProvider> firebase =
      ChangeNotifierProvider<FirebaseProvider>(((ref) => FirebaseProvider()));

}
