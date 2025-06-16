import 'dart:convert';
import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/transaction_category_model.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/checkout_provider.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/transactions_provider.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel? transactionModel;
  const EditTransactionScreen({Key? key, this.transactionModel})
      : super(key: key);

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  TextEditingController debtAmount = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController description = TextEditingController();
  EmployeeModel? employeeModel;
  TransactionCategoryModel? _transactionCategoryModel;
  bool editing = false;
  bool punetor = false;

  fetchEmployeeDetails() {}

  editTransaction() async {
    setState(() => editing = true);
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);


    TransactionModel transactionModel = TransactionModel(
      business: userProvider.getBusinessAdmin()!.business!.id,
      user: widget.transactionModel!.user,
      checkout: widget.transactionModel!.checkout,
      status: "active",
      reason: reason.text,
      type: type.text,


      price: double.parse(debtAmount.text),
      description: description.text,
      date: DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.now().add(const Duration(hours: 2))),
    );

    if (punetor == true) {
      transactionModel.user = employeeModel!.user;
      transactionModel.employee = employeeModel;

      await businessProvider.editTransaction(context, widget.transactionModel!.id,
           jsonEncode(transactionModel.toJson()));
    } else {
      transactionModel.transactionCategory = _transactionCategoryModel;
      await businessProvider.editTransaction(context, widget.transactionModel!.id, jsonEncode(transactionModel.toJson2()));
    }
    setState(() => editing = false);
  }

  @override
  void initState() {
    setState(() {
      debtAmount.text = widget.transactionModel!.price.toString();
      type.text = widget.transactionModel!.type.toString();
      reason.text = widget.transactionModel!.reason!;
      punetor = widget.transactionModel!.type == "employee" ? true : false;

      if(widget.transactionModel!.type != "employee"){
        _transactionCategoryModel = TransactionCategoryModel.fromJson(
            widget.transactionModel!.transactionCategory);
      }
      else{
        widget.transactionModel!.employee!.user = widget.transactionModel!.user;
        employeeModel = widget.transactionModel!.employee;
      }
    });

    super.initState();
  }

  List<String> list = <String>['Ushqim', 'Pije', 'Personale', 'Tjeter'];

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    var checkoutProvider = Provider.of<CheckoutProvider>(context);
    var transactionProvider = Provider.of<TransactionsProvider>(context);
