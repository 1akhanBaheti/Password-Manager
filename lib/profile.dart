import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/onboarding_screen.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  var index =Random().nextInt(8);

  @override
  Widget build(BuildContext context) {
    if(index==0)
    index++;
    var prov = ref.watch(Const.firebase);
    return Scaffold(
      floatingActionButton: SizedBox(
        child: GestureDetector(
          onTap: () {
            prov.prefs!.clear();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => Onboarding()),
                (route) => false);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.red)),
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
            margin: const EdgeInsets.only(bottom: 35, right: 15),
            child: Text(
              'Logout',
              style: GoogleFonts.ptSans(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      backgroundColor: prov.darkMode ? null : Colors.white,
      body: SizedBox(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            Image.asset("assets/persons/person$index.png").image)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 15,
              ),
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: GoogleFonts.ptSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 15),
              child: Text(
                 FirebaseAuth.instance.currentUser!.email!,
                style: GoogleFonts.ptSans(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: Text(
                    'Dark Mode',
                    style: GoogleFonts.ptSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Switch(
                  value: prov.darkMode,
                  onChanged: (value) {
                    prov.setDarkMode(value);
                  },
                  activeColor: HexColor("105DFB"),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
