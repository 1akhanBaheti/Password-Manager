import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(Const.inst);
    return Scaffold(
      floatingActionButton: SizedBox(
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
      backgroundColor: prov.darkMode?null:Colors.white,
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
                            Image.asset("assets/persons/person1.jpg").image)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 15,
              ),
              child: Text(
                'Lakhan Baheti',
                style: GoogleFonts.ptSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 15),
              child: Text(
                'Lakhan@gmail.com',
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
