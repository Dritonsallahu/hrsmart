import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/storage/business_admin_storage.dart';
import 'package:business_menagament/features/controllers/business_admin_controllers/business_profile_controller.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business_menagament/l10n/app_localizations.dart';

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

  bool updating = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userProvider = Provider.of<CurrentUser>(context, listen: false);
      fullName.text = userProvider.getBusinessAdmin()!.user!.fullName!;
      username.text = userProvider.getBusinessAdmin()!.user!.username!;
      email.text = userProvider.getBusinessAdmin()!.user!.email!;
    });
    super.initState();
  }

  editBusinessProfile(context) async {
    setState(() => updating = true);
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    BusinessAdminStorage persistentStorage = BusinessAdminStorage();
    var userAdmin = currentUser.getBusinessAdmin();

    var data = {};
    data['id'] = currentUser.getBusinessAdmin()!.id;
    if (username.text.isNotEmpty) data['username'] = username.text;
    if (email.text.isNotEmpty) data['email'] = email.text;
    if (password.text.isNotEmpty) data['password'] = password.text;
    BusinessProfileController businessProfileController =
        BusinessProfileController();
    var result = await businessProfileController.updateProfile(context, data);
    result.fold((failure) {
      setState(() => updating = false);
      showFailureModal(context, failure);
    }, (r) {
      if (username.text.isNotEmpty) userAdmin!.user!.username = username.text;
      if (email.text.isNotEmpty) userAdmin!.user!.email = email.text;
      persistentStorage.addNewAdminUser(userAdmin!);
      setState(() => updating = false);
      showErroModal(context, "Te dhenat u perdiesuan me sukses");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profili",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: getPhoneWidth(context),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey[200]!)),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
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
                            borderSide:
                                const BorderSide(color: Color(0xffebedef)))),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
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
                            borderSide:
                                const BorderSide(color: Color(0xffebedef)))),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
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
                            borderSide:
                                const BorderSide(color: Color(0xffebedef)))),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
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
                            borderSide:
                                const BorderSide(color: Color(0xffebedef)))),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  editBusinessProfile(context);
                },
                child: Container(
                  height: 47,
                  width: MediaQuery.of(context).size.width,
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
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.update,
                      style: GoogleFonts.nunito(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
