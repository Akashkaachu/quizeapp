// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quizeapp/display.dart';

class SplashScrn extends StatefulWidget {
  const SplashScrn({super.key});

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

bool userlogged = false;

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    splashTime(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 247, 247),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: size.width,
            height: size.height / 2,
            child: Image.asset(
              filterQuality: FilterQuality.medium,
              "assets/animations/Exams-bro.png",
            ),
          ),
          const SizedBox(height: 15),
          Text("Welcome to Amazing World of Quiz App",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.bold)),
          Lottie.asset("assets/animations/Animation - 1706354107964 (1).json",
              width: size.width / 2, height: size.height / 2)
        ]),
      ),
    );
  }

  void splashTime(BuildContext contex) async {
    await Future.delayed(const Duration(milliseconds: 3500));

    Navigator.of(contex).pushReplacement(
        MaterialPageRoute(builder: (context) => const DisplayPge()));
  }
}
