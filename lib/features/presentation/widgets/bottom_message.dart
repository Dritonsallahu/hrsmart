import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showBottomMessage(context,{String? title,String? subtitle}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
          child: Container(
            width: getPhoneWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(title ?? "No text",style: GoogleFonts.poppins(color: Colors.black,fontSize: 17),)
                ],
              ),
            ),
          ),
        );
      });
}
