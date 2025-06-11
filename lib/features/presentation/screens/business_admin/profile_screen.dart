import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userProvider = Provider.of<CurrentUser>(context,listen: false);
      fullName.text = userProvider.getUser()!.fullName!;
      username.text = userProvider.getUser()!.username!;
      email.text = userProvider.getUser()!.email!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<CurrentUser>(context);
    return SizedBox(
      width: getPhoneWidth(context),
      child: ListView(
        children: [
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.grey[200]!)
                ),
                child: const Icon(Icons.person,size: 30,),
              ),
            ],
          ),
           const SizedBox(height: 15,),
          SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: fullName,
                  // keyboardType: const TextInputType.numberWithOptions(
                  //     decimal: true), // Allow decimal numbers
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(RegExp(
                  //       r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                  // ],
                  decoration: InputDecoration(
                      hintText: 'Emri plote',
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
                          borderSide: const BorderSide(
                              color: Color(0xffebedef)))),
                ),
              )),
           const SizedBox(height: 15,),
          SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: username,
                  // keyboardType: const TextInputType.numberWithOptions(
                  //     decimal: true), // Allow decimal numbers
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(RegExp(
                  //       r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                  // ],
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
                          borderSide: const BorderSide(
                              color: Color(0xffebedef)))),
                ),
              )),
           const SizedBox(height: 15,),
          SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: email,
                  // keyboardType: const TextInputType.numberWithOptions(
                  //     decimal: true), // Allow decimal numbers
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(RegExp(
                  //       r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                  // ],
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
                          borderSide: const BorderSide(
                              color: Color(0xffebedef)))),
                ),
              )),
           const SizedBox(height: 15,),
          SizedBox(
              height: 49,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: password,
                  // keyboardType: const TextInputType.numberWithOptions(
                  //     decimal: true), // Allow decimal numbers
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(RegExp(
                  //       r'^\d+(\.\d{0,2})?$')), // Allow up to 2 decimal places
                  // ],
                  decoration: InputDecoration(
                      hintText: '*******',
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
                          borderSide: const BorderSide(
                              color: Color(0xffebedef)))),
                ),
              )),
           const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: (){
                showErroModal(context, "Te dhenat mund ti perditesoni ne versionin e radhes.",size: 17);
              },
              child: Container(
                  height: 47,
                  width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),child: Center(
                child: Text("Perditeso te dhenat",style: GoogleFonts.nunito(color: Colors.white),),
              ),),
            ),
          ),


        ],
      ),
    );
  }
}
