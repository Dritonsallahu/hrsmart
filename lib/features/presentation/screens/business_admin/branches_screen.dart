import 'package:flutter/material.dart';
import 'package:business_menagament/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.branches,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.nextVersionMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 19, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
