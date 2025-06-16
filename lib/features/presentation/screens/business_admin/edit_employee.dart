import 'dart:convert';

import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/controllers/business_admin_controllers/business_admin_controller.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

class EditEmployeeScreen extends StatefulWidget {
  final EmployeeModel? employeeModel;
  const EditEmployeeScreen({Key? key, this.employeeModel}) : super(key: key);

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
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
  bool withSalary = false;

  editEmployee(context) async {
    setState(() => registering = true);

    EmployeeModel employeeModel = EmployeeModel(
      id: widget.employeeModel!.id,user: widget.employeeModel!.user,
        business: widget.employeeModel!.business!.id,
        allowedDebt: _allowedDebt.text,
        salary: _salary.text,
        withinSalary: withSalary,
        type: isManager ? "Manager" : "Waiter",
        startedDate: _startedDate.text,
        status: "active");

    var data = employeeModel.toJson();

    if (_fullName.text.isEmpty ||
        _username.text.isEmpty ||
        _email.text.isEmpty ||
        _allowedDebt.text.isEmpty ||
        _salary.text.isEmpty) {
      showErroModal(context, AppLocalizations.of(context)!.completeFields);
      setState(() => registering = false);
      return;
    }
    if(_email.text != widget.employeeModel!.user!.email){
      data['email'] = _email.text;
    }
    if(_fullName.text != widget.employeeModel!.user!.fullName){
      data['fullName'] = _fullName.text;
    }
    if(_username.text != widget.employeeModel!.user!.username){
      data['username'] = _username.text;
    }
    if(_allowedDebt.text != widget.employeeModel!.allowedDebt){
      data['allowed_debt'] = _allowedDebt.text;
    }
    if(_salary.text != widget.employeeModel!.salary){
    data['salary'] = _salary.text;
    }
    if(_password.text != widget.employeeModel!.salary && _password.text.isNotEmpty){
      data['password'] = _password.text;
    }
    BusinessAdminController businessAdminController = BusinessAdminController();
    var result =
        await businessAdminController.updateEmployeeProfile(context, jsonEncode(data));
    result.fold((failure) {
      showFailureModal(context, failure);
    }, (r) {
      Navigator.pop(context);
      Navigator.pop(context);
      Provider.of<BusinessProvider>(context,listen: false).updateEmployee(r);
      showErroModal(context, AppLocalizations.of(context)!.successUpdate);
      setState(() => registering = false);
    });
    setState(() => registering = false);
  }

  @override
  void initState() {
    setState(() {
      _fullName.text = widget.employeeModel!.user!.fullName!;
      _username.text = widget.employeeModel!.user!.username!;
      _email.text = widget.employeeModel!.user!.email!;
      _salary.text = widget.employeeModel!.salary!.toString();
      _allowedDebt.text = widget.employeeModel!.allowedDebt!.toString();
      _startedDate.text = widget.employeeModel!.startedDate!.toString();
      if (widget.employeeModel!.type == "Manager") {
        isManager = true;
      } else {
        isManager = false;
      }
      if (widget.employeeModel!.withinSalary == true) {
        withSalary = true;
      } else {
        withSalary = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKe,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "${widget.employeeModel!.user!.fullName}",
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
                          Text(AppLocalizations.of(context)!.waiter)
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
                          Text(AppLocalizations.of(context)!.manager)
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

                  controller: _fullName,
                  decoration:   InputDecoration(
                      fillColor: const Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: AppLocalizations.of(context)!.fullName,
                      border: const OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 49,
              child: TextFormField(

                  controller: _username,
                  decoration:   InputDecoration(
                      fillColor: const Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText:AppLocalizations.of(context)!.username,
                      border: const OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 49,
              child: TextFormField(

                  controller: _email,
                  decoration:   InputDecoration(
                      fillColor: const Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText:AppLocalizations.of(context)!.email,
                      border: const OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 49,
              child: TextFormField(
                  obscureText: true,

                  controller: _password,
                  decoration:   InputDecoration(
                      fillColor: const Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: AppLocalizations.of(context)!.password,
                      border: const OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 49,
              child: TextFormField(
                  keyboardType: TextInputType.number,

                  controller: _salary,
                  decoration:   InputDecoration(
                      fillColor: const Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: AppLocalizations.of(context)!.salary,
                      border: const OutlineInputBorder(borderSide: BorderSide.none))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 49,
              child: TextFormField(

                  controller: _allowedDebt,
                  decoration:   InputDecoration(
                      fillColor: const Color.fromRGBO(247, 248, 251, 1),
                      filled: true,
                      hintText: AppLocalizations.of(context)!.allowedMinus,
                      border: const OutlineInputBorder(borderSide: BorderSide.none))),
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
                    AppLocalizations.of(context)!.minus,
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
                                        color: const Color.fromRGBO(50, 74, 89, 1),
                                        width: 1.6)),
                                padding: const EdgeInsets.all(2),
                                child: !withSalary
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
                                Text( AppLocalizations.of(context)!.withPayment)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
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
                                        color: const Color.fromRGBO(50, 74, 89, 1),
                                        width: 1.6)),
                                padding: const EdgeInsets.all(2),
                                child: withSalary
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
                                Text( AppLocalizations.of(context)!.withoutPayment)
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
              height: 15 ,
            ),
            SizedBox(
                height: 49,
                width: MediaQuery.of(context).size.width - 40,
                child: TextFormField(

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

                      setState(() {
                        _startedDate.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {

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
                      editEmployee(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(50, 74, 89, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)))),
                  child: registering
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.6,
                          color: Colors.white,
                        )
                      :   Text(
                    AppLocalizations.of(context)!.update,
                          style: const TextStyle(color: Colors.white, fontSize: 17),
                        ),
                )),
          ],
        ),
      ),
    );
  }

}
