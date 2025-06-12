import 'package:business_menagament/core/consts/colors.dart';
import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class DailyTransactionsScreen extends StatefulWidget {
  final String? id;
  final String? date;
  const DailyTransactionsScreen(
      {Key? key, required this.date, required this.id})
      : super(key: key);

  @override
  State<DailyTransactionsScreen> createState() =>
      _DailyTransactionsScreenState();
}

class _DailyTransactionsScreenState extends State<DailyTransactionsScreen> {
  List<TransactionModel> _transactions = []; // Filtered
  List<TransactionModel> _transactionsAll = [];

  int selectedItem = 1;
  double price = 0.00;

  bool fetching = false;
  getTransactions() async {
    setState(() => fetching = true);
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    var transactions =
        await businessProvider.getTransactionByCheckout(context, widget.id);
    if (transactions != null) {
      setState(() {
        _transactions = transactions;
        _transactionsAll = transactions;
        selectedItem = 1;
      });
    }
    getFilteredTransactions(1);
    setState(() => fetching = false);
  }

  getFilteredTransactions(int index) {
    price = 0.0;
    _transactions = [];
    if (index == 1) {
      _transactions = _transactionsAll;
      for (var element in _transactionsAll) {

          price += element.price!;

      }} else if (index == 2) {
      for (var element in _transactionsAll) {
        if (element.type == "employee") {
          _transactions.add(element);
          price += element.price!;
        }
      }
    }else if (index == 3) {
      for (var element in _transactionsAll) {
        if (element.type == "product") {
          _transactions.add(element);
          price += element.price!;
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTransactions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.date!,
            style: GoogleFonts.poppins(fontSize: 17),
          ),
          centerTitle: true,
          actions: [
            Text("${price}€",style: GoogleFonts.nunito(fontSize: 17),),
            SizedBox(width: 15,),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getTransactions();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(selectedItem == 1){
                            return;
                          }
                          setState(() {
                            selectedItem = 1;
                          });
                          getFilteredTransactions(1);
                        },
                        child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: selectedItem != 1
                                      ? defaultColor3
                                      : Colors.white),
                              color: selectedItem != 1
                                  ? Colors.white
                                  : defaultColor3),
                          duration: const Duration(milliseconds: 200),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.all,
                              style: GoogleFonts.nunito(
                                  color: selectedItem != 1
                                      ? defaultColor3
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(selectedItem == 2){
                            return;
                          }
                          setState(() {
                            selectedItem = 2;
                          });
                          getFilteredTransactions(2);
                        },
                        child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: selectedItem != 2
                                      ? defaultColor3
                                      : Colors.white),
                              color: selectedItem != 2
                                  ? Colors.white
                                  : defaultColor3),
                          duration: const Duration(milliseconds: 200),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.employee,
                              style: GoogleFonts.nunito(
                                  color: selectedItem != 2
                                      ? defaultColor3
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(selectedItem == 3){
                            return;
                          }
                          setState(() {
                            selectedItem = 3;
                          });
                          getFilteredTransactions(3);
                        },
                        child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: selectedItem != 3
                                      ? defaultColor3
                                      : Colors.white),
                              color: selectedItem != 3
                                  ? Colors.white
                                  : defaultColor3),
                          duration: const Duration(milliseconds: 200),
                          child: Center(
                            child: Text(
                              "Products",
                              style: GoogleFonts.nunito(
                                  color: selectedItem != 3
                                      ? defaultColor3
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              fetching
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.8,
                        color: Colors.black,
                      ),
                    )
                  : _transactions.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.noTransactions,
                            style: GoogleFonts.nunito(
                                fontSize: 18, color: Colors.grey[800]),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: _transactions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TransactionCard(
                                transactionModel: _transactions[index],
                                index: index,
                                businessProvider: null,
                              ),
                            );
                          }),
            ],
          ),
        ));
  }
}
