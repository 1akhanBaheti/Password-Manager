import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cred/home_screen.dart';
import 'package:my_cred/onboarding_screen.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1200)).then((value) {
      if(FirebaseAuth.instance.currentUser!=null)
      {
          Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => const Homepage())));
      }
      else
      {
          Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Onboarding())));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SvgPicture.asset("assets/splash.svg"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'MY CRED',
              style:
                  GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Deveoped by',
              style: GoogleFonts.lato(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Lakhan Baheti',
              style: GoogleFonts.lato(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
