// import 'package:hr_smart/view/business_admin_navigation.dart';
// import 'package:flutter/material.dart';
//
// class LoginUser extends StatefulWidget {
//   const LoginUser({Key? key}) : super(key: key);
//
//   @override
//   State<LoginUser> createState() => _LoginUserState();
// }
//
// class _LoginUserState extends State<LoginUser> {
//   Color col1 = Colors.white;
//   Color col2 = Colors.black;
//   int index = 0;
//   String? selected;
//   @override
//   void initState() {
//     index; // TODO: implement initState
//     super.initState();
//     selected = '1';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//             child: DecoratedBox(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 colorFilter: ColorFilter.mode(
//                     Colors.black45, BlendMode.darken),
//                 image: AssetImage("assets/background.jpeg"),
//                 fit: BoxFit.cover),
//           ),
//           child: DefaultTabController(
//             initialIndex: index,
//             length: 2,
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Image.asset(
//                   'assets/iconcoffe.png',
//                   width: 150,height: 160,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 30, right: 30),
//                   child: TabBar(
//                     overlayColor:
//                         MaterialStateProperty.all<Color>(Colors.white),
//                     indicator: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: Color.fromRGBO(228, 213, 201, 1),
//                         border: Border.all(color: Colors.transparent)),
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     labelColor: Colors.black,
//                     dividerColor: Colors.transparent,
//                     onTap: (tabIndexx) {
//                       setState(() {
//                         index = tabIndexx;
//                       });
//                     },
//                     tabs: [
//                       Text('Autorizohu',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w500,
//                               color: index == 0 ? Colors.black : Colors.white),
//                           textAlign: TextAlign.center),
//                       Text(
//                         'Abonohuni',
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w500,
//                             color: index == 1 ? Colors.black : Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 30),
//
//               loginView()
//               ],
//             ),
//           ),
//         )));
//   }
//
//   Widget TextEditing(String opsion) {
//     return Text(
//       opsion,
//       style: TextStyle(
//         fontSize: 17,
//         fontWeight: FontWeight.w500,
//       ),
//       textAlign: TextAlign.center,
//     );
//   }
//   Widget loginView() {
//     return
//       Expanded(
//         child:Form(
//             child: Container(
//               height: 300,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 271,
//                     height: 49,
//                     child: DropdownButtonFormField(
//                       dropdownColor: Colors.black,
//                       items: [
//                         DropdownMenuItem(
//                           child: Text(
//                             'I work for',
//                             style: TextStyle(
//                                 color: Color.fromRGBO(228, 213, 201, 1)),
//                           ),
//                           value: "0",
//                         ),
//                         DropdownMenuItem(
//                           child: Text(
//                             'Business name A',
//                             style: TextStyle(
//                                 color: Color.fromRGBO(228, 213, 201, 1)),
//                           ),
//                           value: "1",
//                         ),
//                         DropdownMenuItem(
//                           child: Text(
//                             'Business name B',
//                             style: TextStyle(
//                                 color: Color.fromRGBO(228, 213, 201, 1)),
//                           ),
//                           value: "2",
//                         ),
//                       ],
//                       onChanged: (val) {
//                         setState(() {
//                           selected = val as String;
//                         });
//                       },
//                       value: selected,
//                       decoration: InputDecoration(
//
//                           contentPadding: EdgeInsetsDirectional.only(top: 10,bottom: 10,start: 20,end: 20),
//                           border: OutlineInputBorder(borderSide: BorderSide(),borderRadius: BorderRadius.circular(25))),
//                     ),
//                   ),
//                   SizedBox(
//                       width: 271,
//                       height: 49,
//                       child: TextField(
//                         style: TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                           hintText: "Username",
//                           hintStyle: TextStyle(
//                             color: Color.fromRGBO(228, 213, 201, 1),
//                           ),
//                           labelStyle: TextStyle(color: Colors.white),contentPadding: EdgeInsets.only(left: 20),),
//                       )),
//                   SizedBox(
//                     width: 271,
//                     height: 49,
//                     child: TextField(obscureText: true,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25), borderSide: BorderSide(
//                             color: Color.fromRGBO(228, 213, 201, 1),
//                             width: 1,
//                             style: BorderStyle.solid)),
//                         hintText: "Password",contentPadding: EdgeInsets.only(left: 20),
//                         hintStyle: TextStyle(
//                             color: Color.fromRGBO(228, 213, 201, 1)),
//                       ),
//                     ),
//                   ),
//                   TextButton(child: Text('Create an account',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 14,
//                         color: Color.fromRGBO(228, 213, 201, 1)),),onPressed: (){},),
//                   ElevatedButton(
//                       onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => MainPage0()));},
//                       child: Text(
//                         'Log in',
//                         style: TextStyle(color: Colors.black),
//                       ))
//                 ],
//               ),
//             )));
//   }
// }
