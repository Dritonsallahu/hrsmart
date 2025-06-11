import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showErroModal(context, String errorTitle, {double? size}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
            width: getPhoneWidth(context),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    errorTitle,
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.poppins(fontSize: size ?? 20, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Largo"))
                ],
              ),
            ),
          ),
        );
      });
}
