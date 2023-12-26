import 'package:flutter/material.dart';



class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Textfield and Dropdown"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownVisible = !isDropdownVisible;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Arsyeja",),
                    Icon(Icons.arrow_drop_down,),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300), // Animation duration
              height: isDropdownVisible ? 320 : 0, // Set height based on visibility
              child: Container(
                  width:MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                   SizedBox(
                     height: 39,
                     child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide.none),hintText: 'Emertimi',contentPadding: EdgeInsets.all(10),filled: true,fillColor: Colors.white),),
                   ),
                    SizedBox(height: 10,),
                    SizedBox(height: 200,child: TextField(maxLines: 7,keyboardType: TextInputType.text,decoration: InputDecoration(fillColor: Colors.white,filled: true,hintText: 'Descriptipn',border: OutlineInputBorder(borderSide: BorderSide.none))),),
                    SizedBox(height: 10,),
                    SizedBox(height: 39,width:MediaQuery.of(context).size.width-30,child: ElevatedButton(onPressed: (){},child: Text('Add',style: TextStyle(color: Colors.black),),style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))))),),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
