import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/consts/utils.dart';
import 'package:hr_smart/features/models/checkout_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getExpenses();
      getCheckout();
    });

    super.initState();
  }

  getExpenses() async {
    setState(() => fetchingTransactions = true);
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    await businessProvider.getExpenses(context);
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
    await checkoutProvider.getCheckout(context);
    setState(() => startingCheckout = false);
  }

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    var checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: RefreshIndicator(
        onRefresh: () async {
          getExpenses();
          getCheckout();
          getEmployees();
        },
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const SizedBox(
              height: 20,
            ),
            checkoutProvider.getActiveCheckout() == null
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CheckoutScreen()));
                    },
                    child: Container(
                      width: getPhoneWidth(context) * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: Center(
                          child: Text(
                        "Fillo diten",
                        style: GoogleFonts.nunito(
                            color: Colors.white, fontSize: 17),
                      )),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: getPhoneWidth(context) / 2 - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(color: const Color(0xffd9dce1))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fillimi",
                              style:
                                  GoogleFonts.poppins(color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${checkoutProvider.getActiveCheckout()!.startPrice}€",
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
                            border: Border.all(color: const Color(0xffd9dce1))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shpenzime ditore",
                              style:
                                  GoogleFonts.poppins(color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${businessProvider.calculateAllExpenses()}€",
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Aktiviteti ditor",
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
                : businessProvider.getExpensesList().isEmpty
                    ? const Text("Nuk ka aktivitet!")
                    : ListView.builder(
                        itemCount: businessProvider.getExpensesList().length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var expense =
                              businessProvider.getExpensesList()[index];
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
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.grey[400],
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
                                      width: getPhoneWidth(context) - 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              expense.user!.fullName!,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff121212)),
                                            ),
                                            Text(
                                              "-${expense.price}€",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0xffe33437)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getPhoneWidth(context) - 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getDateFormat(expense.updatedAt!),
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff929cb2)),
                                          ),
                                          calculateCurrentExpense(
                                              index, businessProvider, expense),
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
                        })
          ],
        ),
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
      " ${expense.employee!.salary}€",
      style: GoogleFonts.poppins(
          color: const Color(0xff1860f2), fontWeight: FontWeight.w400),
    );
  }
}
