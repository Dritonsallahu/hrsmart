import 'package:hr_smart/features/presentation/screens/business_admin/new_employee.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/employees_list_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/add_new_cost_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'chartS.dart';

class ShtoPuntorin2 extends StatefulWidget {
  String? puntori;
  ShtoPuntorin2({Key? key, required this.puntori}) : super(key: key);

  @override
  State<ShtoPuntorin2> createState() => _ShtoPuntorin2State();
}

class _ShtoPuntorin2State extends State<ShtoPuntorin2> {
  final GlobalKey<ScaffoldState> scaffoldK = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> fkkey = GlobalKey<FormState>();
  TextEditingController emri = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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
    scaffoldK.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldK,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Stack(
                      children: [
                        CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: Color.fromRGBO(228, 213, 201, 1),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 38.0),
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(90, 215, 103, 1),
                            maxRadius: 8,
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RadioBar',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 19),
                        ),
                        Text(
                          'Argjend Sadiku',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    bilanci(),
                    IconButton(
                        onPressed: _openEndDrawer,
                        icon: const Icon(
                          Icons.menu,
                          size: 25,
                          color: Colors.black,
                        )),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            //1.form
            Form(
              key: fkkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: const Color.fromRGBO(50, 74, 89, 1),
                            value: "Kamarier",
                            groupValue: widget.puntori,
                            onChanged: (value) {
                              setState(() {
                                widget.puntori = value;
                              });
                              if (widget.puntori == "Kamarier") {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewEmployee(newPage: true,)));
                              }
                            },
                          ),
                          const Text('Kamarier')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: const Color.fromRGBO(50, 74, 89, 1),
                              value: "Menaxher",
                              groupValue: widget.puntori,
                              onChanged: (value) {
                                setState(() {
                                  widget.puntori = value;
                                });
                              }),
                          const Text('Menaxher')
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 49,
                    child: TextFormField(
                        controller: emri,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Plotesoni emri dhe mbiemrin";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(247, 248, 251, 1),
                            filled: true,
                            hintText: "Emri dhe mbiemri",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 49,
                    child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Plotesoni username";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(247, 248, 251, 1),
                            filled: true,
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 49,
                    child: TextFormField(
                        obscureText: true,
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Plotesoni password";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(247, 248, 251, 1),
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 170,
                  ),
                  SizedBox(
                      height: 49,
                      width: MediaQuery.of(context).size.width - 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (fkkey.currentState!.validate()) {}
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(50, 74, 89, 1)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)))),
                      ))
                ],
              ),
            ),

            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 62,
        child: Row(
          children: [
            Container(
              height: 62,
              width: 260,
              padding: const EdgeInsets.only(left: 20, right: 20),
              margin: const EdgeInsets.only(bottom: 10, left: 20, right: 15),
              // padding:EdgeInsets.all(10),
              // margin:EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.99,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0.44)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 36,
                      width: 36,
                      child: IconButton(
                        icon: const Icon(
                          Icons.account_box,
                          color: Color.fromRGBO(216, 216, 216, 1),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EmployeesListScreen()));
                        },
                      )),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: IconButton(
                      icon: const Icon(
                        Icons.pie_chart,
                        color: Color.fromRGBO(216, 216, 216, 1),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BusinessChartScreen(),
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: IconButton(
                      icon: const Icon(
                        Icons.monetization_on_outlined,
                        color: Color.fromRGBO(216, 216, 216, 1),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: IconButton(
                      icon: const Icon(
                        Icons.person_add,
                        color: Color.fromRGBO(50, 74, 89, 1),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewEmployee(newPage: true,)
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 59,
              height: 59,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.99,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0.44)
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Color.fromRGBO(216, 216, 216, 1),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewCostScreen(),
                      ));
                },
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
