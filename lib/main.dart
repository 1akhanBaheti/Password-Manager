import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: HexColor("105DFB"),
  ));
  var inst = await SharedPreferences.getInstance();
  prefs = inst;
  if (!inst.containsKey('dark')) {
    await inst.setBool("dark", false);
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    ref.read(Const.inst).prefs = prefs;
    ref.read(Const.inst).darkMode = prefs!.getBool('dark')!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(Const.inst);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My cred',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            HexColor("105DFB").value,
             <int, Color>{
              50:  Color(HexColor("105DFB").value),
              100: const Color(0xFFFFFFFF),
              200: const Color(0xFFFFFFFF),
              300: const Color(0xFFFFFFFF),
              400: const Color(0xFFFFFFFF),
              500: const Color(0xFFFFFFFF),
              600: const Color(0xFFFFFFFF),
              700: const Color(0xFFFFFFFF),
              800: const Color(0xFFFFFFFF),
              900: const Color(0xFFFFFFFF),
            },
          ),
          primaryColor: prov.darkMode ? Colors.black : Colors.white,

          backgroundColor:
              prov.darkMode ? Colors.black : const Color(0xffF1F5FB),

          indicatorColor:
              prov.darkMode ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
          // buttonColor: prov.darkMode ? const Color(0xff3B3B3B) : const Color(0xffF1F5FB),

          hintColor:
              prov.darkMode ? const Color(0xff280C0B) : const Color(0xffEECED3),

          highlightColor:
              prov.darkMode ?  Colors.transparent : Colors.transparent ,
          hoverColor:
              prov.darkMode ? const Color(0xff3A3A3B) : const Color(0xff4285F4),

          focusColor:
              prov.darkMode ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
          disabledColor: Colors.grey,
          //textSelectionColor: prov.darkMode ? Colors.white : Colors.black,
          cardColor: prov.darkMode ? const Color(0xFF151515) : Colors.white,
          canvasColor: prov.darkMode ? Colors.black : Colors.grey[50],
          brightness: prov.darkMode ? Brightness.dark : Brightness.light,
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
              colorScheme: prov.darkMode
                  ? const ColorScheme.dark()
                  : const ColorScheme.light()),
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: prov.darkMode ? Colors.black : Colors.white,
            toolbarTextStyle: GoogleFonts.ptSans(
              color: prov.darkMode ? Colors.white : Colors.black,
            ),
            iconTheme: IconThemeData(
              color: prov.darkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        themeMode: prov.darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const Splash());
  }
}
