import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUseScreen extends StatelessWidget {
  const AboutUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Rreth nesh",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: getPhoneWidth(context),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: const [
            Text(
              "Ketu mund te shtoni informacione rreth biznesit",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Mundesia per shtimin e informacioneve do bete ne perditesimin e radhes",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
