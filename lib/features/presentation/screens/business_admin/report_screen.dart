

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Text(AppLocalizations.of(context)!.nextVersionMessage,textAlign: TextAlign.center,style: GoogleFonts.nunito(fontSize: 19,color: Colors.blueGrey),),
      ),
    );
  }
}
