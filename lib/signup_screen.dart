import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/home_screen.dart';
import 'package:my_cred/signin_screen.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  @override
  Widget build(BuildContext context) {
    //var prov = ref.watch(Const.inst);
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
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                'Let’s get you setup with a new account!',
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
                'Name',
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              height: 45,
              margin:
                  const EdgeInsets.only(top: 0, left: 15, bottom: 15, right: 15),
              child: TextFormField( decoration:  InputDecoration(
                  
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(226, 226, 226, 1), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:  HexColor("105DFB"), width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, left: 15, bottom: 5, right: 15),
              child: Text(
                'Email',
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
               height: 45,
              margin:
                  const EdgeInsets.only(top: 0, left: 15, bottom: 15, right: 15),
              child: TextFormField(
                decoration:  InputDecoration(
                  
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(226, 226, 226, 1), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:  HexColor("105DFB"), width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 5, left: 15, bottom: 5, right: 15),
              child: Text(
                'Password',
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(
               height: 45,
              margin:
                  const EdgeInsets.only(top: 0, left: 15, bottom: 20, right: 15),
              child: TextFormField( decoration:  InputDecoration(
                  
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(226, 226, 226, 1), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:  HexColor("105DFB"), width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),),
            ),
                 InkWell(
            onTap: () {
               Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Homepage()));
            },
            child: Container(
              height: 45,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: HexColor("105DFB"),
                  borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Register',
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
           InkWell(
            onTap: (){
              ref.read(Const.inst).signup_signin_index = 0;
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Signin()));
            },
             child: Container(
              alignment: Alignment.center,
                child: Text(
                  'Already have an account?',
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
