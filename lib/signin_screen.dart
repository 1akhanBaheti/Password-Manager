import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/home_screen.dart';
import 'package:my_cred/signup_screen.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  ConsumerState<Signin> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  bool loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool emailEmpty = false;
  bool passwordEmpty = false;
  @override
  Widget build(BuildContext context) {
    var prov = ref.read(Const.inst);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 25, left: 10),
                child: SvgPicture.asset(
                  "assets/star_header.svg",
                  color: HexColor("105DFB"),
                )),
            Center(
              child: Container(
                height: 60,
                width: 60,
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: SvgPicture.asset("assets/splash.svg"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 4),
              child: Text(
                'MY CRED',
                style:
                    GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15, bottom: 30),
              child: Text(
                'Let’s take you in!',
                style: GoogleFonts.lato(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, left: 15, bottom: 5, right: 15),
              child: Text(
                'Email',
                style: GoogleFonts.lato(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 0, left: 15, right: 15),
              child: TextFormField(
                controller: email,
                onChanged: (value) {
                  if (value.isNotEmpty && emailEmpty) {
                    setState(() {
                      emailEmpty = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(226, 226, 226, 1), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor("105DFB"), width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
            ),
            emailEmpty
                ? Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                    child: Text(
                      '*required',
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, left: 15, bottom: 5, right: 15),
              child: Text(
                'Password',
                style: GoogleFonts.lato(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              height: 50,
              margin:
                  const EdgeInsets.only(top: 0, left: 15, bottom: 0, right: 15),
              child: TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty && passwordEmpty) {
                    setState(() {
                      passwordEmpty = false;
                    });
                  }
                },
                controller: password,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(226, 226, 226, 1), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor("105DFB"), width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
            ),
            passwordEmpty
                ? Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 20, right: 15),
                    child: Text(
                      '*required',
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            GestureDetector(
              onTap: () async {
                if (loading) return;
                if (email.text.isEmpty || password.text.isEmpty) {
                  if (email.text.isEmpty) emailEmpty = true;
                  if (password.text.isEmpty) passwordEmpty = true;

                  setState(() {});
                } else {
                  setState(() {
                    loading = true;
                  });
                  await prov
                      .login(email: email.text, password: password.text)
                      .then((value) {
                    prov.getAllPasswords();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => const Homepage()),
                        (route) => false);
                  }).catchError((error) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("Try again later!")));
                  });
                }
              },
              child: Container(
                  height: 45,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: HexColor("105DFB"),
                      borderRadius: BorderRadius.circular(6)),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: !loading
                      ? Text(
                          'Login',
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      : const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 3,
                          ),
                        )),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const Signup()));
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Don\'t have an account?',
                  style: GoogleFonts.lato(
                      color: HexColor("105DFB"),
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
