import 'package:business_menagament/core/consts/colors.dart';
import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/features/controllers/login_controller.dart';
import 'package:business_menagament/features/controllers/registration_controller.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:business_menagament/features/presentation/widgets/login_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/register_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({Key? key}) : super(key: key);

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController businessName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController comment = TextEditingController();

  PageController pageController = PageController(
    initialPage: 0,
  );
  bool authorizeSelected = true;
  bool authorizing = false;

  changePage(int index) {
    setState(() {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }

  authorize() async {
    setState(() => authorizing = true);
    LoginController loginController = LoginController();
    rememberCredentials();
    await loginController.authorize(context, username.text, password.text);
    setState(() => authorizing = false);
  }

  register(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lastRegistrationTime = prefs.getInt('lastRegistrationTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeDifference = currentTime - lastRegistrationTime;

    // Define the registration cooldown period (1 minute in milliseconds)
    const registrationCooldown = 30000; // 1 minute
    setState(() => authorizing = true);
    if (businessName.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        city.text.isEmpty) {
      showErroModal(context, "Ju lutem plotesoni te gjitha fushat e meposhtme!",
          size: 16);
      setState(() => authorizing = false);
      return;
    }
    RegistrationController registrationController = RegistrationController();

    if (timeDifference >= registrationCooldown) {
      // Allow registration and update the last registration time
      prefs.setInt('lastRegistrationTime', currentTime);
      var data = await registrationController.register(context, {
        "name": businessName.text,
        "city": city.text,
        "country": "Kosove",
        "phoneNumber": phoneNumber.text,
        "comment": comment.text,
        "status": "waiting",
        "active": true,
      });
      data.fold((failure) {
        showFailureModal(context, failure);
      }, (results) {
        setState(() {
          businessName.text = "";
          city.text = "";
          country.text = "";
          phoneNumber.text = "";
          comment.text = "";
        });
        showErroModal(
            context,
            "Te dhenat e biznesit jane pranuar me sukses.\nNe do t ju kontaktojme brenda 24 oreve per te verifikuar te dhenat, "
            "pastaj do te informoheni me detajisht rreth formes se qasjes ne aplikacion.",
            size: 12);
      });
      setState(() => authorizing = false);
    } else {
      setState(() => authorizing = false);
      showErroModal(context,
          "Nuk mund te regjistroheni menjehere, ju lutem nese keni bere ndonje gabim ne regjistrim, pas 30 sekondave mund te provoni prap.",
          size: 12);
      return false;
    }
  }

  rememberCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username", username.text);
    preferences.setString("password", password.text);
  }

  rememberMe() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var u = preferences.getString("username");
    var p = preferences.getString("password");
    if (u == null || p == null) {
    } else {
      setState(() {
        username.text = u;
        password.text = p;
      });
    }
  }

  @override
  void initState() {
    rememberMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(authorizing);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              width: getPhoneWidth(context),
              height: getPhoneHeight(context),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Hero(
                          tag: "caffe-icon-tag",
                          child: Image.asset(
                            "assets/logos/logo.png",
                            width: getPhoneWidth(context) - 150,

                          ),
                        ),
                        Text(
                          "MENAGJIMI I BURIMEVE NJEREZORE",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              color: defaultColor3),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: getPhoneWidth(context) - 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    authorizeSelected = true;
                                  });
                                  changePage(0);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: authorizeSelected
                                          ? defaultColor3
                                          : Colors.transparent),
                                  child: Center(
                                    child: Text(
                                      "Autorizohu",
                                      style: GoogleFonts.poppins(
                                          color: authorizeSelected
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    authorizeSelected = false;
                                  });
                                  changePage(1);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: authorizeSelected
                                          ? Colors.transparent
                                          : defaultColor3),
                                  child: Center(
                                    child: Text(
                                      "Abonohuni",
                                      style: GoogleFonts.poppins(
                                          color: authorizeSelected
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ExpandablePageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            if (index == 0) {
                              setState(() {
                                authorizeSelected = true;
                              });
                            } else {
                              setState(() {
                                authorizeSelected = false;
                              });
                            }
                          },
                          children: [
                            LoginWidgets(
                              username: username,
                              password: password,
                            ),
                            RegisterWidgets(
                              businessName: businessName,
                              city: city,
                              comment: comment,
                              phoneNumber: phoneNumber,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (authorizeSelected) {
                                  authorize();
                                } else {
                                  register(context);
                                }
                                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AdminHome(index: 0)));
                              },
                              child: AnimatedContainer(
                                width: getPhoneWidth(context) - 60,
                                duration: const Duration(milliseconds: 500),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: defaultColor3),
                                child: authorizing
                                    ? const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1.5,
                                            )),
                                      )
                                    : Center(
                                        child: Text(
                                          authorizeSelected
                                              ? "Hyr"
                                              : "Bej kerkese",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
