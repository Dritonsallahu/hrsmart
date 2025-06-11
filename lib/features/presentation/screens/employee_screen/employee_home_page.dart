import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/consts/utils.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/providers/employee_provider.dart';
import 'package:hr_smart/features/presentation/screens/employee_screen/edit_profile_screen.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  FlipCardController? _controller;
  bool searchByMonth = true;
  bool closingMonth = false;
  bool fetchingExpenses = false;
  PageController yearsController = PageController(
    viewportFraction: 0.2,
    initialPage: 0, // Set the initial selected page
  );
  PageController monthsController = PageController(
    viewportFraction: 0.22,
    initialPage: 0, // Set the initial selected page
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getTransactions();
      getEmployeeDetails();
    });

    super.initState();
  }

  getEmployeeDetails() async {
    setState(() => fetchingExpenses = true);

    var currentUser =
        Provider.of<EmployeeProvider>(context, listen: false);
    await currentUser.getEmployeeDetails(context );
    setState(() => fetchingExpenses = false);
  }

  getTransactions() async {
    setState(() => fetchingExpenses = true);

    var currentUser =
        Provider.of<EmployeeProvider>(context, listen: false);
    await currentUser.getAllExpenses(context, {
      "business": currentUser.getUser()!.business['_id'],
      "employee": currentUser.getUser()!.id
    });
    setState(() => fetchingExpenses = false);
  }

  List<TransactionModel> transactions = [];
  int searchMonth = 1;
  int searchYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white, // <-- this
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
            currentUser.getUser() == null ? "":currentUser.getUser()!.business['name'],
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () async {
                await currentUser.removeUser(context);
              },
              icon: const Icon(Icons.logout)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getEmployeeDetails();
          getTransactions();
        },
        child: ListView(padding: const EdgeInsets.only(top: 0), children: [
          const SizedBox(
            height: 15,
          ),
          //search
          employeeCard(currentUser),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: getPhoneWidth(context) / 2 - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffebedef))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffd8f2e4)),
                          child: const Icon(
                            Icons.attach_money,
                            color: Color(0xff69cf98),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rroga",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffa5adbf), fontSize: 13),
                          ),
                          Text(
                            // " €",
                              currentUser.getUser() == null ? "":"${currentUser.getUser()!.salary.toDouble()}€",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 17.5),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: getPhoneWidth(context) / 2 - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffebedef))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xfffecacc)),
                          child: const Icon(
                            Icons.trending_down_rounded,
                            color: Color(0xffe3292d),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terheqje",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffa5adbf), fontSize: 13),
                          ),
                          Text(
                            "${currentUser.getUser()!.countTransactions().toStringAsFixed(2)}€",
                            // " €",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 17.5),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: getPhoneWidth(context) / 2 - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffebedef))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffd8f2e4)),
                          child: const Icon(
                            Icons.keyboard_double_arrow_left_rounded,
                            color: Color(0xff69cf98),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balanci mujor",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffa5adbf), fontSize: 13),
                          ),
                          Text(
                            "${double.parse(currentUser.getUser()!.salary.toString()) - currentUser.getUser()!.countTransactions()}€",
                            // " €",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 17.5),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: getPhoneWidth(context) / 2 - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffebedef))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffd8f2e4)),
                          child: const Icon(
                            Icons.keyboard_double_arrow_left_rounded,
                            color: Color(0xff69cf98),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balanci total",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffa5adbf), fontSize: 13),
                          ),
                          Text(
                            "${currentUser.getUser()!.countPastDebt()}€",
                            // " €",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 17.5),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: getPhoneWidth(context) - 150,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffefefef)),
                      ),
                      AnimatedPositioned(
                          height: 40,
                          width: (getPhoneWidth(context) - 150) / 2 - 10,
                          left: searchByMonth
                              ? 0
                              : (getPhoneWidth(context) - 150) / 2 + 10,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 3),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                              child: Text(
                                "Muaji",
                                style: GoogleFonts.poppins(
                                    color: Colors.transparent),
                              ),
                            ),
                          )),
                      AnimatedPositioned(
                          height: 40,
                          width: getPhoneWidth(context) - 150,
                          duration: const Duration(milliseconds: 200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchByMonth = true;
                                  });
                                  if (!cardKey.currentState!.isFront) {
                                    cardKey.currentState!.toggleCard();
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width:
                                      (getPhoneWidth(context) - 150) / 2 - 10,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: const Center(child: Text("Muaji")),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchByMonth = false;
                                  });
                                  if (cardKey.currentState!.isFront) {
                                    cardKey.currentState!.toggleCard();
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width:
                                      (getPhoneWidth(context) - 130) / 2 - 10,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: const Center(child: Text("Viti")),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 100,
                      height: 38.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue),
                      child: Center(
                          child: Text(
                        "Kerko",
                        style: GoogleFonts.nunito(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: getPhoneWidth(context),
            child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              direction: FlipDirection.VERTICAL,
              front: SizedBox(
                height: 35,
                child: PageView.builder(
                  controller: monthsController,
                  scrollDirection: Axis.horizontal,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            // Use jumpTo to scroll to the selected item's position
                            monthsController.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                            setState(() {
                              searchMonth = index + 1;
                            });
                          },
                          child: Container(
                            key: Key(months[index]),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xffefefef)),
                              color: searchMonth == index + 1
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Center(
                                child: Text(months[index],
                                    style: GoogleFonts.nunito(
                                        color: searchMonth == index + 1
                                            ? Colors.white
                                            : Colors.black))),
                          ),
                        ));
                  },
                ),
              ),
              back: SizedBox(
                height: 35,
                child: PageView.builder(
                  reverse: true,
                  controller: yearsController,
                  scrollDirection: Axis.horizontal,
                  itemCount: months.length,
                  padEnds: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          // Use jumpTo to scroll to the selected item's position
                          yearsController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                          setState(() {
                            searchYear = DateTime.now().year - index;
                          });
                        },
                        child: Container(
                            key: Key((DateTime.now().year - index).toString()),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: const Color(0xffefefef)),
                                color:
                                    (DateTime.now().year - index) == searchYear
                                        ? Colors.blue
                                        : Colors.white),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Center(
                                child: Text(
                              (DateTime.now().year - index).toString(),
                              style: GoogleFonts.nunito(
                                  color: (DateTime.now().year - index) ==
                                          searchYear
                                      ? Colors.white
                                      : Colors.black),
                            ))),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: currentUser.getExpenses().length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index != 0
                      ? const SizedBox()
                      : Container(
                          color: const Color.fromRGBO(55, 159, 255, 1),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Arsyeja',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: const Text(
                                  'Cmimi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: const Text(
                                  'Pershkrimi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: const Text(
                                  'Opsioni',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                  cardVier(currentUser.getExpenses()[index]),
                ],
              );
            },
          )
        ]),
      ),
    );
  }

  Widget employeeCard(EmployeeProvider currentUser) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getPhoneWidth(context) - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffe4e6e7),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              currentUser.getUser() == null ? "" : currentUser.getUser()!.user!.fullName!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(getDateOnlyFormat(currentUser.getUser()!.user!.updatedAt!))
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          child: const Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Color.fromRGBO(55, 159, 255, 1),
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardVier(TransactionModel transaction) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                transaction.reason!,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              transaction.price!.toStringAsFixed(2),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              transaction.description!,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Fshije',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
