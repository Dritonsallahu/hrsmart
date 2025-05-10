import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/strings/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidgets extends StatefulWidget {
  final TextEditingController? businessName;
  final TextEditingController? city;
  final TextEditingController? phoneNumber;
  final TextEditingController? comment;
  const RegisterWidgets({Key? key, this.businessName, this.city, this.phoneNumber,this.comment}) : super(key: key);

  @override
  State<RegisterWidgets> createState() => _RegisterWidgetsState();
}

class _RegisterWidgetsState extends State<RegisterWidgets> {

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
                  color: Colors.black),
              cursorHeight: 20,
              controller: widget.businessName,
              decoration: InputDecoration(
                  hintText: "Emri biznesit",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff1a2836),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color:  Color(0xffebedef),
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
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.black),
              cursorHeight: 20,
              controller: widget.phoneNumber,
              decoration: InputDecoration(
                  hintText: "Numri i telefonit",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff1a2836),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color:  Color(0xffebedef),
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
            child: GestureDetector(
              onTap: () {

                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Container(
                            width: getPhoneWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(cities.length, (index) {
                                  var city =
                                  cities[
                                  index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.city!.text = city;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: getPhoneWidth(context),
                                          color: Colors.transparent,
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(city,
                                                style: GoogleFonts.inter(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              Container(
                                                width: 21,
                                                height: 21,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5),
                                                    border: Border.all(
                                                        color:
                                                        Colors.blue)),
                                                padding:
                                                const EdgeInsets.all(
                                                    1.6),
                                                child: widget.city!.text.isEmpty || widget.city!.text != city
                                                    ? const SizedBox()
                                                    : Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5),
                                                      color: Colors
                                                          .blue),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      index + 1 ==
                                          cities.length
                                          ? const SizedBox()
                                          : Divider(
                                        color: Colors.grey[200],
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      });

              },
              child: Container(
                width: getPhoneWidth(context),
                height: 46,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffebedef))),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.city!.text.isEmpty
                          ? "Qyteti"
                          : widget.city!.text,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: widget.city!.text.isEmpty
                              ? const Color(0xff878787)
                              : Colors.black),
                    ),
                    SvgPicture.asset(
                          "assets/icons/arrow-down.svg",
                          width: 18,
                          color: const Color(0xff878787))
                  ],
                ),
              ),
            )
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: getPhoneWidth(context) * 0.85,
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.black),
              cursorHeight: 20,
              maxLines: 5,
              minLines: 4,
              controller: widget.comment,
              decoration: InputDecoration(
                  hintText: "Shto koment...",
                  hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff1a2836),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color:  Color(0xffebedef),
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
