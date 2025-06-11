import 'package:hr_smart/core/consts/dimensions.dart';
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
          // GestureDetector(
          //   onTap: () {
          //     showModalBottomSheet(
          //         context: context,
          //         backgroundColor: Colors.transparent,
          //         builder: (context) {
          //           return const BusinessListModal();
          //         });
          //   },
          //   child: Container(
          //     color: Colors.transparent,
          //     width: getPhoneWidth(context) * 0.85,
          //     child: TextField(
          //       style: GoogleFonts.poppins(
          //           color: Colors.white),
          //       cursorHeight: 20,
          //       enabled: false,
          //       decoration: InputDecoration(
          //           suffixIcon: const Icon(
          //             Icons.arrow_drop_down_sharp,
          //             color: Color(0xffE4D5C9),
          //             size: 30,
          //           ),
          //           hintText: "Un punoj ne",
          //           hintStyle: GoogleFonts.poppins(
          //               color: const Color(0xffE4D5C9),
          //               fontWeight: FontWeight.w300,
          //               fontSize: 15),
          //           border: InputBorder.none,
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius:
          //                 BorderRadius.circular(100),
          //             borderSide: const BorderSide(
          //               color: Color(0xffE4D5C9),
          //             ),
          //           ),
          //           disabledBorder: OutlineInputBorder(
          //             borderRadius:
          //                 BorderRadius.circular(100),
          //             borderSide: const BorderSide(
          //               color: Color(0xffE4D5C9),
          //             ),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderRadius:
          //                 BorderRadius.circular(100),
          //             borderSide: const BorderSide(
          //               color: Color(0xffE4D5C9),
          //             ),
          //           ),
          //           isDense: true,
          //           contentPadding:
          //               const EdgeInsets.symmetric(
          //                   horizontal: 20,
          //                   vertical: 10)),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          SizedBox(
            width: getPhoneWidth(context) * 0.85,
            child: TextField(controller: username,
              style: GoogleFonts.poppins(
                  color: Colors.white),
              cursorHeight: 20,
              decoration: InputDecoration(
                  hintText: "Emri perdoruesit",
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
            child: TextField(controller: password,
              style: GoogleFonts.poppins(
                  color: Colors.white),
              cursorHeight: 20,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Fjalekalimi",
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
