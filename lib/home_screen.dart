import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_cred/const.dart';
import 'package:my_cred/add_password.dart';
import 'package:my_cred/edit_password.dart';
import 'package:my_cred/profile.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage>
    with TickerProviderStateMixin {
  TabController? controller;
  var sliderValue = 8.0;
  TextEditingController generate = TextEditingController();
  TextEditingController strengthCheck = TextEditingController();
  int navIndex = 0;
  double currentStrength = 0.0;
  double currentCheckerStrength = 0.0;

  bool numbers = false, lowecase = false, symbols = false, uppercase = false;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = ref.watch(Const.inst);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: prov.darkMode ? null : Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            navIndex == 0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 70,
                    child: passwords())
                : navIndex == 1
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 70,
                        child: security())
                    : navIndex == 2
                        ? Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            height: MediaQuery.of(context).size.height - 70,
                            child: generator())
                        : Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            height: MediaQuery.of(context).size.height - 70,
                            child: const Profile()),
            Positioned(
              bottom: 0,
              child: Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                padding: const EdgeInsets.only(right: 80),
                width: MediaQuery.of(context).size.width - 16,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                  color: Color.fromRGBO(16, 93, 251, 0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            navIndex = 0;
                          });
                        },
                        icon: Icon(Icons.shield_outlined,
                            size: 26,
                            color: navIndex == 0
                                ? HexColor("105DFB")
                                : const Color.fromRGBO(16, 93, 251, 0.3))),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            navIndex = 1;
                          });
                        },
                        icon: Icon(Icons.security_outlined,
                            size: 26,
                            color: navIndex == 1
                                ? HexColor("105DFB")
                                : const Color.fromRGBO(16, 93, 251, 0.3))),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            navIndex = 2;
                          });
                        },
                        icon: Icon(Icons.lock_reset_outlined,
                            size: 28,
                            color: navIndex == 2
                                ? HexColor("105DFB")
                                : const Color.fromRGBO(16, 93, 251, 0.3))),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            navIndex = 3;
                          });
                        },
                        icon: Icon(
                          Icons.person_pin_outlined,
                          size: 26,
                          color: navIndex == 3
                              ? HexColor("105DFB")
                              : const Color.fromRGBO(16, 93, 251, 0.3),
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 15,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: prov.darkMode ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40))),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: HexColor("105DFB"),
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const AddPassword()));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  passwords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              left: 15,
              right: 15),
          child: Text(
            'Password',
            style:
                GoogleFonts.ptSans(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: TextFormField(
              cursorColor: const Color.fromRGBO(16, 93, 251, 1),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                ),
                hintText: 'search',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: const Color.fromRGBO(16, 93, 251, 0.1),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              )),
        ),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListTile(
                        title: Text(
                          'Netflix',
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        leading: Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      Image.asset("assets/netflix.png").image),
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(60)),
                        ),
                        subtitle: Text('lakhan@gmail.com',
                            style: GoogleFonts.ptSans(
                                fontSize: 13.5, color: Colors.grey.shade500)),
                        trailing: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset("assets/nav1.svg"))),
                  );
                }))
      ],
    );
  }

  security() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 15,
                left: 15,
                right: 15),
            child: Text(
              'Security',
              style:
                  GoogleFonts.ptSans(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
              child: CircularPercentIndicator(
            lineWidth: 10,
            radius: 60,
            percent: 0.82,
            animation: true,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              '82%',
              style:
                  GoogleFonts.ptSans(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            progressColor: Colors.deepPurple,
          )),
          Container(
            margin: const EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child: Text(
              '82% secured',
              style:
                  GoogleFonts.ptSans(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        '82',
                        style: GoogleFonts.ptSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        'Safe',
                        style: GoogleFonts.ptSans(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        '20',
                        style: GoogleFonts.ptSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        'Weak',
                        style: GoogleFonts.ptSans(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        '12',
                        style: GoogleFonts.ptSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      child: Text(
                        'Risk',
                        style: GoogleFonts.ptSans(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
            child: Text(
              'Analysis',
              style:
                  GoogleFonts.ptSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const EditPassword()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5.0),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                                    "assets/netflix.png")
                                                .image),
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Netflix',
                                  style: GoogleFonts.lato(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Cz&nW!HBqVw#',
                                    style: GoogleFonts.ptSans(
                                        fontSize: 13.5,
                                        color: Colors.grey.shade500)),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 20,
                                width: 20,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                'Risk',
                                style: GoogleFonts.lato(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 100,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  generator() {
    var prov = ref.read(Const.inst);
    return Column(
      children: [
        TabBar(
            indicatorColor: HexColor("105DFB"),
            indicatorWeight: 4,
            labelColor: HexColor("105DFB"),
            controller: controller,
            tabs: [
              Tab(
                  child: Text(
                'Generator',
                style: GoogleFonts.ptSans(
                    color: prov.darkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
              Tab(
                  child: Text(
                'Strength checker',
                style: GoogleFonts.ptSans(
                    color: prov.darkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
            ]),
        Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color.fromRGBO(16, 93, 251, 0.1),
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Stop using unsecure passwords for your online accounts, level up with My cred. Get the most secure and difficult-to-crack passwords.',
                        style: GoogleFonts.ptSans(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Generate secure passwords',
                        style: GoogleFonts.ptSans(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        readOnly: true,
                        controller: generate,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: generate.text));
                            },
                            child: Container(
                                height: 20,
                                width: 20,
                                padding: const EdgeInsets.all(11),
                                child: SvgPicture.asset(
                                  "assets/nav1.svg",
                                  color: prov.darkMode?HexColor("105DFB"):null,
                                )),
                          ),
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          filled: true,
                          fillColor: prov.darkMode
                              ? const Color.fromRGBO(16, 93, 251, 0.2)
                              : Colors.grey.shade200,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
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
                                : currentStrength >= 0.51 &&
                                        currentStrength <= 0.75
                                    ? HexColor("105DFB")
                                    : Colors.green,
                        backgroundColor: Colors.grey.shade200,
                        width: MediaQuery.of(context).size.width - 20,
                      ),
                    ),
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
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
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
                                fontSize: 20, fontWeight: FontWeight.w500),
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
                            fillColor:
                                MaterialStateProperty.all(HexColor("105DFB")),
                          ),
                          Text(
                            'Symbols',
                            style: GoogleFonts.ptSans(
                                fontSize: 20, fontWeight: FontWeight.w500),
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
                            fillColor:
                                MaterialStateProperty.all(HexColor("105DFB")),
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
                                fontSize: 20, fontWeight: FontWeight.w500),
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
                            fillColor:
                                MaterialStateProperty.all(HexColor("105DFB")),
                          ),
                          Text(
                            'Uppercase',
                            style: GoogleFonts.ptSans(
                                fontSize: 20, fontWeight: FontWeight.w500),
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
                            fillColor:
                                MaterialStateProperty.all(HexColor("105DFB")),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(20),
                        child: Text(
                          "Generate",
                          style: GoogleFonts.ptSans(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              checker()
            ]))
      ],
    );
  }

  checker() {
    var prov = ref.read(Const.inst);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color.fromRGBO(16, 93, 251, 0.1),
          padding: const EdgeInsets.all(15),
          child: Text(
            'Recommendations made by this tool to improve password strength are generally safe but not infallible.Any password submitted here is not stored or transmitted.',
            style:
                GoogleFonts.ptSans(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            'How strong is this Password?',
            style:
                GoogleFonts.ptSans(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: TextFormField(
            maxLines: null,
            controller: strengthCheck,
            onChanged: (value) {
              setState(() {
                currentCheckerStrength =
                    ref.read(Const.inst).estimateBruteforceStrength(value);
              });
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () => Clipboard.getData("text/plain"),
                  icon: const Icon(Icons.paste_outlined)),
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
            percent: currentCheckerStrength,
            progressColor:
                currentCheckerStrength >= 0.0 && currentCheckerStrength <= 0.25
                    ? Colors.red
                    : currentCheckerStrength >= 0.26 &&
                            currentCheckerStrength <= 0.5
                        ? Colors.amber
                        : currentCheckerStrength >= 0.51 &&
                                currentCheckerStrength <= 0.75
                            ? HexColor("105DFB")
                            : Colors.green,
            backgroundColor: Colors.grey.shade200,
            width: MediaQuery.of(context).size.width - 20,
          ),
        ),
        currentCheckerStrength > 0
            ? Container(
                margin: const EdgeInsets.only(left: 15, top: 10),
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                          color: currentCheckerStrength >= 0.0 &&
                                  currentCheckerStrength <= 0.25
                              ? Colors.red
                              : currentCheckerStrength >= 0.26 &&
                                      currentCheckerStrength <= 0.5
                                  ? Colors.amber
                                  : currentCheckerStrength >= 0.51 &&
                                          currentCheckerStrength <= 0.75
                                      ? HexColor("105DFB")
                                      : Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      currentCheckerStrength >= 0.0 &&
                              currentCheckerStrength <= 0.25
                          ? "weak"
                          : currentCheckerStrength >= 0.26 &&
                                  currentCheckerStrength <= 0.5
                              ? "medium"
                              : currentCheckerStrength >= 0.51 &&
                                      currentCheckerStrength <= 0.75
                                  ? "strong"
                                  : "very strong",
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : Container(),
        strengthCheck.text.isNotEmpty
            ? Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "${strengthCheck.text.length} containing characters",
                  style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                ),
              )
            : Container()
      ],
    );
  }
}