print( widget.transactionModel!.employee);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // <-- this
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
          "Perditeso shpenzimin",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          widget.transactionModel!.type != "employee"
              ? SizedBox()
              : SizedBox(
                  height: 58,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xfff86164)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .minusUntil
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Center(
                                      child: Text(
                                    employeeModel!.withinSalary == true
                                        ? '${employeeModel!.allowedDebt}€'
                                        : '${(employeeModel!.allowedDebt + employeeModel!.salary)}€',
                                    style: const TextStyle(
                                        fontSize: 21, color: Colors.white),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff70ea7f)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .widthdraw
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Center(
                                      child: Text(
                                    '${employeeModel!.countTransactions().toStringAsFixed(2)}€',
                                    style: const TextStyle(
                                        fontSize: 21, color: Colors.white),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff2f86d7)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .balance
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        height: 1,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    employeeModel!.withinSalary == true
                                        ? '${employeeModel!.allowedDebt - employeeModel!.countTransactions()}€'
                                        : '${(employeeModel!.allowedDebt + employeeModel!.salary) - employeeModel!.countTransactions()}€',
                                    style: const TextStyle(
                                        height: 1,
                                        fontSize: 21,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          punetor == false
              ? Padding(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                        transactionProvider
                                            .getTransactionsCategories()
                                            .length, (index) {
                                      var transactionCategory =
                                          transactionProvider
                                                  .getTransactionsCategories()[
                                              index];
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              transactionProvider
                                                  .getTransactionsCategories()
                                                  .forEach((element) {
                                                element.selected = false;
                                              });

                                              setState(() {
                                                transactionCategory.selected =
                                                    true;
                                                _transactionCategoryModel =
                                                    transactionCategory;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: getPhoneWidth(context),
                                              color: Colors.transparent,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              height: 45,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    transactionCategory
                                                        .categoryName!,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Container(
                                                    width: 21,
                                                    height: 21,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.6),
                                                    child: transactionCategory
                                                                .selected ==
                                                            false
                                                        ? const SizedBox()
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          index + 1 ==
                                                  transactionProvider
                                                      .getTransactionsCategories()
                                                      .length
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
                            _transactionCategoryModel == null
                                ? "Kategoria shpenzimit"
                                : _transactionCategoryModel!.categoryName!,
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
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          employeeModel!.user!.fullName!,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: employeeModel == null
                                  ? const Color(0xff878787)
                                  : Colors.black),
                        ),
                        SvgPicture.asset("assets/icons/arrow-down.svg",
                            width: 18, color: const Color(0xff878787)),
                      ],
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
                      hintText: AppLocalizations.of(context)!.debtValue,
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
                              const BorderSide(color: Color(0xffebedef))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffebedef)))),
                ),
              )),
          // SizedBox(height: 49,width: MediaQuery.of(context).size.width-20,child: TextField(decoration: InputDecoration(hintText: 'Arsyeja',fillColor: Colors.white,filled: true,border: OutlineInputBorder())),),
          const SizedBox(
            height: 10,
          ),
          punetor != true
              ? SizedBox()
              : Padding(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children:
                                        List.generate(list.length, (index) {
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              height: 45,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    list[index],
                                                    style: GoogleFonts.inter(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Container(
                                                    width: 21,
                                                    height: 21,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.6),
                                                    child: reason.text !=
                                                            list[index]
                                                        ? const SizedBox()
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .blue),
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
                            reason.text.isEmpty
                                ? AppLocalizations.of(context)!.reason
                                : reason.text,
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
                          hintText: AppLocalizations.of(context)!.description,
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
                                  const BorderSide(color: Color(0xffebedef))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xffebedef)))),
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: getPhoneWidth(context),
            height: 46,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    // 1. Check if checkout is open

                    var balance = 0.0;
                    var activeCheckout = checkoutProvider.getCheckoutModel();
                    if (activeCheckout == null) {
                      showErroModal(context,
                          AppLocalizations.of(context)!.closedCheckoutMessage);
                      return;
                    }
                    // Check if is not employee add transaction
                    if (punetor == false) {
                      if (debtAmount.text.isEmpty ||
                          _transactionCategoryModel == null) {
                        showFailureModal(context, UnfilledDataFailure());

                        return;
                      }
                      //   check if typed price is bigger than checkout total price

                      if (businessProvider.countBilance(context) as double <=
                          double.parse(debtAmount.text)) {
                        showErroModal(context,
                            "${AppLocalizations.of(context)!.exceedCheckoutValueText} ${businessProvider.countBilance(context)}");
                        return;
                      }
                      editTransaction();
                    } else {
                      if (debtAmount.text.isEmpty ||
                          reason.text.isEmpty ||
                          employeeModel == null) {
                        showFailureModal(context, UnfilledDataFailure());

                        return;
                      }
                      //   check if typed price is bigger than checkout total price

                      if (businessProvider.countBilance(context) as double <=
                          double.parse(debtAmount.text)) {
                        showErroModal(context,
                            "${AppLocalizations.of(context)!.exceedCheckoutValueText} ${businessProvider.countBilance(context)}");
                        return;
                      }
                      //If it is employee
                      if (employeeModel!.withinSalary == true) {
                        balance = employeeModel!.allowedDebt -
                            employeeModel!.countTransactions() as double;
                      } else {
                        balance = (employeeModel!.allowedDebt +
                                employeeModel!.salary) -
                            employeeModel!.countTransactions() as double;
                      }

                      if (balance == 0.0) {
                        showErroModal(context,
                            "${employeeModel!.user!.fullName} ${AppLocalizations.of(context)!.reachedLimit}");
                        return;
                      }

                      if (checkoutProvider.getActiveCheckout() ==
                          CheckoutStatus.opened) {
                        if (double.parse(debtAmount.text) > balance) {
                          showErroModal(context,
                              AppLocalizations.of(context)!.aboveLimit);
                        } else {
                          editTransaction();
                        }
                      } else {
                        showErroModal(context,
                            AppLocalizations.of(context)!.oldCheckoutOpen,
                            size: 17);
                        return;
                      }
                    }
                  },
                  child: Container(
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
                            stops: [0.2, 0.5, 1])),
                    child: Center(
                      child: editing ? SizedBox(width: 25,height: 25,child: CircularProgressIndicator(strokeWidth: 1.8,color: Colors.white,)):Text(
                        AppLocalizations.of(context)!.edit,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )),
          ),

          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
