import 'dart:io';

import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/widgets/employee_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  final GlobalKey<ScaffoldState> scaffKe = GlobalKey<ScaffoldState>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  TextEditingController dateinput = TextEditingController();

  TextEditingController search = TextEditingController();

  List<EmployeeModel> employees = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getEmployees();
    });

    super.initState();
  }

  getEmployees(){
    var businessProvider =
    Provider.of<BusinessProvider>(context, listen: false);
    businessProvider.getAllEmployees(context);
  }

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 246, 249, 1),
      key: scaffKe,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: FlipCard(
          key: cardKey, flipOnTouch: false,
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.VERTICAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Text(
            "Lista e punetorve",
            style: GoogleFonts.poppins(fontSize: 17),
          ),
          back: Platform.isAndroid
              ? Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
                  ),
                )
              : CupertinoTextField(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Color(0xffe3e5ea))),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  cardKey.currentState!.toggleCard();
                },
                icon: Icon(Icons.search)),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: () async {
            getEmployees();
          },
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: EmployeeListCard(
                  employee: businessProvider.getEmployeeList()[index]),
            ),
            itemCount: businessProvider.getEmployeeList().length,
          ),
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

  List<Employe> fetchEmploye() {
    return [
      Employe(name: 'Diarti', date: '00/00/2023', paga: '5000'),
      Employe(name: 'Albioni', date: '00/00/2023', paga: '3000'),
      Employe(name: 'Akil', date: '00/00/2023', paga: '3000'),
      Employe(name: 'Veton', date: '00/00/2023', paga: '3000'),
      Employe(name: 'Adhurim', date: '00/00/2023', paga: '3000'),
      Employe(name: 'Orges', date: '00/00/2023', paga: '3000'),
    ];
  }
}

class Employe {
  String? name;
  String? date;
  String? paga;

  Employe({required this.name, required this.date, required this.paga});
}
