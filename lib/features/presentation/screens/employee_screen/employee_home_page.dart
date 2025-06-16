import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
import 'package:business_menagament/features/presentation/screens/employee_screen/edit_profile_screen.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool fetchingExpenses = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getEmployeeDetails();
    });

    super.initState();
  }

  getEmployeeDetails() async {
    setState(() => fetchingExpenses = true);

    var currentUser = Provider.of<EmployeeProvider>(context, listen: false);
    await currentUser.getEmployeeDetails(context);
    setState(() => fetchingExpenses = false);
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white, // <-- this
        surfaceTintColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: employeeCard(currentUser),
        centerTitle: false,
      ),
      body: Text(""),
    );
  }

  Widget employeeCard(EmployeeProvider currentUser) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xffe4e6e7),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.grey,size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser.getEmployee() == null
                              ? ""
                              : currentUser.getEmployee()!.user!.fullName!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(currentUser.getEmployee() == null
                            ? ""
                            :
                                currentUser.getEmployee()?.branchModel?.name ?? "")
                      ],
                    ),
                  ],
                ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    child: const Icon(
                      Icons.mode_edit_outline_outlined,
                      color: Color.fromRGBO(55, 159, 255, 1),
                      size: 20,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await currentUser.removeEmployee(context);
                    },
                    icon: const Icon(Icons.logout)),
                const SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
