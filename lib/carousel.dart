import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Carousell extends StatelessWidget {
   Carousell({super.key});
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
          "Stop using unsecure passwords for your online accounts, level up with Mycred. Get the most secure and difficult-to-crack passwords.",
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
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      child: PageView.builder(
          itemCount: 3,
          allowImplicitScrolling: true,
          itemBuilder: (ctx, i) {
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
          }),
    );
  }
}
