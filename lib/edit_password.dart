import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class EditPassword extends ConsumerStatefulWidget {
  const EditPassword({super.key});

  @override
  ConsumerState<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends ConsumerState<EditPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit",
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outlined,
                color: Colors.red,
              ))
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 15, 15),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        'Adobe',
                        style: GoogleFonts.ptSans(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        'Lakhanbaheti@gmail.com',
                        style: GoogleFonts.ptSans(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'website',
                    style: GoogleFonts.ptSans(
                      fontSize: 19,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(
                            Uri.parse(
                              "adobe.com".startsWith("https://")
                                  ? "adobe.com"
                                  : "https://" + "adobe.com",
                            ),
                            mode: LaunchMode.platformDefault)
                        .then((value) {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 160,
                    margin: const EdgeInsets.only(top: 10, left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'adobe.com',
                      style: GoogleFonts.ptSans(
                        color: HexColor("105DFB"),
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: GoogleFonts.ptSans(
                      fontSize: 19,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 160,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'lakhanbaheti@gmail.com',
                    style: GoogleFonts.ptSans(
                      color: Colors.grey.shade500,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notes',
                    style: GoogleFonts.ptSans(
                      fontSize: 19,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 160,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Adobe Password',
                    style: GoogleFonts.ptSans(
                      color: Colors.grey.shade500,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: GoogleFonts.ptSans(
                      fontSize: 19,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 160,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ZjNWrxpBnytj',
                    style: GoogleFonts.ptSans(
                      color: Colors.grey.shade500,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("105DFB"),
                  ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Copy password",
                    style:
                        GoogleFonts.ptSans(color: Colors.white, fontSize: 17),
                  ),
                ),
                Container(
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("105DFB"),
                  ),
                  width: MediaQuery.of(context).size.width * 0.39,
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Change password",
                    style:
                        GoogleFonts.ptSans(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
