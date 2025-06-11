import 'package:hr_smart/core/consts/utils.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeListCard extends StatelessWidget {
  final EmployeeModel? employee;
  const EmployeeListCard({Key? key, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => EmployeeDetails(employeeModel: employee!,) ));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(19)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xffe4e6e7),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee!.user!.fullName!  ,
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff070707)),
                    ),
                    Text(
                      getDateFormat(employee!.user!.updatedAt!), // Use the formatted date if available
                      style: GoogleFonts.nunito(
                          fontSize: 13, color: const Color(0xff929cb1)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                  Row(
                  children: [
                    Text(
                      '- ${employee!.countTransactions().toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Color(0xffde0a0e)),
                    ),
                  ],
                ),
                Text(
                  "${employee!.salary!}€",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1560fb)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
