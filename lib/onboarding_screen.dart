import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/signin_screen.dart';
import 'package:my_cred/signup_screen.dart';

class Onboarding extends ConsumerWidget {
  Onboarding({super.key});
  final data = [
    {
      "title": "Everything in single click",
      "description":
          "Add, genreate, store, transfer, sync, export & copy all your passwords in single click. Use autofill for quick action without opening app.",
      "image": "assets/onboarding4.svg"
    },
    {
      "title": "Generate secure passwords",
      "description":
          "Stop using unsecure passwords for your online accounts, level up with OnePass. Get the most secure and difficult-to-crack passwords.",
      "image": "assets/onboarding5.svg"
    },
    {
      "title": "All your passwords are here.",
      "description":
          "Store and manage all of your passwords from one place. Don’t remember hundreds of passwords, just remember one.",
      "image": "assets/onboarding6.svg"
    },
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (ctx, i, j) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      
                      data[i]["image"].toString(),
                      //color: HexColor("105DFB"),
                      fit: BoxFit.cover,
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 8, top: 20, left: 15, right: 15),
                    child: Text(
                      data[i]["title"].toString(),
                      style: GoogleFonts.lato(
                          wordSpacing: 1.2,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: Text(
                      data[i]["description"].toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
                autoPlay: true, viewportFraction: 1, height: 460),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              ref.read(Const.inst).signup_signin_index = 0;
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Signup()));
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
          GestureDetector(
            onTap: (){
              ref.read(Const.inst).signup_signin_index = 1;
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Signin()));
            },
            child: Container(
              height: 45,
              margin:
                  const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: HexColor("105DFB"), width: 2),
                  borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Already have an account',
                style: GoogleFonts.lato(
                    color: HexColor("105DFB"),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
