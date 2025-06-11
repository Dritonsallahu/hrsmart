import 'package:hr_smart/features/presentation/screens/business_admin/employees_list_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/new_employee.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/add_new_cost_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'chart2.dart';
import 'chartS.dart';
import '../features/presentation/screens/business_admin/business_admin_navigation.dart';

class MbyllDiten extends StatefulWidget {
  const MbyllDiten({Key? key}) : super(key: key);

  @override
  State<MbyllDiten> createState() => _MbyllDitenState();
}

class _MbyllDitenState extends State<MbyllDiten> {
  final GlobalKey<ScaffoldState> scaffoldKe = GlobalKey<ScaffoldState>();
  TextEditingController dateinput = TextEditingController();
  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openEndDrawer() {
    scaffoldKe.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKe,
      appBar: AppBar(
        backgroundColor: Colors.white, // <-- this
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
          "Mbyll diten",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: false,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width - 40,
                child: TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down), //icon of text field

                      hintText: "00/00/0000",
                      filled: true,
                      fillColor: Color.fromRGBO(235, 235, 235, 1),
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 24, 51, 0.22),
                          fontSize: 16,
                          fontWeight: FontWeight.w300)),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: const TextField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: false, signed: true),
                decoration: InputDecoration(
                    hintText: 'Vlera mbyllese',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromRGBO(235, 235, 235, 1)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(

                child: const TextField(
                  textInputAction: TextInputAction.send,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromRGBO(235, 235, 235, 1)),
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Mbyll'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(50, 74, 89, 1))),
              ),
            )
          ],
        ),
      ),

    );
  }

  Widget bilanci() {
    return Container(
      width: 80,
      height: 44,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(142, 255, 155, 0.44),
          borderRadius: BorderRadius.circular(10)),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "BILANCI",
              style: TextStyle(
                  color: Color.fromRGBO(17, 62, 33, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: Text(
              "100€",
              style: TextStyle(
                  color: Color.fromRGBO(51, 229, 69, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
