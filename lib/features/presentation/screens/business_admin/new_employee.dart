import 'dart:convert';

import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/features/controllers/business_admin_controllers/business_admin_controller.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewEmployee extends StatefulWidget {
  final bool? newPage;
  const NewEmployee({Key? key, required this.newPage}) : super(key: key);

  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _allowedDebt = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKe = GlobalKey<ScaffoldState>();

  final TextEditingController _startedDate = TextEditingController();
  bool isManager = false;
  bool registering = false;

  addNewEmployee(context) async {
    setState(() => registering = true);
    var user = Provider.of<CurrentUser>(context, listen: false).getUser()!;
    SharedPreferences preferences = await SharedPreferences.getInstance();
      EmployeeModel employeeModel = EmployeeModel(
          business: user.businessModel!.id,
          allowedDebt: _allowedDebt.text,
          salary: _salary.text,type: isManager ? "manager" : "waiter",
          startedDate: _startedDate.text,
          status: "active");

      var data = employeeModel.toJson();
      data['fullName'] = _fullName.text;
      data['username'] = _username.text;
      data['email'] = _email.text;
      data['password'] = _password.text;
      data['active'] = true;
      BusinessAdminController businessAdminController =
          BusinessAdminController();
      var result = await businessAdminController.addNewEmployee(jsonEncode(data),);
      result.fold((failure) {
        showErroModal(failureResponse(failure));
      }, (r) {
        setState(() {
          _fullName.text = "";
          _username.text = "";
          _email.text = "";
          _password.text = "";
          _salary.text = "";
          _allowedDebt.text = "";
        });
        showErroModal("Te dhenat u shtuan me sukses");
        setState(() => registering = false);
      });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKe,
      appBar: !widget.newPage! ? null:AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Punetor i ri",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
             SizedBox(height: !widget.newPage! ? 20:0,),
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
              height: 10,
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
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _startedDate.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () {
                    if(!registering){
                      addNewEmployee(context);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(50, 74, 89, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)))),
                  child: registering ? const CircularProgressIndicator(strokeWidth: 1.6,color: Colors.white,):const Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                )),
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

  showErroModal(String errorTitle){
    showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: Container(
          width: getPhoneWidth(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(errorTitle,textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black),),
                const SizedBox(height: 20,),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Largo"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
