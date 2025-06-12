import 'package:business_menagament/view/chart2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BusinessChartScreen extends StatefulWidget {
  const BusinessChartScreen({Key? key}) : super(key: key);

  @override
  State<BusinessChartScreen> createState() => _BusinessChartScreenState();
}

class _BusinessChartScreenState extends State<BusinessChartScreen> {
  final GlobalKey<ScaffoldState> scaffK = GlobalKey<ScaffoldState>();
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

  void _openEndDrawer() {
    scaffK.currentState?.openEndDrawer();
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int? selectedMonth;
  int? selectedYear;

  void _selectDate(int month, int year) {
    setState(() {
      selectedMonth = month;
      selectedYear = year;
    });
  }

  final List<Widget> containers = [];
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('USA', 10, '90%'),
      ChartData('China', 11, '80%'),
      ChartData('Russia', 9, '52%'),
      ChartData('Germany', 10, '30%'),
      ChartData('Kosova', 9, '20%'),
    ];

    return 1 == 1
        ? Center(
            child: Text(
                "Jemi duke pergaditur versionin e radhes me perditesimet e fundit, "
                    "shpresojme mirekuptimin tuaj. ",style: GoogleFonts.nunito(fontSize: 20),textAlign: TextAlign.center,),
          )
        : ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
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
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            child: SfCircularChart(series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              // Radius for each segment from data source
                              pointRadiusMapper: (ChartData data, _) =>
                                  data.size)
                        ])),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChartTwo(),
                                  ));
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
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
                        const Text('0')
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
                        const Text('0')
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
                        const Text('0')
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
                        const Text('0')
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
                        const Text('0')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
}
