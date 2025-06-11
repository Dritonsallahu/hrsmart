import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/conectivity_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/providers/navigator_provider.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/drawer_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/home_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/new_employee.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/profile_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/transactions_screen.dart';
import 'package:hr_smart/view/chartS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BusinessAdminNavigation extends StatefulWidget {
  const BusinessAdminNavigation({Key? key}) : super(key: key);

  @override
  State<BusinessAdminNavigation> createState() =>
      _BusinessAdminNavigationState();
}

class _BusinessAdminNavigationState extends State<BusinessAdminNavigation> {
  TextEditingController dateinput = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController(initialPage: 0);

  bool startingCheckout = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCheckout();

    });
    super.initState();
  }

  getCheckout() async {
    setState(() => startingCheckout = true);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    await checkoutProvider.getCheckout(context);
    setState(() => startingCheckout = false);
  }
 
  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<CurrentUser>(context);
    var businessProvider = Provider.of<BusinessProvider>(context);
    var connectivity = Provider.of<ConnectivityProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              currentUser.getUser() == null
                  ? ""
                  : currentUser.getUser()!.fullName!,
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            Text(
                currentUser.getUser() == null ? "": currentUser.getUser()!.businessModel!.name!,
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!)),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 6, bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        "Bilanci",
                        style: GoogleFonts.poppins(color: Colors.grey[600]),
                      ),
                      Text(
                        "${businessProvider.countBilance(context)}\$",
                        style: GoogleFonts.poppins(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu)),
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
            controller: _pageController,
            onPageChanged: (value) {
              var navigatorItems =
                  Provider.of<NavigatorProvider>(context, listen: false);
              if (value == 0) {
                navigatorItems.changeNavigatorItem(NavigatorItems.home);
              } else if (value == 1) {
                navigatorItems.changeNavigatorItem(NavigatorItems.cart);
              } else if (value == 2) {
                navigatorItems.changeNavigatorItem(NavigatorItems.newEmployee);
              } else if (value == 3) {
                navigatorItems.changeNavigatorItem(NavigatorItems.newDay);
              } else if (value == 4) {
                navigatorItems.changeNavigatorItem(NavigatorItems.profile);
              }
            },
            children: [
              const HomeScreen(),
              const BusinessChartScreen(),
              NewEmployee(newPage: false),
              const TransactionsScreen(),
              const ProfileScreen(),
            ],
          ),
          connectivity.getConnectionStatus() == ConnectionState.active ? Positioned(
            bottom: 0,
              child: Container(
            width: getPhoneWidth(context),
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Nuk keni rrjet!",
              style: GoogleFonts.nunito(color: Colors.white),
            ),
          )):SizedBox()
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: navigationWidget(),
    );
  }

  navigationWidget() {
    var navigatorItems = Provider.of<NavigatorProvider>(context);
    const iconWidthSplit = 5;
    const minusValue = 10;
    return Container(
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
                  _pageController.jumpToPage(0);
                },
                child: Container(
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
                      width:
                          getPhoneWidth(context) / iconWidthSplit - minusValue,
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
              navigatorItems.changeNavigatorItem(NavigatorItems.cart);
              _pageController.jumpToPage(1);
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
                navigatorItems.getNavigatorItem() != NavigatorItems.cart
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
              navigatorItems.changeNavigatorItem(NavigatorItems.newEmployee);
              _pageController.jumpToPage(2);

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
                        child: SvgPicture.asset("assets/icons/add-square.svg"),
                      )),
                ),
                navigatorItems.getNavigatorItem() != NavigatorItems.newEmployee
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
              navigatorItems.changeNavigatorItem(NavigatorItems.newDay);
              _pageController.jumpToPage(3);
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
                        child: SvgPicture.asset("assets/icons/money-send.svg"),
                      )),
                ),
                navigatorItems.getNavigatorItem() != NavigatorItems.newDay
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

              navigatorItems.changeNavigatorItem(NavigatorItems.profile);
              _pageController.jumpToPage(4);
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
                        child: SvgPicture.asset("assets/icons/user-avatar.svg"),
                      )),
                ),
                navigatorItems.getNavigatorItem() != NavigatorItems.profile
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
    );
  }
}
