import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/features/presentation/providers/notification_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/single_notification.dart';
import 'package:flutter/material.dart';
import 'package:business_menagament/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  getNotifications(context) {
    var notifications =
        Provider.of<NotificationProvider>(context, listen: false);
    notifications.getNotificationsDB(context);
  }

  @override
  Widget build(BuildContext context) {
    var notifications = Provider.of<NotificationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getNotifications(context);
        },
        child: ListView.builder(
            itemCount: notifications.getNotifications().length,
            itemBuilder: (context, index) {
              var notification = notifications.getNotifications()[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SingleNotification(
                            notificationModel: notification,
                          )));
                },
                child: Container(
                  color: notification.read == false
                      ? const Color(0xff3f617e).withOpacity(0.3)
                      : Colors.transparent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[200]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: getPhoneWidth(context) - 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title!,
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 1,
                              ),
                              Text(
                                notification.message!,
                                style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
