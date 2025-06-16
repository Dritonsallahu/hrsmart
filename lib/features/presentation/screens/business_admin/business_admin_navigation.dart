import 'dart:io';

import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/checkout_provider.dart';
import 'package:business_menagament/features/presentation/providers/conectivity_provider.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/navigator_provider.dart';
import 'package:business_menagament/features/presentation/providers/notification_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/add_outcome_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/checkout_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/drawer_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/employees_cardlist_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/home_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/report_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/statistics_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class BusinessAdminNavigation extends StatefulWidget {
  const BusinessAdminNavigation({Key? key}) : super(key: key);

  @override
  State<BusinessAdminNavigation> createState() =>
      _BusinessAdminNavigationState();
}

class _BusinessAdminNavigationState extends State<BusinessAdminNavigation> {
  TextEditingController dateinput = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startingCheckout = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCheckout();
      getNotifications();
    });
    super.initState();
  }

  getCheckout() async {
    setState(() => startingCheckout = true);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    checkoutProvider.getCheckoutt(context);
    setState(() => startingCheckout = false);
  }

  getNotifications() async {
    setState(() => startingCheckout = true);
    var notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.getNotificationsDB(context);
    setState(() => startingCheckout = false);
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<CurrentUser>(context);
    var businessProvider = Provider.of<BusinessProvider>(context);
    var connectivity = Provider.of<ConnectivityProvider>(context);
    var navigatorItems = Provider.of<NavigatorProvider>(context);
    var notifications = Provider.of<NotificationProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar:
            navigatorItems.getNavigatorItem() == NavigatorItems.checkout,
        appBar: AppBar(
          backgroundColor:
              navigatorItems.getNavigatorItem() == NavigatorItems.checkout
                  ? Colors.transparent
                  : Colors.white,
          foregroundColor:
              navigatorItems.getNavigatorItem() == NavigatorItems.checkout
                  ? Colors.white
                  : Colors.black,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/background.jpeg"))),
            ),
          ),
          centerTitle: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser.getBusinessAdmin() == null
                    ? ""
                    : currentUser.getBusinessAdmin()?.business?.name ?? "",
                style: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w600),
              ),
              Text(
                currentUser.getBusinessAdmin() == null
                    ? ""
                    : currentUser.getBusinessAdmin()?.user?.fullName ?? "",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigatorItems.getNavigatorItem() == NavigatorItems.checkout
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(142, 255, 155, 0.44),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color:
                                    const Color.fromRGBO(142, 255, 155, 0.44),
                              )),
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 0),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.balance,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xfffe7275)),
                              ),
                              Text(
                                "${businessProvider.countBilance(context)}\$",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff33E545),height: 1,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        icon: const Icon(Icons.menu)),
                    notifications.getUnreadNotifications() == 0 ? SizedBox():Positioned(
                      right: 5,
                        top: 5,
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),color: const Color(0xff1a2836)),

                      child: Text(
                        "1",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 9),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
        drawer: BusinessDrawerWidget(currentUser: currentUser),
        body: Stack(
          children: [
            PageView(
              allowImplicitScrolling: false,
              physics: const NeverScrollableScrollPhysics(),
              controller: navigatorItems.getPageController(),
              onPageChanged: (value) {
                if (value == 0) {
                  navigatorItems.changeNavigatorItem(NavigatorItems.home);
                } else if (value == 1) {
                  navigatorItems.changeNavigatorItem(NavigatorItems.employees);
                } else if (value == 2) {
                  navigatorItems
                      .changeNavigatorItem(NavigatorItems.newTransaction);
                } else if (value == 3) {
                  navigatorItems.changeNavigatorItem(NavigatorItems.statistics);
                } else if (value == 4) {
                  navigatorItems.changeNavigatorItem(NavigatorItems.checkout);
                }
              },
              children: const [
                HomeScreen(),
                EmployeesCardListScreen(),
                AddOutcomeScreen(),
                ReportsScreen(),
                CheckoutScreen(),
              ],
            ),
            connectivity.getConnectionStatus() == ConnectionState.active
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      width: getPhoneWidth(context),
                      color: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.noInternet,
                        style: GoogleFonts.nunito(color: Colors.white),
                      ),
                    ))
                : const SizedBox()
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: navigationWidget(),
      ),
    );
  }

  navigationWidget() {
    var navigatorItems = Provider.of<NavigatorProvider>(context);
    const iconWidthSplit = 5;
    const minusValue = 10;
    return Padding(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0),
      child: Container(
        width: getPhoneWidth(context),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[400]!))),

        height: 62,
        padding: const EdgeInsets.only(left: 15, right: 15),
        // padding:EdgeInsets.all(10),
        // margin:EdgeInsets.symmetric(horizontal: 24),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {
                    navigatorItems.changeNavigatorItem(NavigatorItems.home);
                    navigatorItems.changePage(0);
                  },
                  child: SizedBox(
                    width: getPhoneWidth(context) / iconWidthSplit - minusValue,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset("assets/icons/home-icon.svg"),
                        )),
                  ),
                ),
                navigatorItems.getNavigatorItem() != NavigatorItems.home
                    ? const SizedBox()
                    : Positioned(
                        bottom: -3,
                        width: getPhoneWidth(context) / iconWidthSplit -
                            minusValue,
                        child: Center(
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ))
              ],
            ),
            GestureDetector(
              onTap: () {
                navigatorItems.changeNavigatorItem(NavigatorItems.employees);
                navigatorItems.changePage(1);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: getPhoneWidth(context) / iconWidthSplit - minusValue,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset("assets/icons/notes.svg"),
                        )),
                  ),
                  navigatorItems.getNavigatorItem() != NavigatorItems.employees
                      ? const SizedBox()
                      : Positioned(
                          bottom: -3,
                          width: getPhoneWidth(context) / iconWidthSplit -
                              minusValue,
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                navigatorItems
                    .changeNavigatorItem(NavigatorItems.newTransaction);
                navigatorItems.changePage(2);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: getPhoneWidth(context) / iconWidthSplit - minusValue,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child:
                              SvgPicture.asset("assets/icons/add-square.svg"),
                        )),
                  ),
                  navigatorItems.getNavigatorItem() !=
                          NavigatorItems.newTransaction
                      ? const SizedBox()
                      : Positioned(
                          bottom: -3,
                          width: getPhoneWidth(context) / iconWidthSplit -
                              minusValue,
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                navigatorItems.changeNavigatorItem(NavigatorItems.statistics);
                navigatorItems.changePage(3);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: getPhoneWidth(context) / iconWidthSplit - minusValue,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child:
                              SvgPicture.asset("assets/icons/notes-icon.svg"),
                        )),
                  ),
                  navigatorItems.getNavigatorItem() != NavigatorItems.statistics
                      ? const SizedBox()
                      : Positioned(
                          bottom: -3,
                          width: getPhoneWidth(context) / iconWidthSplit -
                              minusValue,
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                navigatorItems.changeNavigatorItem(NavigatorItems.checkout);
                navigatorItems.changePage(4);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: getPhoneWidth(context) / iconWidthSplit - minusValue,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:
                              SvgPicture.asset("assets/icons/money-send.svg"),
                        )),
                  ),
                  navigatorItems.getNavigatorItem() != NavigatorItems.checkout
                      ? const SizedBox()
                      : Positioned(
                          bottom: -3,
                          width: getPhoneWidth(context) / iconWidthSplit -
                              minusValue,
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
