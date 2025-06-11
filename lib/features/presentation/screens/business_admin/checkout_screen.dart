import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/consts/utils.dart';
import 'package:hr_smart/features/models/checkout_model.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/open_checkout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> scaffoldKe = GlobalKey<ScaffoldState>();
  TextEditingController dateinput = TextEditingController();

  bool fetchingCheckout = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCheckouts();
    });
    super.initState();
  }

  getCheckouts() async {
    setState(() => fetchingCheckout = true);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    await checkoutProvider.getCheckouts(context);
    setState(() => fetchingCheckout = false);
  }

  @override
  Widget build(BuildContext context) {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    return Scaffold(
      key: scaffoldKe,
      appBar: AppBar(
        backgroundColor: Colors.white, // <-- this
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
          "Hap diten",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: false,
      ),
      body: ListView(children: [
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10),
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 13,
                child: ElevatedButton(
                  onPressed: () {
                    if (checkoutProvider.getActiveCheckout() == null) {
                      Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) =>
                                const CheckoutUpdateScreen(isOpen: false),
                          )).then((value) {
                            getCheckouts();
                      });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(50, 74, 89, 1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: Text(
                    checkoutProvider.getActiveCheckout() == null
                        ? 'Hap diten'
                        : 'Dita e hapur',
                    style: const TextStyle(
                        color: Color.fromRGBO(216, 216, 216, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                )),
            const SizedBox(
              width: 5,
            ),
            Container(
                margin: const EdgeInsets.only(right: 10),
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 13,
                child: ElevatedButton(
                  onPressed: () {
                    if (checkoutProvider.getActiveCheckout() != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CheckoutUpdateScreen(isOpen: true),
                          )).then((value) {
                        getCheckouts();
                      });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(50, 74, 89, 1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: const Text(
                    'Mbyll diten',
                    style: TextStyle(
                        color: Color.fromRGBO(216, 216, 216, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                )),
          ],
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Container(
        //   margin: const EdgeInsets.only(left: 10, right: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //           width: MediaQuery.of(context).size.width / 2 - 13,
        //           height: 50,
        //           child: TextField(
        //             decoration: InputDecoration(
        //                 border: OutlineInputBorder(
        //                     borderSide: BorderSide.none,
        //                     borderRadius: BorderRadius.circular(4)),
        //                 contentPadding: const EdgeInsets.all(16),
        //                 hintText: 'Search',
        //                 fillColor: const Color.fromRGBO(247, 248, 251, 6),
        //                 prefixIcon: const Icon(Icons.search),
        //                 filled: true,
        //                 hintStyle: const TextStyle(
        //                     color: Color.fromRGBO(0, 24, 51, 0.22))),
        //           )),
        //       const SizedBox(
        //         width: 5,
        //       ),
        //       SizedBox(
        //           width: MediaQuery.of(context).size.width / 2 - 13,
        //           height: 50,
        //           child: TextField(
        //             controller: dateinput,
        //             decoration: InputDecoration(
        //                 border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(4),
        //                     borderSide: BorderSide.none),
        //                 filled: true,
        //                 fillColor: const Color.fromRGBO(247, 248, 251, 1),
        //                 hintText: 'Muaji',
        //                 hintStyle: const TextStyle(
        //                     color: Color.fromRGBO(0, 24, 51, 0.22)),
        //                 prefixIcon: const Icon(Icons.date_range),
        //                 suffixIcon: const Icon(Icons.arrow_drop_down)),
        //             readOnly:
        //                 true, //set it true, so that user will not able to edit text
        //             onTap: () async {
        //               DateTime currentDate = DateTime.now();
        //
        //               DateTime? pickedDate = await showDatePicker(
        //                 context: context,
        //                 initialDate: currentDate,
        //                 firstDate: DateTime(currentDate.year - 1),
        //                 lastDate: DateTime(currentDate.year + 1),
        //                 builder: (BuildContext context, Widget? child) {
        //                   return Theme(
        //                     data: ThemeData.light().copyWith(
        //                       primaryColor: const Color.fromRGBO(
        //                           228, 213, 201, 1), // Customize color here
        //                       hintColor: Colors.teal, // Customize color here
        //                       colorScheme: const ColorScheme.light(
        //                           primary: Color.fromRGBO(228, 213, 201, 1)),
        //                       buttonTheme: const ButtonThemeData(
        //                           textTheme: ButtonTextTheme.primary),
        //                     ),
        //                     child: child!,
        //                   );
        //                 },
        //                 initialDatePickerMode: DatePickerMode.year,
        //               );
        //
        //               if (pickedDate != null) {
        //                 String formattedDate =
        //                     "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}";
        //
        //                 print(
        //                     pickedDate); // Picked date format => 2023-08-01 00:00:00.000
        //                 print(formattedDate); // Formatted date => 2023-08
        //
        //                 setState(() {
        //                   dateinput.text =
        //                       formattedDate; // Update TextField value
        //                 });
        //               } else {
        //                 print("Date is not selected");
        //               }
        //             },
        //           )),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 30,
        ),
        RefreshIndicator(
            onRefresh: () async {
              getCheckouts();
            },
            child: checkoutTable(context, checkoutProvider))
      ]),
      backgroundColor: Colors.white,
    );
  }

  checkoutTable(context, CheckoutProvider checkoutProvider) {
    var partWidth = getPhoneWidth(context) / 3;
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: checkoutProvider.getCheckoutList().length,
      itemBuilder: (context, index) {
        CheckoutModel checkoutModel = checkoutProvider.getCheckoutList()[index];
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              index == 0
                  ? Container(
                      height: 50,
                      color: const Color.fromRGBO(55, 159, 255, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: partWidth,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Filloj me',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: partWidth,
                            child: const Text(
                              'Mbaroj me',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: partWidth,
                            child: const Text(
                              'Hapur ne',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: partWidth,
                            child: const Text(
                              'Mbyllur ne',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: partWidth,
                            child: const Text(
                              'Muaji',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: partWidth,
                            child: const Text(
                              'Pershkrimi',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: partWidth,
                            child: const Text(
                              'Opsione',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Container(
                height: 50,
                color: const Color.fromRGBO(0, 24, 51, 0.2),
                child: Row(
                  children: [
                    SizedBox(
                        width: partWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(checkoutModel.startPrice.toString() + "€"),
                        )),
                    SizedBox(
                        width: partWidth,
                        child: Text(
                            checkoutModel.closedPrice  == null ?  "Arka hapur":checkoutModel.closedPrice.toString(),
                          style: GoogleFonts.nunito(fontSize: 13),
                        )),
                    SizedBox(
                        width: partWidth,
                        child: Text(
                            getTimeFormat(checkoutModel.startedDate!),
                          style: GoogleFonts.nunito(fontSize: 13),
                        )),
                    SizedBox(
                        width: partWidth,
                        child: Text(
                            checkoutModel.closedDate == null ? "Arka hapur": getTimeFormat(checkoutModel.closedDate!),
                          style: GoogleFonts.nunito(fontSize: 13),
                        )),
                    SizedBox(
                        width: partWidth,
                        child: Text(
                          getMonthOnlyFormat(checkoutModel.startedDate!),
                          style: GoogleFonts.nunito(fontSize: 13),
                        )),
                    SizedBox(
                        width: partWidth,
                        child: Text(
                          checkoutModel.description!,
                          style: GoogleFonts.nunito(fontSize: 13),
                        )),
                    SizedBox(
                        width: partWidth,
                        // child:
                        // TextButton(
                        //   onPressed: (){},
                        //   child: const Text("Edito"),
                        // )
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
