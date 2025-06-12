import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/features/controllers/business_admin_controllers/business_transaction_controller.dart';
import 'package:business_menagament/features/models/checkout_stats_model.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  PageController yearsController = PageController(
    viewportFraction: 0.2,
    initialPage: 0, // Set the initial selected page
  );
  PageController monthsController = PageController(
    viewportFraction: 0.22,
    initialPage: 0, // Set the initial selected page
  );
  List<CheckoutData> _chartList = [];

  double totalIncomes = 0.00;
  double totalOutcomes = 0.00;
  double totalTransactions = 0.00;
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  int searchYear = DateTime.now().year;
  int searchMonth = 1;

  bool byDate = false;
  bool filtering = false;

  filterData() async {
    setState(() {
      filtering = true;
    });
    BusinessTransactionController businessTransactionController =
        BusinessTransactionController();
    var data = await businessTransactionController.filter(context, from, to);
    data.fold((l) {
      showFailureModal(context, l);
    }, (r) {
      print(r);
      print("-------------");
      setState(() {
        totalIncomes = r['totalStartPrice'].toDouble();
        totalOutcomes = r['totalClosedPrice'].toDouble();
        totalTransactions =r['transactionsPrice'] == null ? 0.00: r['transactionsPrice'].toDouble();
        _chartList = r['chartResult']
            .map<CheckoutData>((json) => CheckoutData.fromJson(json))
            .toList();

        setState(() {
          filtering = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.statistics,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () async {
            filterData();
          },
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: getPhoneWidth(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.from,
                              style: GoogleFonts.nunito(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: SizedBox(
                                          width: getPhoneWidth(context),
                                          height: 200,
                                          child: CupertinoDatePicker(
                                              mode: CupertinoDatePickerMode
                                                  .date,
                                              onDateTimeChanged: (date) {
                                                setState(() {
                                                  from = date;
                                                });
                                              },
                                              initialDateTime: from,
                                              minimumDate:
                                                  DateTime(2000, 01, 01),
                                              maximumDate: DateTime.now()),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                width: getPhoneWidth(context) / 2 - 30,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffc5cace))),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('yyyy-MM-dd')
                                              .format(from),
                                          style: GoogleFonts.nunito(
                                              fontSize: 15),
                                        ),
                                        SvgPicture.asset(
                                          "assets/icons/calendar-1.svg",
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.to,
                              style: GoogleFonts.nunito(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: SizedBox(
                                          width: getPhoneWidth(context),
                                          height: 200,
                                          child: CupertinoDatePicker(
                                              mode: CupertinoDatePickerMode
                                                  .date,
                                              onDateTimeChanged: (date) {
                                                setState(() {
                                                  to = date;
                                                });
                                              },
                                              initialDateTime: to,
                                              minimumDate:
                                                  DateTime(2000, 01, 01),
                                              maximumDate: DateTime.now()),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                width: getPhoneWidth(context) / 2 - 30,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffc5cace))),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('yyyy-MM-dd').format(to),
                                          style: GoogleFonts.nunito(
                                              fontSize: 15),
                                        ),
                                        SvgPicture.asset(
                                          "assets/icons/calendar-1.svg",
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        filterData();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: getPhoneWidth(context),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xff3f617e),
                                Color(0xff324a60),
                                Color(0xff1a2836),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.2, 0.5, 1]),
                        ),
                        child: Center(
                          child: filtering
                              ? SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.7,
                                  ))
                              : Text(
                                  AppLocalizations.of(context)!.filter,
                                  style:
                                      GoogleFonts.nunito(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    series: <LineSeries<CheckoutData, String>>[
                      LineSeries<CheckoutData, String>(
                          // Bind data source
                          dataSource: _chartList,
                          xValueMapper: (CheckoutData sales, _) => sales.year,
                          yValueMapper: (CheckoutData sales, _) => sales.sales)
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.income,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    Text(
                      "${totalIncomes}€",
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.outcome,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    Text(
                      "${totalOutcomes}€",
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amberAccent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.gross,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    Text(
                      "${totalOutcomes - totalIncomes}€",
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.transactions,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    Text(
                      "${totalTransactions}€",
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.total,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    Text(
                      "${(totalOutcomes - totalIncomes) - totalTransactions}€",
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
