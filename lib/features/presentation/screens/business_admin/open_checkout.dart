import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/features/models/checkout_model.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutUpdateScreen extends StatefulWidget {
  final bool? isOpen;
  const CheckoutUpdateScreen({Key? key, required this.isOpen})
      : super(key: key);

  @override
  State<CheckoutUpdateScreen> createState() => _CheckoutUpdateScreenState();
}

class _CheckoutUpdateScreenState extends State<CheckoutUpdateScreen> {
  final GlobalKey<ScaffoldState> scaffoldKee = GlobalKey<ScaffoldState>();

  DateTime choosedDate = DateTime.now();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();

  bool startingCheckout = false;

  startDay() async {
    setState(() => startingCheckout = true);
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    CheckoutModel checkoutModel = CheckoutModel(
      business: userProvider.getUser()!.businessModel,
      userModel: userProvider.getUser()!,
      active: true,
      startedDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
      description: _description.text,
      closed: false,
      startPrice: double.parse(_price.text),
    );
    await checkoutProvider.startCheckout(context, checkoutModel);
    setState(() => startingCheckout = false);
  }

  closeDay() async {
    setState(() => startingCheckout = true);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    await checkoutProvider.closeCheckout(context,
        checkoutProvider.getActiveCheckout()!.id, double.parse(_price.text));
    setState(() => startingCheckout = false);
  }

  @override
  Widget build(BuildContext context) {
    var checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Scaffold(
      key: scaffoldKee,
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  if (widget.isOpen == false) {
                    if (pickedDate.isBefore(
                        DateTime.now().subtract(const Duration(days: 1)))) {
                      showErroModal(
                          context, "Data duhet te jete me e madhe se sot",
                          size: 18);
                    } else {
                      setState(() => choosedDate = pickedDate);
                    }
                  } else {
                    if (checkoutProvider.getActiveCheckout() != null) {
                      if (pickedDate.isBefore(DateFormat('yyyy-MM-dd')
                          .parse(checkoutProvider
                              .getActiveCheckout()!
                              .startedDate!))) {
                        showErroModal(
                            context, "Data nuk duhet te jete me e vogel se sot",
                            size: 18);
                      }
                      else  if (pickedDate
                          .isAfter(DateFormat('yyyy-MM-dd')
                          .parse(checkoutProvider
                          .getActiveCheckout()!
                          .startedDate!))) {
                        showErroModal(context,
                            "KUJDES!\nKeni zgjedhur daten me te madhe se data e startimit te arkes",
                            size: 18);
                        setState(() => choosedDate = pickedDate);
                      }
                      else{
                        setState(() => choosedDate = pickedDate);
                      }

                    } else {
                      showErroModal(context,
                          "Jeni duke zgjedhur daten me te madhe se data e startimit te arkes",
                          size: 18);
                    }
                  }
                } else {
                  print("Date is not selected");
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
                      DateFormat('yyyy-MM-dd').format(choosedDate),
                      style:
                          GoogleFonts.inter(fontSize: 15, color: Colors.black),
                    ),
                    1 == 2
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.4,
                            ),
                          )
                        : SvgPicture.asset("assets/icons/calendar-1.svg",
                            width: 22, color: const Color(0xff878787))
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
                  controller: _price,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true), // Allow decimal numbers
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                  ],
                  decoration: InputDecoration(
                      hintText:
                          'Vlera e ${widget.isOpen! ? 'mbyllese' : 'startuese'}',
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
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(color: Color(0xffebedef)))),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
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
                          borderSide:
                              const BorderSide(color: Color(0xffebedef))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffebedef)))),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.isOpen!) {
                    closeDay();
                  } else {
                    startDay();
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                        // const Color.fromRGBO(50, 74, 89, 1)
                        Colors.blue)),
                child: startingCheckout
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.6,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        widget.isOpen! ? 'Mbyll diten' : 'Fillo diten',
                        style: GoogleFonts.nunito(fontSize: 17),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
