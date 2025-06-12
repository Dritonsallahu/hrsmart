import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidgets extends StatelessWidget {
  final TextEditingController? username;
  final TextEditingController? password;
  const LoginWidgets({Key? key, this.username, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      width: getPhoneWidth(context),
      child: Column(
        children: [

          SizedBox(
            width: getPhoneWidth(context) * 0.85,
            child: TextField(controller: username,
              style: GoogleFonts.poppins(
                  color: Color(0xff1a2836)),
              cursorHeight: 20,
              decoration: InputDecoration(
                  hintText: "Emri perdoruesit",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff1a2836),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xc08ea2b4),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xc21a2836),
                    ),
                  ),
                  isDense: true,
                  contentPadding:
                  const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: getPhoneWidth(context) * 0.85,
            child: TextField(controller: password,
              style: GoogleFonts.poppins(
                  color: Color(0xff1a2836)),
              cursorHeight: 20,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Fjalekalimi",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff1a2836),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xc08ea2b4),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xc21a2836),
                    ),
                  ),
                  isDense: true,
                  contentPadding:
                  const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10)),
            ),
          ),
        ],
      ),
    );
  }
}
