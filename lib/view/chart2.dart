import 'package:business_menagament/features/presentation/screens/business_admin/employees_list_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/new_employee.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/add_new_cost_screen.dart';
import 'package:business_menagament/view/signup.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chartS.dart';
import '../features/presentation/screens/business_admin/business_admin_navigation.dart';

class ChartTwo extends StatefulWidget {
  const ChartTwo({Key? key}) : super(key: key);

  @override
  State<ChartTwo> createState() => _ChartTwoState();
}

class _ChartTwoState extends State<ChartTwo> {
  final GlobalKey<ScaffoldState> scafK = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();

  Future<void> _selectMonthAndYear(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Customize your color here
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM').format(pickedDate);
      setState(() {
        dateinput.text = formattedDate;
      });
    }
  }

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
    scafK.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(10, 0),
      ChartData(20, 34),
      ChartData(30, 32),
      ChartData(40, 80)
    ];
    final List<ChartData> chartData2 = [
      ChartData(10, 0),
      ChartData(20, 33),
      ChartData(30, 40),
      ChartData(40, 88),
    ];
    final List<ChartData> chartData3 = [
      ChartData(10, 0),
      ChartData(20, 10),
      ChartData(30, 30),
      ChartData(40, 90),
    ];
    return Scaffold(
      key: scafK,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
          bottom: false,
          child: Column(children: [
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
                )), //listtile per ndryshe appbari.
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width - 40,
              child: TextField(
                controller: dateinput,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.calendar_today),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  hintText: "YYYY-MM",
                  filled: true,
                  fillColor: Color.fromRGBO(235, 235, 235, 1),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 24, 51, 0.22),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                readOnly: true,
                onTap: () => _selectMonthAndYear(context),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 68,
                          // child: SfCartesianChart(series: <ChartSeries>[
                          //   // Renders line chart
                          //   LineSeries<ChartData, int>(
                          //     dataSource: chartData,
                          //     xValueMapper: (ChartData data, _) => data.x,
                          //     yValueMapper: (ChartData data, _) => data.y,
                          //   ),
                          //   LineSeries<ChartData, int>(
                          //     dataSource: chartData2,
                          //     xValueMapper: (ChartData data, _) => data.x,
                          //     yValueMapper: (ChartData data, _) => data.y,
                          //   ),
                          //   LineSeries<ChartData, int>(
                          //     dataSource: chartData3,
                          //     xValueMapper: (ChartData data, _) => data.x,
                          //     yValueMapper: (ChartData data, _) => data.y,
                          //   ),
                          // ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 12,
                          height: 14,
                          color: Colors.blue,
                        ),
                        const Text('Hyrje'),
                        const Text('30')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 12,
                          height: 14,
                          color: const Color.fromRGBO(255, 102, 102, 1),
                        ),
                        const Text('Hyrje'),
                        const Text('30')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 12,
                          height: 14,
                          color: const Color.fromRGBO(198, 122, 160, 1),
                        ),
                        const Text('Hyrje'),
                        const Text('30')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 12,
                          height: 14,
                          color: const Color.fromRGBO(122, 198, 155, 1),
                        ),
                        const Text('Hyrje'),
                        const Text('30')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 12,
                          height: 14,
                          color: const Color.fromRGBO(255, 178, 102, 1),
                        ),
                        const Text('Hyrje'),
                        const Text('30')
                      ],
                    ),
                  ],
                )),
          ])),
      // bottomNavigationBar: Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: 62,
      //   child: Row(
      //     children: [
      //       Container(
      //         height: 62,
      //         width: 260,
      //         padding: EdgeInsets.only(left: 20, right: 20),
      //         margin: EdgeInsets.only(bottom: 10, left: 20, right: 15),
      //         // padding:EdgeInsets.all(10),
      //         // margin:EdgeInsets.symmetric(horizontal: 24),
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   spreadRadius: 1.1,
      //                   blurStyle: BlurStyle.outer,
      //                   blurRadius: 1.30,
      //                   offset: Offset.zero)
      //             ]),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             SizedBox(
      //                 height: 36,
      //                 width: 36,
      //                 child: IconButton(
      //                   icon: Icon(
      //                     Icons.account_box,
      //                     color: Color.fromRGBO(50, 74, 89, 1),
      //                   ),
      //                   onPressed: () {},
      //                 )),
      //             SizedBox(
      //               height: 36,
      //               width: 36,
      //               child: IconButton(
      //                 icon: Icon(
      //                   Icons.pie_chart,
      //                   color: Color.fromRGBO(216, 216, 216, 1),
      //                 ),
      //                 onPressed: () {},
      //               ),
      //             ),
      //             SizedBox(
      //               height: 36,
      //               width: 36,
      //               child: IconButton(
      //                 icon: Icon(
      //                   Icons.monetization_on_outlined,
      //                   color: Color.fromRGBO(216, 216, 216, 1),
      //                 ),
      //                 onPressed: () {},
      //               ),
      //             ),
      //             SizedBox(
      //               height: 36,
      //               width:  36,
      //               child: IconButton(
      //                 icon: Icon(
      //                   Icons.person_add,
      //                   color: Color.fromRGBO(216, 216, 216, 1),
      //                 ),
      //                 onPressed: () {},
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         width: 59,
      //         height: 59,
      //         margin: EdgeInsets.only(bottom: 10),
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   spreadRadius: 1.1,
      //                   blurStyle: BlurStyle.outer,
      //                   blurRadius: 1.329,
      //                   offset: Offset.zero)
      //             ]),
      //         child: IconButton(
      //           icon: Icon(
      //             Icons.add,
      //             color: Color.fromRGBO(216, 216, 216, 1),
      //           ),
      //           onPressed: () {},
      //         ),
      //       )
      //     ],
      //   ),
      // ),
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
                boxShadow: [
                  const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.99,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0.44)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
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
                        color: Color.fromRGBO(50, 74, 89, 1),
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
                        color: Color.fromRGBO(216, 216, 216, 1),
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
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Stack(
                      children: [
                        CircleAvatar(
                          maxRadius: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 38.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.greenAccent,
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
                              fontWeight: FontWeight.w600, fontSize: 19),
                        ),
                        Text(
                          'Argjend Sadiku',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    bilanci(),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessAdminNavigation())),
                  child: const ListTile(
                    leading: Text(
                      'Administrator',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Icon(Icons.admin_panel_settings_outlined),
                  )),
              GestureDetector(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>   EmployeesListScreen())),
                  child: const ListTile(
                    leading: Text(
                      'Kartela Punetoreve',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Icon(Icons.perm_identity),
                  )),
              GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewCostScreen())),
                  child: const ListTile(
                    leading: Text(
                      'Shto shpenzime',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Icon(Icons.add_circle),
                  )),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const ChartTwo())),
                child: const ListTile(
                  leading: Text(
                    "Raporti ditor",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Icon(Icons.stacked_bar_chart_sharp),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewEmployee(newPage: true,))),
                child: const ListTile(
                  leading: Text(
                    "Shto Punëtor",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Icon(Icons.person_add),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessAdminNavigation())),
                child: const ListTile(
                  leading: Text(
                    "Rreth Nesh",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Icon(Icons.business_center_sharp),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignUp())),
                child: const ListTile(
                  leading: Text(
                    "Dil",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Icon(Icons.output_rounded),
                ),
              )
            ],
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
        borderRadius: BorderRadius.circular(10),
      ),
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

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
