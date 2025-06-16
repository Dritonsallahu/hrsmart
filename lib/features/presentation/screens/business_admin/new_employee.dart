import 'dart:convert';

import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/controllers/business_admin_controllers/business_admin_controller.dart';
import 'package:business_menagament/features/models/branch_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

class NewEmployee extends StatefulWidget {
  final bool? newPage;
  const NewEmployee({Key? key, required this.newPage}) : super(key: key);

  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _branchName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _allowedDebt = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKe = GlobalKey<ScaffoldState>();

  BranchModel? branchModel;

  final TextEditingController _startedDate = TextEditingController();
  bool isManager = false;
  bool registering = false;
  bool withSalary = false;

  addNewEmployee(context) async {
    setState(() => registering = true);
    var user = Provider.of<CurrentUser>(context, listen: false).getBusinessAdmin()!;
    EmployeeModel employeeModel = EmployeeModel(
        business: user.business,
        allowedDebt: _allowedDebt.text,
        branchModel: branchModel,
        salary: _salary.text,
        withinSalary: withSalary,
        type: isManager ? "manager" : "waiter",
        startedDate: _startedDate.text,
        status: "active");

    var data = employeeModel.toJson();
    data['fullName'] = _fullName.text;
    data['username'] = _username.text;
    data['email'] = _email.text;
    data['password'] = _password.text;
    data['active'] = true;
    var provider = Provider.of<BusinessProvider>(context, listen: false);
    var result = await provider.addNewEmployee(
      context,
      jsonEncode(data),
    );
    if (result == true) {
      setState(() {
        _fullName.text = "";
        _username.text = "";
        _email.text = "";
        _password.text = "";
        _salary.text = "";
        _allowedDebt.text = "";
      });
    }
    setState(() => registering = false);
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<CurrentUser>(context);
    return Scaffold(
      key: scaffoldKe,
      appBar: !widget.newPage!
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Punetor i ri",
                style: GoogleFonts.poppins(fontSize: 17),
              ),
              centerTitle: true,
            ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: !widget.newPage! ? 20 : 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isManager = false;
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
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isManager = true;
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
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            PullDownButton(
              itemBuilder: (context) =>
                  (userProvider.getBusinessAdmin()?.business?.branches ?? [])
                      .map((branch) =>
                          PullDownMenuItem(onTap: () {
                            branchModel = branch;
                            _branchName.text = branchModel?.name ?? "";
                            setState(() {});
                          }, title: branch.name!))
                      .toList(),
              buttonBuilder: (context, showMenu) => SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 49,
                child: TextFormField(
                    enabled: true,
                    readOnly: true,
                    onTap: showMenu,
                    controller: _branchName,
                    decoration:   InputDecoration(
                        fillColor: Color.fromRGBO(247, 248, 251, 1),
                        filled: true,
                        hintText: branchModel == null ? "Zgjidh filialin":branchModel?.name ?? "",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        suffixIcon: Icon(Icons.keyboard_arrow_down))),
              ),
            ),
            const SizedBox(
              height: 10,
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
                  controller: _fullName,
                  decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: "Emri dhe mbiemri",
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
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
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
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
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
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
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
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
                  controller: _salary,
                  decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: "Paga",
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 49,
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Minusi duhet te plotesohet";
                    }
                    return null;
                  },
                  controller: _allowedDebt,
                  decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: "Minusi lejuar mujor",
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minusi',
                    style: GoogleFonts.nunito(
                        fontSize: 15.5, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            withSalary = true;
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
                                child: !withSalary
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
                              const Text('Brenda rroges')
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            withSalary = false;
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
                                child: withSalary
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
                              const Text('Jasht rroges')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
                        _startedDate.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width - 40,
              child: GestureDetector(
                  onTap: () {
                    // if (registering) return;
                      addNewEmployee(context);

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
                      child: registering
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.6,
                                color: Colors.white,
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Shto puntorin",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ))),
            )
          ],
        ),
      ),
    );
  }

  Widget bilanci() {
    return Container(
      width: 80,
      height: 44,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(142, 255, 155, 0.44),
          borderRadius: BorderRadius.circular(10)),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "BILANCI",
              style: TextStyle(
                  color: Color.fromRGBO(17, 62, 33, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: Text(
              "100€",
              style: TextStyle(
                  color: Color.fromRGBO(51, 229, 69, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  String failureResponse(Failure failure) {
    if (failure is ServerFailure) {
      return "Diqka shkoi gabim!";
    } else if (failure is DuplicateDataFailure) {
      return "Keto te dhena ekzistojne!";
    } else if (failure is EmptyDataFailure) {
      return "Ju lutem plotesoni te dhenat!";
    } else if (failure is OfflineFailure) {
      return "Keni problem me internet";
    } else {
      return "Ju lutem provoni perseri";
    }
  }

  showErroModal(String errorTitle) {
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
                      errorTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Largo"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
