import 'package:business_menagament/core/consts/colors.dart';
import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/checkout_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/edit_transaction_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/checkout_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool fetchingTransactions = false;
  bool startingCheckout = false;
  bool fetchingEmployees = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCheckout();
      getExpenses(true);
      getEmployees();
    });

    super.initState();
  }

  getExpenses(bool first) async {
    setState(() => fetchingTransactions = true);
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    if (checkoutProvider.getActiveCheckout() != null) {
      if (first) {
        if (!businessProvider.getTransactionFirstLoad()) {
          await businessProvider.getExpenses(context);
          businessProvider.changeTransactionFirstLoad(true);
        }
      } else {
        await businessProvider.getExpenses(context);
      }
    }

    setState(() => fetchingTransactions = false);
  }

  getEmployees() async {
    setState(() => fetchingEmployees = true);
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    await businessProvider.getAllEmployees(context);
    setState(() => fetchingEmployees = false);
  }

  getCheckout() async {
    setState(() => startingCheckout = true);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    await checkoutProvider.getCheckouts(context)!;
    setState(() => startingCheckout = false);
  }

  deleteTransaction(id) async {
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              width: getPhoneWidth(context),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deleteTransactionTextAlert,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 17, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: getPhoneWidth(context) / 2 - 60,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue.withOpacity(0.7)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.no,
                                style: GoogleFonts.nunito(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await businessProvider.deleteTransaction(
                                context, id);
                          },
                          child: Container(
                            width: getPhoneWidth(context) / 2 - 60,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.yes,
                                style: GoogleFonts.nunito(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    var checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Container(
      width: getPhoneWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: RefreshIndicator(
        onRefresh: () async {
          getExpenses(false);
          getCheckout();
          getEmployees();
        },
        child: checkoutProvider.getCheckoutModel() != null
            ? SizedBox(
                width: getPhoneWidth(context),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    checkoutProvider.getActiveCheckout() ==
                            CheckoutStatus.opened
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: getPhoneWidth(context) / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: Border.all(
                                        color: const Color(0xffd9dce1))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .startedPrice,
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey[600]),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "${checkoutProvider.getCheckoutModel()!.startPrice}€",
                                      style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: getPhoneWidth(context) / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: Border.all(
                                        color: const Color(0xffd9dce1))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .dailyTransactions,
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey[600]),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "${businessProvider.calculateAllExpenses(context).toStringAsFixed(2) }€",
                                      style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : checkoutProvider.getActiveCheckout() ==
                                CheckoutStatus.passed
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/cash-icon.png",
                                    color: const Color(0xff324a60),
                                    width: getPhoneWidth(context) * 0.7,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) =>
                                                  const CheckoutUpdateScreen(
                                                      isOpen: false)))
                                          .then((value) {
                                        getCheckout();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: getPhoneWidth(context) * 0.9,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .openedCashboxText,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                            color: const Color(0xff324a60),
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) =>
                                                  const CheckoutUpdateScreen(
                                                      isOpen: true)))
                                          .then((value) {
                                        getCheckout();
                                      });
                                    },
                                    child: Container(
                                      width: getPhoneWidth(context) * 0.8,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color(0xff3f617e),
                                                Color(0xff324a60),
                                                defaultColor3,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              stops: [0.2, 0.5, 1])),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .closeCashbox,
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (_) =>
                                              const CheckoutUpdateScreen(
                                                  isOpen: false)))
                                      .then((value) {
                                    getCheckout();
                                  });
                                },
                                child: Container(
                                  width: getPhoneWidth(context) * 0.8,
                                  height: 50,
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
                                      child: Text(
                                    AppLocalizations.of(context)!.openCashbox,
                                    style: GoogleFonts.nunito(
                                        color: Colors.white, fontSize: 17),
                                  )),
                                ),
                              ),
                    checkoutProvider.getActiveCheckout() !=
                            CheckoutStatus.opened
                        ? const SizedBox()
                        : ListView(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppLocalizations.of(context)!.dailyActivity,
                                style: GoogleFonts.nunito(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              fetchingTransactions
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      strokeWidth: 1.6,
                                    ))
                                  : checkoutProvider.getActiveCheckout() ==
                                              CheckoutStatus.opened ||
                                          checkoutProvider
                                                  .getActiveCheckout() ==
                                              CheckoutStatus.passed
                                      ? businessProvider
                                              .getExpensesList()
                                              .isEmpty
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .noActitivy,
                                            )
                                          : ListView.builder(
                                              itemCount: businessProvider
                                                  .getExpensesList()
                                                  .length,
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                TransactionModel expense =
                                                    businessProvider
                                                            .getExpensesList()[
                                                        index];
                                                return Slidable(
                                                    key: ValueKey(index),
                                                    // The start action pane is the one at the left or the top side.
                                                    endActionPane: ActionPane(
                                                      extentRatio: 0.4,
                                                      // A motion is a widget used to control how the pane animates.
                                                      motion:
                                                          const ScrollMotion(),
                                                      dragDismissible: false,
                                                      // A pane can dismiss the Slidable.
                                                      dismissible:
                                                          DismissiblePane(
                                                              onDismissed:
                                                                  () {}),

                                                      // All actions are defined in the children parameter.
                                                      children: [
                                                        // A SlidableAction can have an icon and/or a label.
                                                        GestureDetector(
                                                          onTap: () {
                                                            deleteTransaction(
                                                                expense.id);
                                                          },
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            width: 65,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .red),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        EditTransactionScreen(
                                                                          transactionModel:
                                                                              expense,
                                                                        )));
                                                          },
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            width: 65,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    color: const Color(
                                                                        0xFF21B7CA),
                                                                  ),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    child: TransactionCard(
                                                      transactionModel: expense,
                                                      index: index,
                                                      businessProvider:
                                                          businessProvider,
                                                    ));
                                              })
                                      : Text(
                                          AppLocalizations.of(context)!
                                              .noActitivy,
                                        )
                            ],
                          ),
                  ],
                ),
              )
            : SizedBox(
                width: getPhoneWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/cash-icon.png",
                      color: const Color(0xff324a60),
                      width: getPhoneWidth(context) * 0.7,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: getPhoneWidth(context) * 0.9,
                        child: Text(
                          AppLocalizations.of(context)!.openCashboxText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              color: const Color(0xff324a60), fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) =>
                                    const CheckoutUpdateScreen(isOpen: false)))
                            .then((value) {
                          getCheckout();
                        });
                      },
                      child: Container(
                        width: getPhoneWidth(context) * 0.8,
                        height: 50,
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
                            child: Text(
                          AppLocalizations.of(context)!.openCashbox,
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 17),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionModel? transactionModel;
  final int? index;
  final BusinessProvider? businessProvider;
  const TransactionCard(
      {Key? key,
      required this.transactionModel,
      required this.index,
      required this.businessProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transactionModel!.type == "employee") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: Center(
                child: Text(
                  transactionModel!.user!.fullName!.substring(0, 1),
                  style: GoogleFonts.nunito(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[700]),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getPhoneWidth(context) - 90,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transactionModel!.user!.fullName!,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff121212)),
                        ),
                        Text(
                          "-${transactionModel!.price!.toDouble()}€",
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: const Color(0xffe33437)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: getPhoneWidth(context) - 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDateFormat(transactionModel!.updatedAt!),
                        style:
                            GoogleFonts.poppins(color: const Color(0xff929cb2)),
                      ),
                      calculateCurrentExpense(
                          index, businessProvider, transactionModel!),
                    ],
                  ),
                ),
                SizedBox(
                    width: getPhoneWidth(context) - 100,
                    child: Divider(
                      height: 10,
                      color: Colors.grey[100],
                    )),
              ],
            )
          ],
        ),
      );
    }
    print(transactionModel!.transactionCategory);
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            child: Center(
              child: Text(
                transactionModel!.transactionCategory['category_name']
                    .substring(0, 1),
                style: GoogleFonts.nunito(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700]),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getPhoneWidth(context) - 90,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        transactionModel!.transactionCategory['category_name'],
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff121212)),
                      ),
                      Text(
                        "-${transactionModel!.price!.toDouble()}€",
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: const Color(0xffe33437)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: getPhoneWidth(context) - 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getDateFormat(transactionModel!.updatedAt!),
                      style:
                          GoogleFonts.poppins(color: const Color(0xff929cb2)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: getPhoneWidth(context) - 90,
                  child: Divider(
                    height: 10,
                    color: Colors.grey[100],
                  )),
            ],
          )
        ],
      ),
    );
  }

  calculateCurrentExpense(index, businessProvider, TransactionModel expense) {
    // if(index > 0){
    //   return Text(
    //     " ${(businessProvider.getExpensesList()[index - 1].employee!.salary - businessProvider.getExpensesList()[index - 1].price!) - expense.price!}",
    //     style: GoogleFonts.poppins(
    //         color: const Color(0xff1860f2),
    //         fontWeight: FontWeight.w400),
    //   );
    // }
    // return Text(
    //   " ${  expense.employee!.salary - expense.price!  }",
    //   style: GoogleFonts.poppins(
    //       color: const Color(0xff1860f2),
    //       fontWeight: FontWeight.w400),
    // );
    return Text(
      " ${expense.employee!.salary.toDouble()}€",
      style: GoogleFonts.poppins(
          color: const Color(0xff1860f2), fontWeight: FontWeight.w400),
    );
  }
}
