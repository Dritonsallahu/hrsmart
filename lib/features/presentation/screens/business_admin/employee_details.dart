import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/consts/utils.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/month_checkout_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/edit_employee.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeDetails extends StatefulWidget {
  final EmployeeModel employeeModel;

  const EmployeeDetails({Key? key, required this.employeeModel})
      : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  TextEditingController closedPrice = TextEditingController();
  TextEditingController description = TextEditingController();
  FlipCardController? _controller;
  bool searchByMonth = true;
  bool closingMonth = false;
  PageController yearsController = PageController(
    viewportFraction: 0.2,
    initialPage: 0, // Set the initial selected page
  );
  PageController monthsController = PageController(
    viewportFraction: 0.22,
    initialPage: 0, // Set the initial selected page
  );

  int searchMonth = 1;
  int searchYear = DateTime.now().year;

  List<TransactionModel> transactions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        searchMonth = DateTime.now().month;
      });
      monthsController.animateToPage(DateTime.now().month - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
    getEmployees();
    _controller = FlipCardController();
  }

  getEmployees() async {
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    if (searchByMonth) {
      transactions = (await businessProvider.getEmployeeExpenses(
          context, widget.employeeModel.id, searchYear,
          month: searchMonth))!;
    } else {
      transactions = (await businessProvider.getEmployeeExpenses(
          context, widget.employeeModel.id, searchYear))!;
    }
    setState(() {});
  }

  closeMonth() async {
    var currentUser = Provider.of<CurrentUser>(context, listen: false);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    if (closedPrice.text.isEmpty) {
      Navigator.pop(context);
      showErroModal(context, "Nuk keni shtypur qmimin e mbylljes se muajit!");
      return;
    }
    var lastPrice =  double.parse(closedPrice.text);
    var left = widget.employeeModel.salary - double.parse(closedPrice.text);
    MonthCheckoutModel monthCheckoutModel = MonthCheckoutModel(
      userModel: widget.employeeModel.user!,
      business: currentUser.getUser()!.businessModel,
      closedPrice: double.parse(closedPrice.text),
      closedDebt: (widget.employeeModel.countTransactions()).toDouble() - left,
      description: description.text,
      month: DateTime.now().month,
      year: DateTime.now().year,
      active: true,
      closedDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    );
    await checkoutProvider.closeMonthCheckout(context, monthCheckoutModel);

    setState(() {});
  }

  getLocalTransactions() async {
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    if (searchMonth == DateTime.now().month) {
      transactions = await businessProvider.getExpensesByEmployee(
          context, widget.employeeModel.id);
    }
  }

  checkThisMonthStatus(){
    if(widget.employeeModel.closedMonths.isEmpty){
      return false;
    }
    var thisMonth = widget.employeeModel.closedMonths.last;
    var date = DateTime.parse(thisMonth['updatedAt']);
    if(date.month == DateTime.now().month){
      return true;
    }
    else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white, // <-- this
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
          "Detajet",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: false,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if(checkThisMonthStatus()){
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              width: getPhoneWidth(context),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: TextField(
                                            controller: TextEditingController(text: "Rroga e keti muaji eshte: ${widget.employeeModel.closedMonths.last['closed_price']}"),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal:
                                                true), // Allow decimal numbers
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                                            ],
                                            decoration: InputDecoration(
                                                hintText: 'Cmimi mbylljes',
                                                hintStyle: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    color:
                                                    const Color(0xff878787)),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        color:
                                                        Color(0xffdadada))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        color:
                                                        Color(0xffdadada)))),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: TextField(
                                            controller: TextEditingController(text: "Borgji mbetur eshte: ${widget.employeeModel.closedMonths.last['closed_debt']}"),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal:
                                                true), // Allow decimal numbers
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                                            ],
                                            decoration: InputDecoration(
                                                hintText: 'Cmimi mbylljes',
                                                hintStyle: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    color:
                                                    const Color(0xff878787)),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        color:
                                                        Color(0xffdadada))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        color:
                                                        Color(0xffdadada)))),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: TextField(
                                            controller: TextEditingController(text: "Pershkrimi:  ${widget.employeeModel.closedMonths.last['description']}"),
                                            minLines: 3,
                                            maxLines: 6,
                                            decoration: InputDecoration(
                                                hintText: 'Pershkrimi',
                                                hintStyle: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    color:
                                                    const Color(0xff878787)),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        color:
                                                        Color(0xffdadada))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        color:
                                                        Color(0xffdadada)))),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: getPhoneWidth(context),
                                        height: 46,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              closeMonth();
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                  Colors.blue,
                                                ),
                                                foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                            child: Center(
                                              child: closingMonth
                                                  ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                CircularProgressIndicator(
                                                  strokeWidth: 1.4,
                                                  color: Colors.white,
                                                ),
                                              )
                                                  : const Text(
                                                'Mbyll muajin',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                    return;
                  }
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            width: getPhoneWidth(context),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextField(
                                          controller: closedPrice,
                                          onChanged: (value) {
                                            var vlera = double.parse(value);
                                            if (vlera >
                                                widget.employeeModel.salary) {
                                              setState(() {
                                                closedPrice.text = widget
                                                    .employeeModel.salary
                                                    .toString();
                                              });
                                            }
                                          },
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              decimal:
                                                  true), // Allow decimal numbers
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                                          ],
                                          decoration: InputDecoration(
                                              hintText: 'Cmimi mbylljes',
                                              hintStyle: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xff878787)),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Color(0xffdadada))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Color(0xffdadada)))),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextField(
                                          controller: description,
                                          minLines: 3,
                                          maxLines: 6,
                                          decoration: InputDecoration(
                                              hintText: 'Pershkrimi',
                                              hintStyle: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xff878787)),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Color(0xffdadada))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Color(0xffdadada)))),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: getPhoneWidth(context),
                                      height: 46,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            closeMonth();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Colors.blue,
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          child: Center(
                                            child: closingMonth
                                                ? const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 1.4,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : const Text(
                                                    'Mbyll muajin',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xffebedef),
                      )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        checkThisMonthStatus() ? "Muaji i myllur":"Mbyll muajin",
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.check_sharp)),
                      checkThisMonthStatus() ? SizedBox():const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
      body: ListView(padding: const EdgeInsets.only(top: 0), children: [
        const SizedBox(
          height: 15,
        ),
        //search
        employeeCard(),
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
                          "${double.parse(widget.employeeModel.salary.toString()).toStringAsFixed(2)}€",
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
                          "${widget.employeeModel.countTransactions().toStringAsFixed(2)}€",
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
                          "${double.parse(widget.employeeModel.salary.toString()) - widget.employeeModel.countTransactions()}€",
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
                          "${widget.employeeModel.countPastDebt()}€",
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
                                width: (getPhoneWidth(context) - 150) / 2 - 10,
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
                                width: (getPhoneWidth(context) - 130) / 2 - 10,
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
                  onTap: () {
                    getEmployees();
                  },
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
                            border: Border.all(color: const Color(0xffefefef)),
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
                              color: (DateTime.now().year - index) == searchYear
                                  ? Colors.blue
                                  : Colors.white),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Center(
                              child: Text(
                            (DateTime.now().year - index).toString(),
                            style: GoogleFonts.nunito(
                                color:
                                    (DateTime.now().year - index) == searchYear
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
          itemCount: transactions.length,
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
                cardVier(transactions[index]),
              ],
            );
          },
        )
      ]),
    );
  }

  Widget employeeCard() {
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
                                widget.employeeModel.user!.fullName!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              // FutureBuilder<String>(
                              //   future: getDateFormat(
                              //       widget.employeeModel.user!.updatedAt!),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       // While the Future is still running, display a loading indicator
                              //       return const CircularProgressIndicator();
                              //     } else if (snapshot.hasError) {
                              //       // If there's an error in the Future, display an error message
                              //       return Text('Error: ${snapshot.error}');
                              //     } else {
                              //       // When the Future completes successfully, display the formatted date
                              //       return Text(
                              //         snapshot.data ??
                              //             '', // Use the formatted date if available
                              //         style: GoogleFonts.nunito(
                              //             fontSize: 12,
                              //             color: const Color(0xff929cb1)),
                              //       );
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => EditEmployeeScreen(
                                        employeeModel: widget.employeeModel,
                                      )));
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showErroModal(context,
                                  "Fshirja nuk mund e behet, ju lutem prisni deri ne njoftimin e radhes!");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200]),
                              child: const Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          )
                        ],
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
