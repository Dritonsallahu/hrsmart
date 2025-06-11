import 'dart:convert';

import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/features/controllers/business_admin_controllers/business_admin_controller.dart';
import 'package:hr_smart/features/controllers/employee_controllers/employe_profile_controller.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/providers/employee_provider.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:hr_smart/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final EmployeeModel? employeeModel;
  const EditProfileScreen({Key? key, this.employeeModel}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _allowedDebt = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKe = GlobalKey<ScaffoldState>();

  final TextEditingController _startedDate = TextEditingController();
  bool isManager = false;
  bool updating = false;

  editEmployee(context) async {
    setState(() => updating = true);
    var currentUser = Provider.of<EmployeeProvider>(context, listen: false).getUser()!;
    SharedPreferences preferences = await SharedPreferences.getInstance();


    var data = {};
    data['id'] = currentUser.user!.id;
    data['username'] = _username.text;
    data['email'] = _email.text;
    data['password'] = _password.text;
    // showErroModal(context,
    //     "Perditesimi nuk mund te behet!\n Ju lutem prisni deri ne njoftimin e radhes.");
    EmployeeProfileController employeeProfileController =
    EmployeeProfileController();
    var result = await employeeProfileController.updateProfile(context, data);
    result.fold((failure) {
      setState(() => updating = false);
      showFailureModal(context, failure);
    }, (r) {
      setState(() => updating = false);
         Navigator.pop(context);
      showErroModal(context, "Te dhenat u perdiesuan me sukses");

    });

  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var currentUser = Provider.of<EmployeeProvider>(context, listen: false);
      setState(() {
        _fullName.text = currentUser.getUser()!.user!.fullName!;
        _username.text = currentUser.getUser()!.user!.username!;
        _email.text = currentUser.getUser()!.user!.email!;
        _salary.text = "${currentUser.getUser()!.salary!}€";
        _allowedDebt.text =
            "${currentUser.getUser()!.allowedDebt!}€";
        _startedDate.text = currentUser.getUser()!.startedDate!.toString();
        if (currentUser.getUser()!.type == "Manager") {
          isManager = true;
        } else {
          isManager = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      key: scaffoldKe,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "${currentUser.getUser()!.user!.fullName}",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            //1.form
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
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
                        child: isManager
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
                      const Text('Kamarier')
                    ],
                  ),
                ),
                Container(
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
                        child: !isManager
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
                      const Text('Manager')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emri i plote",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 49,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Emri dhe mbiemri duhet te plotesohen.';
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: _fullName,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(247, 248, 251, 1),
                          filled: true,
                          hintText: "Emri dhe mbiemri",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none))),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emri i perdoruesit",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 49,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username duhet te plotesohet.";
                        }
                        return null;
                      },
                      controller: _username,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(247, 248, 251, 1),
                          filled: true,
                          hintText: "Username",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none))),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adresa elektronike",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 49,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email duhet te plotesohet.";
                        }
                        return null;
                      },
                      controller: _email,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(247, 248, 251, 1),
                          filled: true,
                          hintText: "Email",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none))),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fjalekalimi",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 49,
                  child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password duhet te plotesohet.";
                        }
                        return null;
                      },
                      controller: _password,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(247, 248, 251, 1),
                          filled: true,
                          hintText: "Password",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none))),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pagesa mujore",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 49,
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Paga duhet te plotesohet.";
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: _salary,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(247, 248, 251, 1),
                          filled: true,
                          hintText: "Paga",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none))),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Borgji i lejuar deri ne:",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 49,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Minusi duhet te plotesohet";
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: _allowedDebt,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(247, 248, 251, 1),
                          filled: true,
                          hintText: "Minusi lejuar mujor",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none))),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data e fillimit te punes",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(
                    height: 49,
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Plotesoni daten";
                        }
                        return null;
                      },
                      controller:
                          _startedDate, //editing controller of this TextField
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon:
                              Icon(Icons.arrow_drop_down), //icon of text field

                          hintText: "00/00/0000",
                          filled: true,
                          fillColor: Color.fromRGBO(235, 235, 235, 1),
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 24, 51, 0.22),
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {},
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (!updating) {
                      editEmployee(context);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(50, 74, 89, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)))),
                  child: updating
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.6,
                          color: Colors.white,
                        )
                      : const Text(
                          "Perditeso",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                )),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
