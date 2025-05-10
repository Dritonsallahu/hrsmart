import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/features/models/notification_model.dart';
import 'package:business_menagament/features/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingleNotification extends StatefulWidget {
  final NotificationModel? notificationModel;
  const SingleNotification({Key? key, this.notificationModel})
      : super(key: key);

  @override
  State<SingleNotification> createState() => _SingleNotificationState();
}

class _SingleNotificationState extends State<SingleNotification> {
  var reading = false;
  readNotification(context) {
    var notifications =
        Provider.of<NotificationProvider>(context, listen: false);
    notifications.readNotificationDB(context, widget.notificationModel!.id);
  }

  @override
  void initState() {
    if(widget.notificationModel!.read == true){
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async  {
      setState(() {
        reading = true;
      });
     await  readNotification(context);

     setState(() {
       reading = false;
     });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.notificationModel!.title!,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: getPhoneWidth(context),
        child: reading ? const Center(child: CircularProgressIndicator(strokeWidth: 1.8,),):SingleChildScrollView(
            child: Text(
          widget.notificationModel!.message!,
          style: GoogleFonts.nunito(fontSize: 18),
        )),
      ),
    );
  }
}
