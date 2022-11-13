import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AddPassword extends ConsumerStatefulWidget {
  const AddPassword({super.key, this.index = 0, this.edit = false});
  final int index;
  final bool edit;
  @override
  ConsumerState<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends ConsumerState<AddPassword> {
  var sliderValue = 8.0;
  TextEditingController generate = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController email = TextEditingController();
  int navIndex = 0;
  bool saving = false;
  double currentStrength = 0.0;
  bool numbers = false, lowecase = false, symbols = false, uppercase = false;
  bool titleEmpty = false,
      emailEmpty = false,
      wesiteUrlEmpty = false,
      passEmpty = false,
      notesEmpty = false;
  @override
  void initState() {
    if (widget.edit) {
      currentStrength =
          ref.read(Const.inst).passwordAnalysis.strengths[widget.index];
      var data = ref.read(Const.inst).passwords[widget.index];
      generate.text = data["dec_password"];
      generate.selection = TextSelection.fromPosition(
          TextPosition(offset: generate.text.length));
      title.text = data["title"] ?? '';
      title.selection =
          TextSelection.fromPosition(TextPosition(offset: title.text.length));
      email.text = data["site_username"] ?? '';
      email.selection =
          TextSelection.fromPosition(TextPosition(offset: email.text.length));
      website.text = data["site_url"] ?? '';
      website.selection =
          TextSelection.fromPosition(TextPosition(offset: website.text.length));
      notes.text = data["description"] ?? '';
      notes.selection =
          TextSelection.fromPosition(TextPosition(offset: notes.text.length));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map i = {};
    List j = [];

    var prov = ref.read(Const.inst);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add password",
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 2,
                color:
                    prov.darkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 15, bottom: titleEmpty ? 20 : 0),
                    child: Text(
                      'Title',
                      style: GoogleFonts.ptSans(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isNotEmpty && titleEmpty) {
                                setState(() {
                                  titleEmpty = false;
                                });
                              }
                              if (title.text.trim().length == 1 ||
                                  title.text.trim().length == 0)
                                setState(() {});
                            },
                            controller: title,
                            style:
                                GoogleFonts.ptSans(color: Colors.grey.shade500),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 11)),
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.bottom,
                          )),
                      titleEmpty
                          ? Container(
                              margin: const EdgeInsets.only(
                                left: 0,
                                right: 15,
                              ),
                              child: Text(
                                '*required',
                                style: GoogleFonts.ptSans(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          right: 20, left: 20, bottom: titleEmpty ? 20 : 0),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                          color: title.text.isNotEmpty
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 14,
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    child: Text(
                      'Email',
                      style: GoogleFonts.ptSans(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextFormField(
                        onChanged: (value) {
                          if (email.text.trim().length == 1 ||
                              email.text.trim().isEmpty) {
                            setState(() {});
                          }
                        },
                        controller: email,
                        style: GoogleFonts.ptSans(color: Colors.grey.shade500),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 11)),
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.bottom,
                      )),
                  Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                          color: email.text.isNotEmpty
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 14,
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin:  EdgeInsets.only(
                      left: 20,
                      right: 15,
                      bottom: wesiteUrlEmpty ? 20 : 0
                    ),
                    child: Text(
                      'website',
                      style: GoogleFonts.ptSans(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextFormField(
                            onChanged: (value) {
                              if (website.text.trim().length == 1 ||
                                  website.text.trim().isEmpty) {
                                setState(() {});
                              }
                            },
                            controller: website,
                            style:
                                GoogleFonts.ptSans(color: Colors.grey.shade500),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 11)),
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.bottom,
                          )),
                      !website.text.startsWith("https://") && wesiteUrlEmpty
                          ? Container(
                              margin: const EdgeInsets.only(
                                left: 0,
                                right: 15,
                              ),
                              child: Text(
                                '*Not valid',
                                style: GoogleFonts.ptSans(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Container(
                      margin:  EdgeInsets.only(right: 20, left: 20,bottom: wesiteUrlEmpty ? 20 : 0),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                          color: website.text.isNotEmpty
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 14,
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    child: Text(
                      'Notes',
                      style: GoogleFonts.ptSans(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextFormField(
                        controller: notes,
                        onChanged: (value) {
                          if (notes.text.trim().length == 1 ||
                              notes.text.trim().isEmpty) {
                            setState(() {});
                          }
                        },
                        style: GoogleFonts.ptSans(color: Colors.grey.shade500),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 11)),
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.bottom,
                      )),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        color:
                            notes.text.isNotEmpty ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 14,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 35),
                height: 2,
                color: Colors.grey.shade300,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Password',
                  style: GoogleFonts.ptSans(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextFormField(
                  controller: generate,
                  onChanged: (value) {
                    if (passEmpty && value.isNotEmpty) {
                      setState(() {
                        passEmpty = false;
                      });
                    }
                    if (value.isNotEmpty) {
                      setState(() {
                        currentStrength =
                            prov.estimateBruteforceStrength(value);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: generate.text));
                      },
                      child: Container(
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(11),
                          child: SvgPicture.asset(
                            "assets/nav1.svg",
                            color: prov.darkMode ? HexColor("105DFB") : null,
                          )),
                    ),
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: prov.darkMode
                        ? const Color.fromRGBO(16, 93, 251, 0.2)
                        : Colors.grey.shade200,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: LinearPercentIndicator(
                  percent: currentStrength,
                  progressColor: currentStrength >= 0.0 &&
                          currentStrength <= 0.25
                      ? Colors.red
                      : currentStrength >= 0.26 && currentStrength <= 0.5
                          ? Colors.amber
                          : currentStrength >= 0.51 && currentStrength <= 0.75
                              ? HexColor("105DFB")
                              : Colors.green,
                  backgroundColor: Colors.grey.shade200,
                  width: MediaQuery.of(context).size.width - 20,
                ),
              ),
              passEmpty
                  ? Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 15,
                      ),
                      child: Text(
                        '*required',
                        style: GoogleFonts.ptSans(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      'Length',
                      style: GoogleFonts.ptSans(
                          fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Text(sliderValue.floor().toString()),
                    ),
                    SfSlider(
                      stepSize: 1,
                      //divisions: 1,
                      thumbIcon: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: HexColor("105DFB"), width: 2.4),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      inactiveColor: Colors.grey.shade500,
                      //thumbColor: Colors.white,
                      activeColor: HexColor("105DFB"),
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                      min: 6,
                      max: 32,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Numbers',
                      style: GoogleFonts.ptSans(
                          fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                      value: numbers,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onChanged: (value) {
                        setState(() {
                          numbers = !numbers;
                        });
                      },
                      fillColor: MaterialStateProperty.all(HexColor("105DFB")),
                    ),
                    Text(
                      'Symbols',
                      style: GoogleFonts.ptSans(
                          fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      value: symbols,
                      onChanged: (value) {
                        setState(() {
                          symbols = !symbols;
                        });
                      },
                      fillColor: MaterialStateProperty.all(HexColor("105DFB")),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lowercase',
                      style: GoogleFonts.ptSans(
                          fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      value: lowecase,
                      onChanged: (value) {
                        setState(() {
                          lowecase = !lowecase;
                        });
                      },
                      fillColor: MaterialStateProperty.all(HexColor("105DFB")),
                    ),
                    Text(
                      'Uppercase',
                      style: GoogleFonts.ptSans(
                          fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      value: uppercase,
                      onChanged: (value) {
                        setState(() {
                          uppercase = !uppercase;
                        });
                      },
                      fillColor: MaterialStateProperty.all(HexColor("105DFB")),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        generate.text = ref.read(Const.inst).randomPassword(
                            letters: lowecase,
                            number: numbers,
                            uppercase: uppercase,
                            specialChar: symbols,
                            passwordLength: sliderValue);
                        currentStrength = ref
                            .read(Const.inst)
                            .estimateBruteforceStrength(generate.text);
                      });
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
                        "Generate",
                        style: GoogleFonts.ptSans(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (saving) return;
                      if (title.text.isEmpty ||
                          generate.text.isEmpty ||
                          (website.text.isNotEmpty &&
                              !website.text.startsWith("https://"))) {
                        if ((website.text.isNotEmpty &&
                            !website.text.startsWith("https://"))) {
                          wesiteUrlEmpty = true;
                        }
                        if (generate.text.isEmpty) {
                          passEmpty = true;
                        }
                        if (title.text.isEmpty) {
                          titleEmpty = true;
                        }
                        setState(() {});
                        return;
                      } else {
                        setState(() {
                          saving = true;
                        });
                        if (widget.edit) {
                          var url;
                          if (website.text.isNotEmpty)
                            url = await FaviconFinder.getBest(website.text);
                          await prov.editPassword({
                            "title": title.text,
                            "password": generate.text,
                            if (notes.text.isNotEmpty)
                              "description": notes.text,
                            if (email.text.isNotEmpty)
                              "site_username": email.text,
                            if (website.text.isNotEmpty)
                              "site_url": website.text,
                            if (website.text.isNotEmpty && url != null)
                              "meta": {"url": url.url},
                          }, widget.index).then((value) {
                            Fluttertoast.showToast(
                                  msg: 'Updated!',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white);
                            Navigator.pop(context);
                          }).catchError((error) {
                            Fluttertoast.showToast(
                                  msg: 'Something went wrong!',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white);
                          
                          });
                          setState(() {
                            saving = false;
                          });
                        } else {
                          var url;
                          if (website.text.isNotEmpty)
                            url = await FaviconFinder.getBest(website.text);

                          print(url?.url);
                          await prov.savePassword({
                            "title": title.text,
                            "password": generate.text,
                            if (notes.text.isNotEmpty)
                              "description": notes.text,
                            if (email.text.isNotEmpty)
                              "site_username": email.text,
                            if (website.text.isNotEmpty)
                              "site_url": website.text,
                            if (website.text.isNotEmpty && url != null)
                              "meta": {"url": url.url},
                          }).then((value) {
                             Fluttertoast.showToast(
                                  msg: 'Saved!',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white);
                      
                            Navigator.pop(context);
                          }).catchError((error) {
                            print(error.toString());
                            Fluttertoast.showToast(
                                  msg: 'Something went wrong!',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white);
                          });

                          setState(() {
                            saving = false;
                          });
                        }
                      }
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
                      child: saving
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              "Save password",
                              style: GoogleFonts.ptSans(
                                  color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ],
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
