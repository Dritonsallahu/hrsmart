import 'dart:io';

import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/widgets/employee_list_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeesCardListScreen extends StatefulWidget {
  const EmployeesCardListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesCardListScreen> createState() =>
      _EmployeesCardListScreenState();
}

class _EmployeesCardListScreenState extends State<EmployeesCardListScreen> {
  final GlobalKey<ScaffoldState> scaffKe = GlobalKey<ScaffoldState>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  TextEditingController dateinput = TextEditingController();

  TextEditingController search = TextEditingController();

  List<EmployeeModel> employees = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getEmployees(true);
    });

    super.initState();
  }

  getEmployees(bool first) {
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    if (first) {
      if (businessProvider.getEmployeeList().isEmpty) {
        businessProvider.getAllEmployees(context);
      }
    } else {
      businessProvider.getAllEmployees(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: businessProvider.getEmployeeList().isEmpty
          ? RefreshIndicator(
        onRefresh: () async {
          getEmployees(false);
        },
            child: ListView(
              children: [
                Center(
                    child: Text(AppLocalizations.of(context)!.noEmployee),
                  ),
              ],
            ),
          )
          : ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [
                index == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.employeeNumber,
                              style: GoogleFonts.inter(fontSize: 18),
                            ),
                            Text(
                                "${businessProvider.getEmployeeList().length}"),
                          ],
                        ),
                      )
                    : const SizedBox(),
                EmployeeListCard(
                    employee: businessProvider.getEmployeeList()[index]),
              ],
            ),
            itemCount: businessProvider.getEmployeeList().length,
          ),
    );
  }
}
