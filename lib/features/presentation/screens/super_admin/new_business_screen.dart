import 'package:hr_smart/features/controllers/super_admin_controllers/super_admin_controller.dart';
import 'package:hr_smart/controller/signup.dart';
import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewBusinessScreen extends StatefulWidget {
  const NewBusinessScreen({Key? key}) : super(key: key);

  @override
  State<NewBusinessScreen> createState() => _NewBusinessScreenState();
}

class _NewBusinessScreenState extends State<NewBusinessScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();

  TextEditingController businessName = TextEditingController();
  TextEditingController registeredDate = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController businessNumber = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController addedBy = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController businessStatus = TextEditingController();

  bool isTesting = true;
  bool registering = false;
  int id = 0;

  //per adding as user

  var paga = TextEditingController(text: 'pronari-no-need-data');
  var min = TextEditingController(text: 'pronari-no-need-data');
  var datapag = TextEditingController(text: 'pronari-no-need-data');
  var category = TextEditingController(text: 'menaxher');
  SuperAdminController businessController = SuperAdminController();

  Signup signup = Signup(); //regjistro pronarin

  @override
  Widget build(BuildContext context) {
    const gapHeight = 6.0;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Biznes i ri",
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: gapHeight),
          Form(
              key: fkey,
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: businessName,
                        hintText: "Emri biznesit",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: userName,
                        hintText: "Emri perdoruesit",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: email,
                        hintText: "Email",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: password,
                        hintText: "Fjalekalimi",
                        isPassword: true,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: registeredDate,
                        hintText: "00/00/0000",
                        isPassword: false,
                        hasPrefix: true,
                        hasSufix: true,
                        isReadOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              registeredDate.text = formattedDate;
                            });
                          } else {}
                        },
                        preffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 39,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: phoneNumber,
                        hintText: "Nr telefonit",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: city,
                        hintText: "Qyteti",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: country,
                        hintText: "Shteti",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: businessNumber,
                        hintText: "Numri biznesit",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: comment,
                        hintText: "Komenti",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: FormWidget(
                        textEditingController: ownerName,
                        hintText: "Emri i pronarit",
                        isPassword: false,
                        hasPrefix: false,
                        hasSufix: false,
                      )),
                  const SizedBox(
                    height: gapHeight,
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
                                        color:
                                            const Color.fromRGBO(50, 74, 89, 1),
                                        width: 1.6)),
                                padding: const EdgeInsets.all(2),
                                child: isTesting
                                    ? const SizedBox()
                                    : Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: const Color.fromRGBO(
                                              50, 74, 89, 1),
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
                                        color:
                                            const Color.fromRGBO(50, 74, 89, 1),
                                        width: 1.6)),
                                padding: const EdgeInsets.all(2),
                                child: !isTesting
                                    ? const SizedBox()
                                    : Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: const Color.fromRGBO(
                                              50, 74, 89, 1),
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
                    height: gapHeight + 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 49,
                      child: Center(
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                          ),
                          child: registering
                              ? const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.8,
                                    color: Colors.white,
                                  ))
                              : const Text(
                                  'Shto biznesin',
                                  style: TextStyle(color: Colors.white),
                                ),
                          onPressed: () async {
                            var provider = Provider.of<BusinessProvider>(
                                context,
                                listen: false);

                            BusinessModel businessModel = BusinessModel(
                                name: businessName.text,
                                city: city.text,
                                country: country.text,
                                businessNumber: businessNumber.text,
                                phoneNumber: phoneNumber.text,
                                comment: comment.text,
                                startingDate: registeredDate.text,
                                active: true,
                                status: isTesting ? "testing" : "approved",
                                ownerName: ownerName.text);
                            setState(() {
                              registering = true;
                            });
                            await provider.addNewBusiness(
                              context,
                              businessModel,
                              username: userName.text,
                              email: email.text,
                              password: password.text,
                            );
                            setState(() {
                              registering = false;
                            });
                          },
                        ),
                      )),
                  const SizedBox(
                    height: gapHeight + 10,
                  ),
                ],
              ))
          // ... Existing form fields ...
        ],
      ),
    );
  }
}
