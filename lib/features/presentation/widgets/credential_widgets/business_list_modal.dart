import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessListModal extends StatefulWidget {
  const BusinessListModal({Key? key}) : super(key: key);

  @override
  State<BusinessListModal> createState() => _BusinessListModalState();
}

class _BusinessListModalState extends State<BusinessListModal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(maxHeight: getPhoneHeight(context) * 0.8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: getPhoneWidth(context),
        decoration: BoxDecoration(
            color: const Color(0xff1e1c1e),
            borderRadius: BorderRadius.circular(20)),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: const Color(0xffE4D5C9).withOpacity(0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: const Color(0xffE4D5C9).withOpacity(0.6),
                    ),
                  ),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/background.jpeg"))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Business One",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Ferizaj",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
