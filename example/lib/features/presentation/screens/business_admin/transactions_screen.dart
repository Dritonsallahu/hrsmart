import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Jemi duke pergaditur versionin e radhes me perditesimet e fundit, "
            "shpresojme mirekuptimin tuaj. ",
        style: GoogleFonts.nunito(fontSize: 20), textAlign: TextAlign.center,),
    );
  }
}
