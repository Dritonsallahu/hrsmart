
import 'package:hr_smart/features/presentation/screens/super_admin/businesses_list_screen.dart';
import 'package:hr_smart/features/presentation/screens/super_admin/new_business_screen.dart';
import 'package:hr_smart/features/presentation/screens/super_admin/super_admin_home.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Statistikat extends StatefulWidget {
  const Statistikat({Key? key}) : super(key: key);

  @override
  State<Statistikat> createState() => _StatistikatState();
}

class _StatistikatState extends State<Statistikat> {
  final GlobalKey<ScaffoldState> _scaffoldK = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  final List<ChartData> chartData = [
    ChartData(1, 35),
    ChartData(2, 23),
    ChartData(3, 34),
    ChartData(4, 25),
    ChartData(5, 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldK,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 13, right: 13),
                child: Row(
                  children: [
                    CircleAvatar(maxRadius: 25, backgroundColor: Colors.blueAccent),
                    SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Smart management', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 3,),
                            CircleAvatar(maxRadius: 10, backgroundColor: Colors.green),
                          ],
                        ),
                        Text('Vlerson Haliti', style: TextStyle(fontSize: 15)),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(width: 23),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications),
                    ),
                    IconButton(
                      onPressed: () {
                        _scaffoldK.currentState?.openEndDrawer();
                      },
                      icon: Icon(Icons.menu),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width - 40,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.calendar_today),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    hintText: "YYYY",
                    filled: true,
                    fillColor: Color.fromRGBO(235, 235, 235, 1),
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 24, 51, 0.22),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  controller: TextEditingController(text: selectedDate.year.toString()),
                  readOnly: true,
                  onTap: () => _selectYear(context),
                ),
              ),
              SizedBox(height: 25,),
      Container(
               child: SfCartesianChart(
              //   series: <ChartSeries<ChartData, int>>[
              //   // Renders column chart
              //       ColumnSeries<ChartData, int>(
              //       dataSource: chartData,
              //       xValueMapper: (ChartData data, _) => data.x,
              //       yValueMapper: (ChartData data, _) => data.y
              //   )
              // ]
          )
      ) ,
            Center(child: Text('Sipas muajve'),),
              ],
          ),
        ),
      ),

    );
  }

}
class ChartData {
  ChartData(this.x, this.y,);
  final int x;
  final double y;
}
