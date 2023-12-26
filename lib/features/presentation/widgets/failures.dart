import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/presentation/screens/credentials_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showFailureModal(BuildContext context,Failure f){
  var failure = f.runtimeType;
  if(failure == ServerFailure){
    getFailureModal(context, f.props.first.toString());
  }
  else if(failure == OfflineFailure){
    getFailureModal(context, f.props.first.toString());

  }
  else if(failure == DuplicateDataFailure){
    getFailureModal(context, f.props.first.toString());
  }
  else if(failure == WrongFailure){
    getFailureModal(context, f.props.first.toString());
  }
  else if(failure == UnauthorizedFailure){
    getFailureModal(context, f.props.first.toString(),logout: false);
  }
  else if(failure == EmptyDataFailure){
    getFailureModal(context, f.props.first.toString());
  }
  else if(failure == UnfilledDataFailure){
    getFailureModal(context, f.props.first.toString());
  }
  else{
  }


}

getFailureModal(BuildContext context,String messageFailure,{bool? logout,bool? shouldPop}){
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Container(
            width: getPhoneWidth(context),
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    messageFailure,textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: getPhoneWidth(context) * 0.5,
                        height: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Largo",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }).then((value) {          print(logout);
        if(logout != null && logout){

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const CredentialsScreen()), (route) => false);
        }
  });
}