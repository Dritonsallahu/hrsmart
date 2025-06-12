import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/features/models/checkout_model.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/daily_transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class CheckoutListScreen extends StatefulWidget {
  final List<CheckoutModel> checkouts;
  const CheckoutListScreen({Key? key,required this.checkouts}) : super(key: key);

  @override
  State<CheckoutListScreen> createState() => _CheckoutListScreenState();
}

class _CheckoutListScreenState extends State<CheckoutListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.cashboxList,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(itemBuilder: (context, index){
          var checkout = widget.checkouts[index];
          if(checkout.closed == true){
            try{
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DailyTransactionsScreen(date:   getDateFormat2(checkout.startedDate!),id: checkout.id,)));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xffdee0e1).withOpacity(0.5),
                            spreadRadius: 0.9,
                            blurRadius: 4,
                            offset: const Offset(0, 1))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getMonthName(DateFormat('yyyy-MM-dd').parse(checkout.updatedAt!).month),
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: const Color(0xff181818),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const Divider(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.startedDate,
                                      style: GoogleFonts.nunito(
                                          fontSize: 16, color: const Color(0xff858485)),
                                    ),
                                    Text(
                                      getDateFormat2(checkout.startedDate!),
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff181818),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.closedDate,
                                      style: GoogleFonts.nunito(
                                          fontSize: 16, color: const Color(0xff858485)),
                                    ),
                                    Text(
                                      getDateFormat2(checkout.closedDate!),
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff181818),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.startPrice,
                                      style: GoogleFonts.nunito(
                                          fontSize: 16, color: const Color(0xff858485)),
                                    ),
                                    Text("${checkout.startPrice.toDouble()}€",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff181818),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.closedPrice,
                                      style: GoogleFonts.nunito(
                                          fontSize: 16, color: const Color(0xff858485)),
                                    ),
                                    Text("${checkout.closedPrice.toDouble()}€",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff181818),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.description,
                              style: GoogleFonts.nunito(
                                  fontSize: 16, color: const Color(0xff858485)),
                            ),
                            checkout.description!.isEmpty ? const SizedBox():Text(
                              checkout.description.toString(),
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: const Color(0xff181818),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            catch(e){
              return   Text(AppLocalizations.of(context)!.checkoutCalculatingError);
            }
          }
          else{
            return const SizedBox();
          }

        },itemCount: widget.checkouts.length,),
      ),
    );
  }
}
