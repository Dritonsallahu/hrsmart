import 'package:business_menagament/controller/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//textediting controll add for any of textfield
//divide files login and signup.
//Signup po ashtu dhe login page,qfare do te bejme?
//pjesa modelimit te login po ashtu deh signup-it.
//pjesa controllerit te login po ashtu dhe signupit.
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  Color col1 = Colors.white;
  Color col2 = Colors.black;
  int index = 0; // Change the initial index here
  bool? isSelected = false;
  int ini = 0;
  String selected = '0';
  late final PageController _pageController = PageController(initialPage: ini);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController busName = TextEditingController();
  //-----

  var userController = TextEditingController();
  var passwordController = TextEditingController();

  // Future<void> postLogin() async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse('http://192.168.1.36/bmanagment/user/login.php'),
  //       body: {
  //         'user_name': userController.text.trim(),
  //         'user_password': passwordController.text.trim(),
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var resbody = jsonDecode(response.body);
  //
  //       if (resbody != null && resbody['success'] == true) {
  //         if (resbody['userData'] != null) {
  //           UserModel userinfo = UserModel.fromJson(resbody['userData']);
  //           Fluttertoast.showToast(msg: 'You logged in successfully');
  //           Future.delayed(Duration(milliseconds: 2000), () {
  //             Get.to(() => MainPage(index: 0));
  //           });
  //         } else {
  //           Fluttertoast.showToast(msg: 'User data is missing or null');
  //         }
  //       } else {
  //         Fluttertoast.showToast(msg: 'Your account credentials are incorrect');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Invalid response from server');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'An error occurred: ' + e.toString());
  //     print('An error occurred: ' + e.toString());
  //   }
  // }

  // Future<void> postLogin() async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse('http://192.168.1.36/bmanagment/user/login.php'),
  //       body: {
  //         'user_name': userController.text.trim(),
  //         'user_password': passwordController.text.trim(),
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var resbody = jsonDecode(response.body);
  //
  //       if (resbody['success'] == true) {
  //         var userData = resbody['userData']; // Extract userData from the response
  //
  //         if (userData != null) {
  //           UserModel userinfo = UserModel.fromJson(userData); // Use the fromJson factory constructor
  //           Fluttertoast.showToast(msg: 'You logged-in msg');
  //           Future.delayed(Duration(milliseconds: 2000), () {
  //             if (userinfo.category == 'thana') {
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(index: 0)));
  //             } else if (userinfo.category == 'menaxher') {
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage0()));
  //             }else if(userinfo.category == 'kamarier'){
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => KamarieriPAge(),));
  //             }
  //           });
  //         } else {
  //           Fluttertoast.showToast(msg: 'User data is missing or null');
  //         }
  //       } else {
  //         Fluttertoast.showToast(msg: 'Your account credentials are incorrect');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Invalid response from server');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'An error occurred: ' + e.toString());
  //     print('An error occurred: ' + e.toString());
  //   }
  // }

  // Future<void> postLogin() async {
  //   final response = await http.post(
  //     Uri.parse('http://localhost/bmanagment/user/login.php'), // Replace with your login API URL
  //     body: {
  //       'user_email': userController.text.trim(),
  //       'user_password': passwordController.text.trim(),
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseBody = json.decode(response.body);
  //     if (responseBody['success'] == true) {
  //       final userJson = responseBody['userData'];
  //       final userModel = UserModel.fromJson(userJson);
  //       // Handle successful login here
  //       print("Logged in user: ${userModel.username}");
  //     } else {
  //       // Handle incorrect credentials
  //       print("Incorrect credentials");
  //     }
  //   } else {
  //     // Handle API error
  //     print("API error");
  //   }
  // }
  final LoginController _loginController = LoginController();
  @override
  void initState() {
    super.initState();
    ini;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black45,
                BlendMode.darken,
              ),
              image: AssetImage("assets/background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/iconcoffe.png',
                width: 150,
                height: 160,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTabButton(0, 'Autorizohu'),
                    buildTabButton(1, 'Abonohuni'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      this.index = index;
                    });
                  },
                  children: [
                    SingleChildScrollView(
                      child: Form(
                          child: Container(
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 271,
                              height: 49,
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.black54,
                                items: const [
                                  DropdownMenuItem(
                                    value: "0",
                                    child: Text(
                                      'I work for',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(228, 213, 201, 1)),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "1",
                                    child: Text(
                                      'Business name A',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(228, 213, 201, 1)),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "2",
                                    child: Text(
                                      'Business name B',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(228, 213, 201, 1)),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selected = value as String;
                                  });
                                },
                                value: selected,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsetsDirectional.only(
                                            top: 10,
                                            bottom: 10,
                                            start: 20,
                                            end: 20),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(),
                                        borderRadius:
                                            BorderRadius.circular(25))),
                              ),
                            ),
                            SizedBox(
                                width: 271,
                                height: 49,
                                child: TextField(
                                  controller: userController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    hintText: "Username",
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(228, 213, 201, 1),
                                    ),
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                  ),
                                )),
                            SizedBox(
                              width: 271,
                              height: 49,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(228, 213, 201, 1),
                                          width: 1,
                                          style: BorderStyle.solid)),
                                  hintText: "Password",
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(228, 213, 201, 1)),
                                ),
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                'Create an account',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Color.fromRGBO(228, 213, 201, 1)),
                              ),
                              onPressed: () {
                                setState(() {
                                  _pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              },
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _loginController.postLogin(context,
                                      userController, passwordController);
                                },
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      )),
                    ),
                    signUp(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabButton(int tabIndex, String text) {
    return TextButton(
      onPressed: () {
        _pageController.animateToPage(
          tabIndex,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        height: 30,
        width: 110,
        decoration: BoxDecoration(
            color: index == tabIndex
                ? const Color.fromRGBO(228, 213, 201, 1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: index == tabIndex ? Colors.black : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget signUp() {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height - 281,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: 49,
                child: TextFormField(
                  controller: busName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill the field';
                    } else if (value.length < 6) {
                      return 'Name is too short';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: "Business name",
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(228, 213, 201, 1),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: 49,
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == "City") {
                      return 'You have to select a city';
                    }
                  },
                  dropdownColor: Colors.black45,
                  value: "City",
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 10, left: 20),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "City",
                      child:
                          Text("City", style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: "Ferizaj",
                      child: Text("Ferizaj",
                          style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: "Prishtine",
                      child: Text("Prishtine",
                          style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: "Gjilan",
                      child:
                          Text("Gjilan", style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: "Peje",
                      child:
                          Text("Peje", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (value) {
                    print("You selected $value");
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: 49,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 7) {
                      return "number is to short";
                    } else if (value.isEmpty) {
                      return "please fill the number";
                    }
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputAction: TextInputAction.send,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(228, 213, 201, 1),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    hintText: 'Tel',
                    contentPadding: const EdgeInsets.only(left: 20),
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(228, 213, 201, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width - 60,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please add comment';
                    }
                  },
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Add a comment',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(228, 213, 201, 1)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 35),
                child: Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          isSelected = value;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected!;
                        });
                      },
                      child: const Text(
                        'Terms of use',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Color.fromRGBO(228, 213, 201, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate the form before proceeding

                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginView(String username, String pwd) {
    return SingleChildScrollView(
      child: Form(
          child: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 271,
              height: 49,
              child: DropdownButtonFormField(
                dropdownColor: Colors.black54,
                items: const [
                  DropdownMenuItem(
                    value: "0",
                    child: Text(
                      'I work for',
                      style: TextStyle(color: Color.fromRGBO(228, 213, 201, 1)),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "1",
                    child: Text(
                      'Business name A',
                      style: TextStyle(color: Color.fromRGBO(228, 213, 201, 1)),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "2",
                    child: Text(
                      'Business name B',
                      style: TextStyle(color: Color.fromRGBO(228, 213, 201, 1)),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selected = value as String;
                  });
                },
                value: selected,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsetsDirectional.only(
                        top: 10, bottom: 10, start: 20, end: 20),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(25))),
              ),
            ),
            SizedBox(
                width: 271,
                height: 49,
                child: TextField(
                  controller: userController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: "Username",
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(228, 213, 201, 1),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                )),
            SizedBox(
              width: 271,
              height: 49,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(228, 213, 201, 1),
                          width: 1,
                          style: BorderStyle.solid)),
                  hintText: "Password",
                  contentPadding: const EdgeInsets.only(left: 20),
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(228, 213, 201, 1)),
                ),
              ),
            ),
            TextButton(
              child: const Text(
                'Create an account',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Color.fromRGBO(228, 213, 201, 1)),
              ),
              onPressed: () {
                setState(() {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _loginController.postLogin(
                      context, userController, passwordController);
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      )),
    );
  }
}
