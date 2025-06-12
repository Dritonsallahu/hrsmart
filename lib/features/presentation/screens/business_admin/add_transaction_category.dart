import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/presentation/providers/transactions_provider.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class TransactionCategoryScreen extends StatefulWidget {
  const TransactionCategoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionCategoryScreen> createState() =>
      _TransactionCategoryScreenState();
}

class _TransactionCategoryScreenState extends State<TransactionCategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKee = GlobalKey<ScaffoldState>();
  TextEditingController categoryName = TextEditingController();

  bool fetching = false;
  bool adding = false;

  addNewCost() async {
    setState(() => adding = true);
    var transactionProvider =
        Provider.of<TransactionsProvider>(context, listen: false);

    if (categoryName.text.isEmpty) {
      showFailureModal(context, UnfilledDataFailure());
      setState(() => adding = false);
      return;
    }
    await transactionProvider.addTransactionCategory(
        context, categoryName.text);

    setState(() => adding = false);
  }

  getTransactionCategories() async {
    setState(() => fetching = true);
    var transactionProvider =
        Provider.of<TransactionsProvider>(context, listen: false);

    await transactionProvider.getAllTransactionsCategories(context);

    setState(() => fetching = false);
  }

  deleteTransactionCategory(id) async {
    setState(() => fetching = true);
    var transactionProvider =
        Provider.of<TransactionsProvider>(context, listen: false);

    await transactionProvider.deleteTransactionCategory(context, id);

    setState(() => fetching = false);
  }

  List<String> list = <String>['Ushqim', 'Pije', 'Personale', 'Tjeter'];

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.addCategory,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () async {
            getTransactionCategories();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 49,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: categoryName,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.categoryName,
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
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: getPhoneWidth(context),
                height: 46,
                child: GestureDetector(
                  onTap: () {
                    addNewCost();
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
                      child: adding
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.4,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.addCategory,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.catgories,
                style: GoogleFonts.nunito(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              fetching
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.9,
                        color: Colors.black,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: transactionProvider
                          .getTransactionsCategories()
                          .length,
                      itemBuilder: (context, index) {
                        var transactionCategory = transactionProvider
                            .getTransactionsCategories()[index];
                        return Column(
                          children: [
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transactionCategory.categoryName!,
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      deleteTransactionCategory(transactionCategory.id);
                                    },
                                    child: Container(
                                        width: 50,
                                        height: 40,
                                        color: Colors.transparent,
                                        child: Center(
                                            child: Text(
                                          AppLocalizations.of(context)!.delete,
                                          style: GoogleFonts.nunito(
                                              color: Colors.red[900],
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
