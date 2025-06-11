import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidgets extends StatelessWidget {
  final TextEditingController? businessName;
  final TextEditingController? city;
  final TextEditingController? phoneNumber;
  final TextEditingController? comment;
  const RegisterWidgets({Key? key, this.businessName, this.city, this.phoneNumber,this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getPhoneWidth(context),
      child: Column(
        children: [
          SizedBox(
            width: getPhoneWidth(context) * 0.85,
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.white),
              cursorHeight: 20,
              controller: businessName,
              decoration: InputDecoration(
                  hintText: "Emri biznesit",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xffE4D5C9),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
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
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.white),
              cursorHeight: 20,
              controller: phoneNumber,
              decoration: InputDecoration(
                  hintText: "Numri i telefonit",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xffE4D5C9),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
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
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.white),
              cursorHeight: 20,
              controller: city,
              decoration: InputDecoration(
                  hintText: "Qyteti",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xffE4D5C9),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
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
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.white),
              cursorHeight: 20,
              maxLines: 5,
              minLines: 4,
              controller: comment,
              decoration: InputDecoration(
                  hintText: "Shto koment...",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xffE4D5C9),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color(0xffE4D5C9),
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
