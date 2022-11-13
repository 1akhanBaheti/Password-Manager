import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/add_password.dart';
import 'package:my_cred/const.dart';
import 'package:url_launcher/url_launcher.dart';

class EditPassword extends ConsumerStatefulWidget {
  const EditPassword({super.key, required this.index});
  final int index;
  @override
  ConsumerState<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends ConsumerState<EditPassword> {
  bool deleting = false;
  @override
  Widget build(BuildContext context) {
    var prov = ref.read(Const.inst);
    return Scaffold(
      backgroundColor: prov.darkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit",
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                if (!deleting) {
                  setState(() {
                    deleting = true;
                  });
                  prov.deletePassword(widget.index).then((value) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'Deleted!');
                  }).catchError((error) {
                    setState(() {
                      deleting = false;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Something went wrong!')));
                    });
                  });
                }
              },
              icon: const Icon(
                Icons.delete_outlined,
                color: Colors.red,
              ))
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 15, 15),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            image: prov.passwords[widget.index]["meta"]
                                        ["url"] !=
                                    null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        prov.passwords[widget.index]["meta"]
                                            ["url"]))
                                : null,
                            borderRadius: BorderRadius.circular(70)),
                        child:
                            prov.passwords[widget.index]["meta"]["url"] == null
                                ? Icon(Icons.password_outlined)
                                : null),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            prov.passwords[widget.index]["title"],
                            style: GoogleFonts.ptSans(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          child: Text(
                            prov.passwords[widget.index]["site_username"] ?? '',
                            style: GoogleFonts.ptSans(
                              color: Colors.grey.shade500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                  prov.passwords[widget.index]["site_url"]
                                              .toString()
                                              .startsWith("https://") ||
                                          prov.passwords[widget.index]
                                                  ["site_url"]
                                              .toString()
                                              .startsWith("http://")
                                      ? prov.passwords[widget.index]["site_url"]
                                      : "https://${prov.passwords[widget.index]["site_url"]}",
                                ),
                                mode: LaunchMode.platformDefault)
                            .then((value) {});
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 160,
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          prov.passwords[widget.index]["site_url"] ?? '',
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
                        prov.passwords[widget.index]["site_username"] ?? '',
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
                        prov.passwords[widget.index]["description"] ?? '',
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
                        prov.passwords[widget.index]["dec_password"].toString(),
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
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'copied!',
                            textColor: Colors.black,
                            backgroundColor: Colors.grey.shade100);
                      },
                      child: Container(
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
                          style: GoogleFonts.ptSans(
                              color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => AddPassword(
                                  edit: true,
                                  index: widget.index,
                                ))));
                      },
                      child: Container(
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
                          style: GoogleFonts.ptSans(
                              color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            deleting?Container(
                 width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height,
                    color: Colors.white.withOpacity(0.5),
            ):Container(),
            deleting
                ? Center(
                  child: Container(
                  
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(),
                      ),
                )
                : Container()
          ],
        ),
      ),
    );
  }
}
