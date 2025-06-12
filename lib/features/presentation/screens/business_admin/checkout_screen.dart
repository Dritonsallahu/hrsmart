import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/checkout_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/checkout_list_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/checkout_update_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/daily_transactions_screen.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> scaffoldKe = GlobalKey<ScaffoldState>();
  TextEditingController dateinput = TextEditingController();

  bool fetchingCheckout = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCheckouts();
    });
    super.initState();
  }

  getCheckouts() async {
    setState(() => fetchingCheckout = true);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    await checkoutProvider.getCheckouts(context);
    setState(() => fetchingCheckout = false);
  }

  @override
  Widget build(BuildContext context) {
    var checkoutProvider = Provider.of<CheckoutProvider>(context);
    var businessProvider = Provider.of<BusinessProvider>(context);

    return Container(
      color: const Color(0xfff4f6f8),
      child: RefreshIndicator(
        onRefresh: () async {
          getCheckouts();
        },
        child: ListView(padding: const EdgeInsets.all(0), children: [
          Container(
            width: getPhoneWidth(context),
            height: 340,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff3f617e),
                      Color(0xff324a60),
                      Color(0xff1a2836),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 0.5, 1])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  AppLocalizations.of(context)!.currentBalance,
                  style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xfffbfbfb)),
                ),
                Text(
                  "${checkoutProvider.getActiveCheckout() == null ? '0.00' : businessProvider.countBilance(context ).toDouble()}€",
                  style: GoogleFonts.openSans(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xfffbfbfb)),
                ),
                Text(
                  getDateFormat2(
                      DateFormat('yyyy-MM-dd').format(DateTime.now())),
                  style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7d92cc)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: checkoutProvider.getCheckoutModel() == null
                          ? const Color(0xffff5046)
                          : const Color(0xff09a64b)
                      // color: Color(0xffff5046)
                      // gradient: LinearGradient(
                      //     colors: [
                      //       Color(0xff33516b).withOpacity(0.5),
                      //       Color(0xff1a3146).withOpacity(0.5),
                      //     ]
                      // )
                      ),
                  child: Text(
                    // checkoutProvider.getCheckoutList().isEmpty ? "Arka jo aktive":
                    checkoutProvider.getCheckoutModel() == null
                        ? AppLocalizations.of(context)!.closedCashbox
                        : AppLocalizations.of(context)!.openedCashbox,
                    style:
                        GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              checkoutTable(context, businessProvider, checkoutProvider),
              Positioned(
                  width: getPhoneWidth(context),
                  top: -35,
                  child: Center(
                    child: Container(
                      width: getPhoneWidth(context) - 50,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xffdee0e1).withOpacity(0.5),
                              spreadRadius: 0.9,
                              blurRadius: 4,
                              offset: const Offset(0, 1))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: const Color(0xffd7e3ed))),
                                child: Text(
                                  AppLocalizations.of(context)!.income,
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: const Color(0xff395772),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_upward,
                                    color: Color(0xff01a03f),
                                    size: 20,
                                  ),
                                  Text(
                                    checkoutProvider.getCheckoutModel() == null
                                        ? "0.00"
                                        : "${checkoutProvider.getCheckoutModel()!.startPrice.toDouble()}€",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: const Color(0xff01a03f),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: const Color(0xffd7e3ed))),
                                child: Text(
                                  AppLocalizations.of(context)!.outcome,
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: const Color(0xff395772),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xffff3f34),
                                    size: 20,
                                  ),
                                  Text(
                                    checkoutProvider.getActiveCheckout() == null
                                        ? "0.00"
                                        : "${businessProvider.calculateAllExpenses(context).toDouble()}€",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: const Color(0xffff3f34),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }

  checkoutTable(context, BusinessProvider businessProvider,
      CheckoutProvider checkoutProvider) {
    var partWidth = getPhoneWidth(context) / 3;
    print(checkoutProvider.getCheckoutModelTwo() == null);
    var gapHeight = 35.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          checkoutProvider.getActiveCheckout() == null
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      AppLocalizations.of(context)!.cashboxDetails,
                      style: GoogleFonts.nunito(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                        color: const Color(0xff858485).withOpacity(0.2),
                        thickness: 1),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DailyTransactionsScreen(
                                  date: getDateFormat2(checkoutProvider
                                      .getCheckoutModelTwo()!
                                      .startedDate!),
                                  id: checkoutProvider
                                      .getCheckoutModelTwo()!
                                      .id,
                                )));
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: getPhoneWidth(context),
                        child: Column(
                          children: [
                            SizedBox(
                              height: gapHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.startedDate,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  Text(
                                    checkoutProvider.getCheckoutModelTwo() ==
                                            null
                                        ? "00/00/0000"
                                        : "${getDateFormat(checkoutProvider.getCheckoutModelTwo()!.startedDate!)}",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff181818),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: gapHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.startedPrice,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  Text(
                                    checkoutProvider.getCheckoutModelTwo() ==
                                            null
                                        ? "0.00€"
                                        : "${checkoutProvider.getCheckoutModelTwo()!.startPrice}€",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff181818),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: gapHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.transactions,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  Text(
                                    "${businessProvider.calculateAllExpenses(context, includeLastCheckout: true)}€",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff181818),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: gapHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.closedDate,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  Text(
                                    checkoutProvider.getCheckoutModelTwo() ==
                                            null
                                        ? "00/00/0000"
                                        : checkoutProvider
                                                    .getCheckoutModelTwo()!
                                                    .closedDate ==
                                                null
                                            ? "00/00/0000"
                                            : "${getDateFormat2(checkoutProvider.getCheckoutModelTwo()!.closedDate!)}",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff181818),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: gapHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.closedTime,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  Text(
                                    checkoutProvider.getCheckoutModelTwo() ==
                                            null
                                        ? "00/00/0000"
                                        : checkoutProvider
                                                    .getCheckoutModelTwo()!
                                                    .closedDate ==
                                                null
                                            ? "00/00/0000"
                                            : "${getTimeFormat(checkoutProvider.getCheckoutModelTwo()!.closedDate!)}",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff181818),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: gapHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.closedPrice,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  Text(
                                    checkoutProvider.getCheckoutModelTwo() ==
                                            null
                                        ? "0.00€"
                                        : "${checkoutProvider.getCheckoutModelTwo()!.closedPrice ?? "0.00"}€",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff181818),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.description,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff858485)),
                                  ),
                                  SizedBox(
                                    width: getPhoneWidth(context) - 150,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        checkoutProvider
                                                    .getCheckoutModelTwo() ==
                                                null
                                            ? ""
                                            : "${checkoutProvider.getCheckoutModelTwo()!.description}",
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: const Color(0xff181818),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                        color: const Color(0xff858485).withOpacity(0.2),
                        thickness: 1),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
          Column(
            children: [
              SizedBox(
                height: checkoutProvider.getActiveCheckout() != null ? 0 : 75,
              ),
              checkoutProvider.getCheckoutModel() == null
                  ? GestureDetector(
                      onTap: () {
                        showErroModal(
                            context,
                            AppLocalizations.of(context)!
                                .doYouWantToOpenCheckout,
                            size: 19,
                            options: true, function: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CheckoutUpdateScreen(isOpen: false),
                              )).then((value) {
                            getCheckouts();
                          });
                        });
                      },
                      child: Container(
                        width: getPhoneWidth(context),
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff09a64b),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.openCashbox,
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        showErroModal(
                            context,
                            AppLocalizations.of(context)!
                                .doYouWantToCloseCheckout,
                            size: 19,
                            options: true, function: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CheckoutUpdateScreen(isOpen: true),
                              )).then((value) {
                            getCheckouts();
                          });
                        });
                      },
                      child: Container(
                        width: getPhoneWidth(context),
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xffec1b10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.closeCashbox,
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CheckoutListScreen(
                            checkouts: checkoutProvider.getCheckoutList(),
                          )));
                },
                child: Container(
                  width: getPhoneWidth(context),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.seeCashboxList,
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: const Color(0xff395772),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
