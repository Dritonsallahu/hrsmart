import 'dart:convert';

import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/features/controllers/business_admin_controllers/business_cost_controller.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:hr_smart/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNewCostScreen extends StatefulWidget {
  const AddNewCostScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCostScreen> createState() => _AddNewCostScreenState();
}

class _AddNewCostScreenState extends State<AddNewCostScreen> {
  final GlobalKey<ScaffoldState> scaffoldKee = GlobalKey<ScaffoldState>();
  EmployeeModel? employeeModel;
  TextEditingController dateinput = TextEditingController();
  TextEditingController debtAmount = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController description = TextEditingController();

  bool fetchingEmployees = false;
  bool addingExpense = false;

  fetchEmployeeDetails() {}

  addExpenses() async {
    setState(() => addingExpense = true);
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);

    if (debtAmount.text.isEmpty ||
        reason.text.isEmpty ||
        employeeModel == null) {
      showFailureModal(context, UnfilledDataFailure());
      setState(() => addingExpense = false);

      return;
    }

    TransactionModel transactionModel = TransactionModel(
      business: userProvider.getUser()!.businessModel!.id,
      user: employeeModel!.user,
      status: "active",
      reason: reason.text,
      checkout: checkoutProvider.getActiveCheckout(),
      employee: employeeModel,
      price: double.parse(debtAmount.text),
      description: description.text,
      date: DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.now().add(Duration(hours: 2))),
    );

    var employeeDebt = employeeModel!.countTransactions();
    if (employeeDebt >= employeeModel!.allowedDebt) {
      showErroModal(context, "Borgji i puntorit eshte ka arritur limitin");
      setState(() => addingExpense = false);
      return;
    }
    if (employeeModel!.countTransactions() + double.parse(debtAmount.text) >
        employeeModel!.allowedDebt) {
      showErroModal(context,
          "Vlera e dhene nuk mund te jete me e madhe se borgji lejuar.\nShuma e mbetur e terheqjes se lejuar eshte: ${employeeModel!.allowedDebt - employeeModel!.countTransactions()}",
          size: 17);
      setState(() => addingExpense = false);
      return;
    }
    await businessProvider.addNewExpense(
        context, jsonEncode(transactionModel.toJson()));
    setState(() => addingExpense = false);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() => fetchingEmployees = true);
      var businessProvider =
          Provider.of<BusinessProvider>(context, listen: false);
      await businessProvider.getAllEmployees(context);
      setState(() => fetchingEmployees = false);
    });

    super.initState();
  }

  List<String> list = <String>['Ushqim', 'Pije', 'Personale', 'Tjeter'];

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    var checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Scaffold(
      key: scaffoldKee,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Shto shpenzim",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: employeeModel == null ? 0 : 5,
          ),
          employeeModel == null
              ? const SizedBox()
              : Container(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'MINUS DERI',
                              style: TextStyle(
                                  color:
                                      const Color(0xffb0b0b0).withOpacity(0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Center(
                                child: Text(
                              '${employeeModel!.allowedDebt}€',
                              style: const TextStyle(
                                  fontSize: 21, color: Color(0xff7e7d7e)),
                            ))
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey[200],
                          width: 0,
                        ),
                        Column(
                          children: [
                            Text(
                              'MARRJE',
                              style: TextStyle(
                                  color:
                                      const Color(0xffb0b0b0).withOpacity(0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              child: Center(
                                  child: Text(
                                '${employeeModel!.countTransactions()}€',
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff7e7d7e)),
                              )),
                            )
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey[200],
                          width: 0,
                        ),
                        Column(
                          children: [
                            Text(
                              'BILANCI',
                              style: TextStyle(
                                  color:
                                      const Color(0xffb0b0b0).withOpacity(0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              child: Center(
                                  child: Text(
                                '${employeeModel!.salary - employeeModel!.countTransactions()}€',
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff7e7d7e)),
                              )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                if (!fetchingEmployees) {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Container(
                            width: getPhoneWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    businessProvider.getEmployeeList().length,
                                    (index) {
                                  var employee =
                                      businessProvider.getEmployeeList()[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          businessProvider
                                              .getEmployeeList()
                                              .forEach((element) {
                                            element.selected = false;
                                          });
                                          setState(() {
                                            employee.selected = true;
                                            employeeModel = employee;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: getPhoneWidth(context),
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                employee.user!.username!,
                                                style: GoogleFonts.inter(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Container(
                                                width: 17,
                                                height: 17,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color: Colors.blue)),
                                                padding:
                                                    const EdgeInsets.all(1.6),
                                                child: employee.selected ==
                                                        false
                                                    ? const SizedBox()
                                                    : Container(
                                                        width: 17,
                                                        height: 17,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: Colors.blue),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      index + 1 ==
                                              businessProvider
                                                  .getEmployeeList()
                                                  .length
                                          ? const SizedBox()
                                          : const Divider()
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
              child: Container(
                width: getPhoneWidth(context),
                height: 46,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffebedef))),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fetchingEmployees
                          ? "Duke ngarkuar punetoret..."
                          : employeeModel == null
                              ? "Kerko puntorin"
                              : employeeModel!.user!.fullName!,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: employeeModel == null
                              ? const Color(0xff878787)
                              : Colors.black),
                    ),
                    fetchingEmployees
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.4,
                            ),
                          )
                        : SvgPicture.asset("assets/icons/arrow-down.svg",
                            width: 18, color: const Color(0xff878787))
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: debtAmount,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true), // Allow decimal numbers
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                  ],
                  decoration: InputDecoration(
                      hintText: 'Vlera e marrur',
                      hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color(0xff878787)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: const Color(0xffebedef))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: const Color(0xffebedef)))),
                ),
              )),
          // SizedBox(height: 49,width: MediaQuery.of(context).size.width-20,child: TextField(decoration: InputDecoration(hintText: 'Arsyeja',fillColor: Colors.white,filled: true,border: OutlineInputBorder())),),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Container(
                          width: getPhoneWidth(context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(list.length, (index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          reason.text = list[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: getPhoneWidth(context),
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: 45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              list[index],
                                              style: GoogleFonts.inter(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Container(
                                              width: 17,
                                              height: 17,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              padding:
                                                  const EdgeInsets.all(1.6),
                                              child: reason.text != list[index]
                                                  ? const SizedBox()
                                                  : Container(
                                                      width: 17,
                                                      height: 17,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.blue),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    index + 1 == list.length
                                        ? const SizedBox()
                                        : Divider(
                                            color: Colors.grey[200],
                                          )
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                width: getPhoneWidth(context),
                height: 46,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffebedef))),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reason.text.isEmpty ? "Arsyeja" : reason.text,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: employeeModel == null
                              ? const Color(0xff878787)
                              : Colors.black),
                    ),
                    SvgPicture.asset("assets/icons/arrow-down.svg",
                        width: 18, color: const Color(0xff878787))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          reason.text != "Tjeter"
              ? const SizedBox()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: description,
                      minLines: 3,
                      maxLines: 6,
                      decoration: InputDecoration(
                          hintText: 'Pershkrimi',
                          hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: const Color(0xff878787)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: const Color(0xffebedef))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: const Color(0xffebedef)))),
                    ),
                  )),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: getPhoneWidth(context),
              height: 46,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  onPressed: () {
                    var activeCheckout = checkoutProvider.getActiveCheckout();
                    if (activeCheckout != null) {
                      if (businessProvider.countBilance(context) as double <=
                          double.parse(debtAmount.text)) {
                        showErroModal(context,
                            "Vlera e dhene e tejkalon shumen e mbetur ne startimin te arkes\nShuma mbetur ne arke: ${businessProvider.countBilance(context)}");
                      } else {
                        addExpenses();
                      }
                    } else {
                      showErroModal(context,
                          "Nuk mund te shtoni shpenzim pa hapur arken!");
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue,
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Center(
                    child: addingExpense
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.4,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Shto',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
              )),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  Widget bilanci() {
    return Container(
      width: 80,
      height: 44,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(142, 255, 155, 0.44),
          borderRadius: BorderRadius.circular(10)),
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
