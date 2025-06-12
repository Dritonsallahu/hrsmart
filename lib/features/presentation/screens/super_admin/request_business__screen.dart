import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/features/controllers/super_admin_controllers/super_admin_controller.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RequestBusinessScreen extends StatefulWidget {
  final BusinessModel? businessModel;
  const RequestBusinessScreen({Key? key, required this.businessModel})
      : super(key: key);

  @override
  State<RequestBusinessScreen> createState() => _RequestBusinessScreenState();
}

class _RequestBusinessScreenState extends State<RequestBusinessScreen> {
  TextEditingController businessName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController businessNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController startingDate = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController active = TextEditingController();

  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isTesting = true;
  bool requesting = false;

  @override
  void initState() {
    businessName.text = widget.businessModel!.name ?? "";
    city.text = widget.businessModel!.city ?? "";
    country.text = widget.businessModel!.country ?? "";
    businessNumber.text = widget.businessModel!.businessNumber ?? "";
    phoneNumber.text = widget.businessModel!.phoneNumber ?? "";
    comment.text = widget.businessModel!.comment ?? "";
    startingDate.text = widget.businessModel!.startingDate ?? "";
    status.text = widget.businessModel!.status ?? "";
    active.text = widget.businessModel!.active.toString() ?? "";
    super.initState();
  }

  acceptBusiness() async {
    setState(() => requesting = true);
    SuperAdminController superAdminController = SuperAdminController();
    var data = await superAdminController
        .acceptBusinessRequest(widget.businessModel!.id, {
      "businessName": businessName.text,
      "city": city.text,
      "country": country.text,
      "businessNumber": businessNumber.text,
      "phoneNumber": phoneNumber.text,
      "comment": comment.text,
      "startingDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
      "status": isTesting ? "testing" : "approved",
      "fullName": fullName.text,
      "username": username.text,
      "email": email.text,
      "password": password.text,
    });
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      setState(() {
        businessName.text = "";
        city.text = "";
        country.text = "";
        phoneNumber.text = "";
        comment.text = "";
      });
      showErroModal(context, "Biznesi u pranua me sukses!", size: 12);
    });
    setState(() => requesting = false);
  }

  cancelBusiness() {}

  @override
  Widget build(BuildContext context) {
    const gapHeight = 6.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kerkesat"),
        foregroundColor: Colors.black,
      ),
      body: Container(
        width: getPhoneWidth(context),
        child: ListView(
          children: [
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: businessName,
                    decoration: InputDecoration(
                        hintText: 'Emri biznesit',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: city,
                    decoration: InputDecoration(
                        hintText: 'Qyteti',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: country,
                    decoration: InputDecoration(
                        hintText: 'Shteti',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: businessNumber,
                    decoration: InputDecoration(
                        hintText: 'Numri biznesit',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: phoneNumber,
                    decoration: InputDecoration(
                        hintText: 'Numri telefonit',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: comment,
                    decoration: InputDecoration(
                        hintText: 'Komenti',
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
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    startingDate.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
              child: Container(
                  color: Colors.transparent,
                  height: 49,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: startingDate,
                      enabled: false,
                      style: GoogleFonts.nunito(
                        color: startingDate.text.isEmpty
                            ? const Color(0xff878787)
                            : Colors.black
                      ),
                      decoration: InputDecoration(
                          hintText: 'Data fillimit',
                          hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: startingDate.text.isEmpty
                                  ? const Color(0xff878787)
                                  : Colors.black),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xffebedef))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xffebedef))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xffebedef)))),
                    ),
                  )),
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
                    controller: status,
                    decoration: InputDecoration(
                        hintText: 'Statusi',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: fullName,
                    decoration: InputDecoration(
                        hintText: 'Emri i plote',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                        hintText: 'Emri i perdoruesit',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: 'Adresa elektronike',
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
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: 'Fjalekalimi',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTesting = true;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: const Color.fromRGBO(50, 74, 89, 1),
                                  width: 1.6)),
                          padding: const EdgeInsets.all(2),
                          child: !isTesting
                              ? const SizedBox()
                              : Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromRGBO(50, 74, 89, 1),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Testim')
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTesting = false;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: const Color.fromRGBO(50, 74, 89, 1),
                                  width: 1.6)),
                          padding: const EdgeInsets.all(2),
                          child: isTesting
                              ? const SizedBox()
                              : Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromRGBO(50, 74, 89, 1),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Aprovuar')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: gapHeight + 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 49,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: Center(
                    child: Text(
                      "Refuzo",
                      style: GoogleFonts.nunito(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    acceptBusiness();
                  },
                  child: Container(
                    height: 49,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: Center(
                      child: requesting
                          ? SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeAlign: 1.2,
                              ))
                          : Text(
                              "Prano",
                              style: GoogleFonts.nunito(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
