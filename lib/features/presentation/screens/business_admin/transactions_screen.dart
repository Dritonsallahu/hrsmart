import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/transactions_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/home_screen.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_menagament/l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  bool fetching = false;
  bool withDate = false;
  getAllTransactions(context) async {
    setState(() => fetching = true);

    var transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    await transactionsProvider.getAllTransactions(context,withDate,from: from,to: to);
    setState(() => fetching = false);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getAllTransactions(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var transactionsProvider = Provider.of<TransactionsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.transactions,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      getAllTransactions(context);
                    },
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Column(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          withDate = true;
                                        });
                                        getAllTransactions(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        width: getPhoneWidth(context) / 2 - 30,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
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
                                          child:  Text(
                                            AppLocalizations.of(context)!.filterByDate,
                                            style:
                                            GoogleFonts.nunito(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                        setState(() {
                                          withDate = false;
                                        });
                                        getAllTransactions(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        width: getPhoneWidth(context) / 2 - 30,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
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
                                          child:  Text(
                                            AppLocalizations.of(context)!.all,
                                            style:
                                            GoogleFonts.nunito(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)!
                                          .total,
                                      style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w500)),
                                  Text(
                                    transactionsProvider
                                        .getTotalPrice()
                                        .toString(),
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        fetching
                            ? Container(

                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blueGrey[800],
                                  strokeWidth: 1.8,
                                ),
                              ),
                            )
                            :transactionsProvider.getTransactions().isEmpty
                            ? Container(

                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.noTransactions,
                                  style: GoogleFonts.nunito(
                                      color: Colors.blueGrey, fontSize: 18),
                                ),
                              ),
                            )
                            : ListView.builder(
                            itemCount:
                                transactionsProvider.getTransactions().length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              TransactionModel expense =
                                  transactionsProvider.getTransactions()[index];
                              return Column(
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                      showErroModal(context,
                                          "${AppLocalizations.of(context)!.description}: \n${expense.description}");
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Slidable(
                                        key: ValueKey(index),
                                          child: TransactionCard(transactionModel: expense,index: index, businessProvider: null,)
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
    );
  }
}
